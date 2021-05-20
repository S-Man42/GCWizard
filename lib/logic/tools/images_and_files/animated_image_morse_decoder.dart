import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/morse.dart';
import 'package:tuple/tuple.dart';
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

  List<Uint8List> images = output["images"];
  for (var i = 0; i < images.length; i++) {
    print("inHash " + i.toString() + " " + images[i].hashCode.toString());
  };

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
    var filteredList = <List<int>>[];

    animation?.frames.forEach((image) {
      durations.add(image.duration);
    });

    // overrides also durations
    animation.frames = linkSameImages(animation.frames);

    if (animation != null) {
      for (int i = 0; i < animation.frames.length; i++) {
        var index = _checkSameHash(animation.frames, i);
        if (index < 0) {
          print ("add frame "  + i.toString());
          switch (extension) {
            case '.png':
              imageList.add(img.encodePng(animation.frames[i]));
              break;
            default:
              imageList.add(img.encodeGif(animation.frames[i]));
              break;
          }
        } else {
          print ("reuse frame " + i.toString() +" " + index.toString());
          imageList.add(imageList[index]);
        }

        progress++;
        if (sendAsyncPort != null && (progress % progressStep == 0)) {
          sendAsyncPort.send({'progress': progress / animation.length});
        }
      }
    }

    for (var i=0; i< imageList.length; i++) {
      filteredList = _filterImages(filteredList, i, imageList);
      //print("inHash " + i.toString() + " " + imageList[i].hashCode.toString());
    };

    //out.addAll({"animation": animation});
    out.addAll({"images": imageList});
    out.addAll({"durations": durations});
    out.addAll({"imagesFiltered": filteredList});

    return out;
  } on Exception {
    return null;
  }
}

List<List<int>> _filterImages(List<List<int>> filteredList, int imageIndex, List<Uint8List> imageList) {
  const toler = 2;
  for (var i=0; i < filteredList.length; i++ ) {
    var compareImage = imageList[filteredList[i].first];
    var image = imageList[imageIndex];
    if (compareImage.length != image.length)
      continue;

    // byte compare
    for (var b=0; b < compareImage.length; b++ ) {
      if ((compareImage[b] - image[b]).abs() > toler)
        continue;
    }

    filteredList[i].add(imageIndex);
    return filteredList;
  }

  // not found -> new List
  var newList = <int>[];
  newList.add(imageIndex);
  filteredList.add( newList);

  return filteredList;
}

String decodeMorseCode(List<int> durations, List<bool> onSignal) {
  var timeList = _buildTimeList(durations, onSignal);
  print(timeList.length);
  var timeBase = _foundTimeBase(timeList);

  if (timeBase == null)
    return null;
print("timeBase: " + timeBase.toString());
  var out = '';
  timeList.forEach((element) {
    if (element.item1)
      out += ((element.item2/ timeBase) > 1.5) ? '-' : '.'; //2
    else
      if((element.item2/ timeBase) >= 4) //5
        out  += "   ";
      else if((element.item2/ timeBase) >= 2) //3
        out += " ";
  });

  print(out);
  return decodeMorse(out);
}

List<Tuple2<bool, int>> _buildTimeList(List<int> durations, List<bool> onSignal) {
  var timeList = <Tuple2<bool, int>>[];
  var i = 0;

  if (durations == null || onSignal == null || durations.length != onSignal.length)
    return null;

  if (durations.length == 0)
    return timeList;

  timeList.add(Tuple2<bool, int>(onSignal[i], durations[i]));
  for (i = 1; i < durations.length; i++) {
    if (onSignal[i - 1] != onSignal[i])
      timeList.add(Tuple2<bool, int>(onSignal[i], durations[i]));
    else
      // same signal -> add
      timeList.last = Tuple2<bool, int>(onSignal[i], timeList.last.item2 + durations[i]);
  };
  return timeList;
}

int _foundTimeBase(List<Tuple2<bool, int>> timeList) {
  if (timeList == null || timeList.length == 0)
    return null;

  var minTime = 999999999;
  timeList.forEach((element) {
    if (element.item1 && element.item2 < minTime && element.item2 > 0)
      minTime = element.item2;

    print(minTime);
  });
  if (minTime == 999999999)
    return null;

  return minTime;
}

List<img.Image> linkSameImages(List<img.Image> images) {
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

bool compareImages(Uint8List image1, Uint8List image2) {
  if (image1.length != image2.length)
    return false;

  for (int i = 0; i < image1.length; i++)
    if (image1[i] != image2[i])
      return false;

  return true;
}

int _checkSameHash(List<img.Image> list, int maxSeearchIndex)
{
  var compareHash = list[maxSeearchIndex].hashCode;
  for (int i = 0; i < maxSeearchIndex; i++)
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



