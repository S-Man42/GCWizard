import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';
import 'package:image/image.dart' as img;


Future <Map<String, dynamic>> analyseImageAsync(dynamic jobData) async {
  if (jobData == null) {
    jobData.sendAsyncPort.send(null);
    return null;
  }

  var output = await analyseImage(jobData.parameters, sendAsyncPort: jobData.sendAsyncPort);

  if (jobData.sendAsyncPort != null) jobData.sendAsyncPort.send(output);

  return output;
}

Future <Map<String, dynamic>> analyseImage(Uint8List bytes, {SendPort sendAsyncPort}) async {
  try {
    var progress = 0;
    final decoder = img.findDecoderForData(bytes);

    if (decoder == null)
      return null;

    var out = Map<String, dynamic>();
    var animation = decoder.decodeAnimation(bytes);
    int progressStep = max(animation.length ~/ 100, 1); // 100 steps

    var imageList = <Uint8List>[];
    var durations = <int>[];
    var extension = getFileType(bytes);

    animation?.frames.forEach((image) {
      switch (extension) {
        case '.png':
          imageList.add(img.encodePng(image));
          break;
        default:
          imageList.add(img.encodeGif(image));
          break;
      }
      durations.add(image.duration);
      progress++;
      if (sendAsyncPort != null && (progress % progressStep == 0)) {
        sendAsyncPort.send({'progress': progress / animation.length});
      }
    });
    out.addAll({"animation": animation});
    out.addAll({"images": imageList});
    out.addAll({"durations": durations});

    return out;
  } on Exception {
    return null;
  }
}

Future<Uint8List> createZipFile(String fileName, List<Uint8List> imageList) async {
  try {
    String tmpDir = (await getTemporaryDirectory()).path;
    var counter = 0;
    var zipPath = '$tmpDir/gcwizardtmp.zip';
    var pointIndex = fileName.lastIndexOf('.');
    var extension = getFileType(imageList[0]);
    if (pointIndex > 0)
      fileName = fileName.substring(0, pointIndex);

    var encoder = ZipFileEncoder();
    encoder.create(zipPath);

    for (Uint8List imageBytes in imageList) {
      counter++;
      var fileNameZip = '$fileName' + '_$counter$extension';
      var tmpPath = '$tmpDir/$fileNameZip';
      if (File(tmpPath).existsSync())
        File(tmpPath).delete();

      File imageFileTmp = new File(tmpPath);
      imageFileTmp = await imageFileTmp.create();
      imageFileTmp = await imageFileTmp.writeAsBytes(imageBytes);

      encoder.addFile(imageFileTmp, fileNameZip);
      imageFileTmp.delete();
    };

    encoder.close();

    var bytes = File(encoder.zip_path).readAsBytesSync();
    await File(encoder.zip_path).delete();

    return bytes;
  } on Exception {
    return null;
  }
}



