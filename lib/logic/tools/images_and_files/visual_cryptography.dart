import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:image/image.dart' as Image;

Image.Image decodeImages(Image.Image image1, Image.Image image2, int offsetX, int offsetY) {
  if (image1 == null || image2 == null) return null;
  
  var image = Image.Image(max(image1.width, image2.width) + offsetX.abs(), max(image1.height, image2.height) + offsetY.abs());

  image = _pasteImage(image, image1, min(offsetX, 0).abs(), min(offsetY, 0).abs());
  image = _pasteImage(image, image2, max(offsetX, 0).abs(), max(offsetY, 0).abs());
  
  return image;
}

Image.Image _pasteImage(Image.Image targetImage, Image.Image image, int offsetX, int offsetY) {
  for (var x = 0; x < image.width; x++) {
    for (var y = 0; y < image.height; y++) {
      if (Image.getLuminance(image.getPixel(x, y)) > 128)
        targetImage.setPixel(x + offsetX, y + offsetY, Colors.white.value);
    }
  }
}

Tuple2<Image.Image, Image.Image> encodeImage(Image.Image image, int offsetX, int offsetY) {
  if (image == null) return null;

  var image1 = Image.Image(image.width*2, image.height*2);
  var image2 = Image.Image(image.width*2, image.height*2);
  var image1OffsetX = max(offsetX, 0).abs();
  var image1OffsetY = max(offsetY, 0).abs();
  var image2OffsetX = min(offsetX, 0).abs();
  var image2OffsetY = min(offsetY, 0).abs();

  // init images with white
  for (var x = 0; x < image.width; x++) {
    for (var y = 0; y < image.height; y++) {
      var pixel =  _randomPixel(true);
      for (var x1=0; x1<2; x1++) {
        for (var y1=0; y1<2; y1++) {
          if (pixel.item1[x1+y1]) image1.setPixel(x*2 + x1, y*2 + y1, Colors.white.value);
          if (pixel.item2[x1+y1]) image2.setPixel(x*2 + x1, y*2 + y1, Colors.white.value);
        }
      }
    }
  }

  // draw overlapping areas
  for (var x = 0; x < image.width - offsetX.abs(); x++) {
    for (var y = 0; y < image.height - offsetY.abs(); y++) {
      var pixel =  _randomPixel(Image.getLuminance(image.getPixel(x, y)) > 128);
      for (var x1=0; x1<2; x1++) {
        for (var y1=0; y1<2; y1++) {
          image1.setPixel((x + image1OffsetX)*2 + x1, (y + image1OffsetY)*2 + y1, (pixel.item1[x1+y1]) ? Colors.black.value : Colors.white.value);
          image2.setPixel((x + image2OffsetX)*2 + x1, (y + image2OffsetY)*2 + y1, (pixel.item2[x1+y1]) ? Colors.black.value : Colors.white.value);
        }
      }
    }
  }

  return Tuple2<Image.Image, Image.Image>(image1, image2);
}

Tuple2<List<bool>, List<bool>> _randomPixel(bool white) {
  var random = Random();
  var pixel1 = random.nextInt(4);
  int pixel2;
  do {
    pixel2 = random.nextInt(4);
  } while (pixel2 == pixel1);

  var bool1 = List<bool>.filled(4, false);
  var bool2 = List<bool>.filled(4, false);
  for (var i=0; i<4; i++) {
    if (i == pixel1 || i == pixel2) {
      bool1[i] = (i == pixel1 || i == pixel2);
      bool2[i] = white ? bool1[i] : !bool1[i];
    }
  }
  return Tuple2<List<bool>, List<bool>>(bool1, bool2);
}
