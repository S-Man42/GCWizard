import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
//import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;


Future <Map<String, dynamic>> analyseGifAsync(dynamic jobData) async {
  if (jobData == null) {
    jobData.sendAsyncPort.send(null);
    return null;
  }

  var output = await analyseGif(jobData.parameters, sendAsyncPort: jobData.sendAsyncPort);

  if (jobData.sendAsyncPort != null) jobData.sendAsyncPort.send(output);

  return output;
}

Future <Map<String, dynamic>> analyseGif(Uint8List bytes, {SendPort sendAsyncPort}) async {
  var progress = 0;
  final decoder = img.findDecoderForData(bytes);

  if (decoder == null)
    return null;

  var out = Map<String, dynamic>();
  var animation = decoder.decodeAnimation(bytes);
  int progressStep = max(animation.length ~/ 100, 1); // 100 steps

  var imageList = <Uint8List>[];
  var durations = <int>[];
  animation?.frames.forEach((image) {
    imageList.add(img.encodeGif(image));
    durations.add(image.duration);
    progress++;
    if (sendAsyncPort != null && (progress % progressStep == 0)) {
      sendAsyncPort.send({'progress': progress / animation.length});
    }
  });
  out.addAll({"animation": animation});

  // out.addAll({"image": bytes});
  out.addAll({"images": imageList});
  out.addAll({"durations": durations});
  //out.addAll({"decoder": durations});


  return out;
}

Future<Uint8List> createZipFile(String fileName, List<Uint8List> imageList) async {
  try {
    String tmpDir = (await getTemporaryDirectory()).path;
    var counter = 0;
    var zipPath = '$tmpDir/gcwizardtmp.zip';

    var encoder = ZipFileEncoder();
    encoder.create(zipPath);

    for (Uint8List imageBytes in imageList) {
    //await imageList.forEach( async (imageBytes)  {
      counter++;
      var fileNameZip = fileName + '_'+ counter.toString();
      var tmpPath = '$tmpDir/' + fileNameZip;
      if (File(tmpPath).existsSync())
        File(tmpPath).delete();

      File temp = new File(tmpPath);
      temp = await temp.create();
      temp = await temp.writeAsBytes(imageBytes);

      encoder.addFile(temp, fileNameZip);
      temp.delete();
    };
    
    encoder.close();

    var bytes = File(encoder.zip_path).readAsBytesSync();
    await File(encoder.zip_path).delete();

    return bytes;
  } on Exception {
    return null;
  }
}



