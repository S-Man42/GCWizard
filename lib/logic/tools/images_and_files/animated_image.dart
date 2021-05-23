import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive_io.dart';
import 'package:image/image.dart' as img;

Future<Map<String, dynamic>> analyseImageAsync(dynamic jobData) async {
  if (jobData == null) {
    jobData.sendAsyncPort.send(null);
    return null;
  }

  var output = await analyseImage(jobData.parameters, sendAsyncPort: jobData.sendAsyncPort);

  if (jobData.sendAsyncPort != null) jobData.sendAsyncPort.send(output);

  return output;
}

Future<Map<String, dynamic>> analyseImage(Uint8List bytes, {SendPort sendAsyncPort}) async {
  try {
    var progress = 0;
    final decoder = img.findDecoderForData(bytes);

    if (decoder == null) return null;

    var out = Map<String, dynamic>();
    var animation = decoder.decodeAnimation(bytes);
    int progressStep = max(animation.length ~/ 100, 1); // 100 steps

    var imageList = <Uint8List>[];
    var durations = <int>[];
    var linkList = <int>[];
    var extension = getFileType(bytes);

    if (animation != null) {
      animation?.frames.forEach((image) {
        durations.add(image.duration);
      });

      // overrides also durations
      animation.frames = _linkSameImages(animation.frames);

      for (int i = 0; i < animation.frames.length; i++) {
        var index = _checkSameHash(animation.frames, i);
        if (index < 0) {
          switch (extension) {
            case '.png':
              imageList.add(img.encodePng(animation.frames[i]));
              break;
            default:
              imageList.add(img.encodeGif(animation.frames[i]));
              break;
          }
          linkList.add(i);
        } else {
          imageList.add(imageList[index]);
          linkList.add(index);
        }

        progress++;
        if (sendAsyncPort != null && (progress % progressStep == 0)) {
          sendAsyncPort.send({'progress': progress / animation.length});
        }
      }
    }

    out.addAll({"images": imageList});
    out.addAll({"durations": durations});
    out.addAll({"linkList": linkList});

    return out;
  } on Exception {
    return null;
  }
}

List<img.Image> _linkSameImages(List<img.Image> images) {
  for (int i = 1; i < images.length; i++) {
    for (int x = 0; x < i; x++) {
      if (_checkSameHash(images, x) >= 0)
        continue;

      if (compareImages(images[i].getBytes(), images[x].getBytes())) {
        images[i] = images[x];
        break;
      }
    }
  }

  return images;
}

bool compareImages(Uint8List image1, Uint8List image2, {toler = 0}) {
  if (image1.length != image2.length)
    return false;

  for (int i = 0; i < image1.length; i++)
    if ((image1[i] - image2[i]).abs() > toler)
      return false;

  return true;
}

int _checkSameHash(List<img.Image> list, int maxSearchIndex) {
  var compareHash = list[maxSearchIndex].hashCode;
  for (int i = 0; i < maxSearchIndex; i++)
    if (list[i].hashCode == compareHash)
      return i;

  return -1;
}

Future<Uint8List> createZipFile(String fileName, List<Uint8List> imageList) async {
  try {
    String tmpDir = (await getTemporaryDirectory()).path;
    var counter = 0;
    var zipPath = '$tmpDir/gcwizardtmp.zip';
    var pointIndex = fileName.lastIndexOf('.');
    var extension = getFileType(imageList[0]);
    if (pointIndex > 0) fileName = fileName.substring(0, pointIndex);

    var encoder = ZipFileEncoder();
    encoder.create(zipPath);

    for (Uint8List imageBytes in imageList) {
      counter++;
      var fileNameZip = '$fileName' + '_$counter$extension';
      var tmpPath = '$tmpDir/$fileNameZip';
      if (File(tmpPath).existsSync()) File(tmpPath).delete();

      File imageFileTmp = new File(tmpPath);
      imageFileTmp = await imageFileTmp.create();
      imageFileTmp = await imageFileTmp.writeAsBytes(imageBytes);

      encoder.addFile(imageFileTmp, fileNameZip);
      imageFileTmp.delete();
    }
    ;

    encoder.close();

    var bytes = File(encoder.zip_path).readAsBytesSync();
    await File(encoder.zip_path).delete();

    return bytes;
  } on Exception {
    return null;
  }
}
