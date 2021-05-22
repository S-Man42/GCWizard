import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/morse.dart';
import 'package:gc_wizard/logic/tools/images_and_files/animated_image_morse_code.dart' as animated_gif;
import 'package:tuple/tuple.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
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

    if (decoder == null)
      return null;

    var out = Map<String, dynamic>();
    var animation = decoder.decodeAnimation(bytes);
    int progressStep = max(animation.length ~/ 100, 1); // 100 steps

    var imageList = <Uint8List>[];
    var durations = <int>[];
    var linkList = <int>[];
    var extension = getFileType(bytes);
    var filteredList = <List<int>>[];

    animation?.frames.forEach((image) {
      durations.add(image.duration);
    });

    // overrides also durations
    animation.frames = _linkSameImages(animation.frames);

    if (animation != null) {
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

    for (var i=0; i< imageList.length; i++) {
      filteredList = _filterImages(filteredList, i, imageList);
      //print("inHash " + i.toString() + " " + imageList[i].hashCode.toString());
    };

    out.addAll({"images": imageList});
    out.addAll({"durations": durations});
    out.addAll({"imagesFiltered": filteredList});
    out.addAll({"linkList": linkList});

    return out;
  } on Exception {
    return null;
  }
}

Future<Uint8List> createImageAsync(dynamic jobData) async {
  if (jobData == null) {
    jobData.sendAsyncPort.send(null);
    return null;
  }

  var output = await createImage(jobData.parameters.item1, jobData.parameters.item2, jobData.parameters.item3, jobData.parameters.item4, sendAsyncPort: jobData.sendAsyncPort);

  if (jobData.sendAsyncPort != null) jobData.sendAsyncPort.send(output);

  return output;
}

Future<Uint8List> createImage(Uint8List highImage, Uint8List lowImage, String input, int ditDuration, {SendPort sendAsyncPort}) async {
  input = encodeMorse(input);
  if (input == null || input == '') return null;
  if (highImage == null || lowImage == null) return null;
  if (ditDuration <= 0) return null;

  try {
    var _highImage = img.decodeImage(highImage);
    var _lowImage = img.decodeImage(lowImage);
    var animation = img.Animation();

    input = input.replaceAll(String.fromCharCode(8195), ' ');
    input = input.replaceAll('| ', '|');
    input = input.replaceAll(' |', '|');
    input = input.replaceAll('.', '.*');
    input = input.replaceAll('-', '-*');
    input = input.replaceAll('* ', ' ');
    if (input[input.length -1] == '*' && input.length > 1)
      input = input.substring(0, input.length - 1);

    print("#" + input +"#");
    var duration = ditDuration;
    var on = false;
    var outList = <bool>[];

    for (var i=0; i < input.length; i++ ) {
      duration = ditDuration;
      on = false;
      switch (input[i]) {
        case '.':
          on = true;
          break;
        case '-':
          on = true;
          duration *= 3;
          break;
        case '*':
          break;
        case ' ':
          duration *= 3;
          break;
        case '|':
          duration *= 7;
          break;
      }

      var image = img.Image.from(on ? _highImage : _lowImage);
      image.duration = duration;
      animation.addFrame(image);
      outList.add(on);
    };

    // image count optimation
    for (var i=animation.frames.length-1; i > 0 ; i-- ) {
      if (outList[i] == outList[i-1]) {
        animation.frames[i-1].duration += animation.frames[i].duration;
        animation.frames.removeAt(i);
      }
    }

    return img.encodeGifAnimation(animation);

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

Map<String, dynamic> decodeMorseCode(List<int> durations, List<bool> onSignal) {
  var timeList = _buildTimeList(durations, onSignal);
  print(timeList.length);
  var signalTimes = _foundSignalTimes(timeList);

  if (signalTimes == null)
    return null;
print("timeBase: " + signalTimes.toString());
  var out = '';
  timeList.forEach((element) {
    if (element.item1)
      out += (element.item2 >= signalTimes.item1) ? '-' : '.'; //2
    else
      if(element.item2 >= signalTimes.item3) //5
        out  += String.fromCharCode(8195) + "|" + String.fromCharCode(8195);
      else if(element.item2 >= signalTimes.item2)  //3
        out += " ";
  });

  var output = Map<String, dynamic>();
  output.addAll({"morse": out, "text": decodeMorse(out)});

  return output;
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

Tuple3<int, int, int> _foundSignalTimes(List<Tuple2<bool, int>> timeList) {
  if (timeList == null || timeList.length == 0)
    return null;

  var minTime = 999999999;
  timeList.forEach((element) {
    // on signal
    if (element.item1 && element.item2 < minTime && element.item2 > 0)
      minTime = element.item2;

    print(minTime);
  });
  if (minTime == 999999999)
    return null;

  // item1 ./-; item2 ''; item3 ' '
  return Tuple3<int, int, int>((minTime *1.5).toInt(), (minTime *2).toInt(), (minTime *4).toInt());
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
  animated_gif.createZipFile(fileName, imageList);
}




