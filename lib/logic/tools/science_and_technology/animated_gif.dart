import 'dart:typed_data';
//import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img;

Future <Map<String, dynamic>> analyseGif(Uint8List bytes) async {
  final decoder = img.findDecoderForData(bytes);
  if (decoder == null)
    return null;

  var out = Map<String, dynamic>();
  var animation = decoder.decodeAnimation(bytes);

  var imageList = <Uint8List>[];
  var durations = <int>[];
  animation?.frames.forEach((image) {
    imageList.add(img.encodeGif(image));
    durations.add(image.duration);
  });
  out.addAll({"animation": animation});

  // out.addAll({"image": bytes});
  out.addAll({"images": imageList});
  out.addAll({"durations": durations});


  return out;
}

