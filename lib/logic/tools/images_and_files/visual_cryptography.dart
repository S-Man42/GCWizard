import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:image/image.dart' as Image;

Uint8List decodeImages(Uint8List image1, Uint8List image2, int offsetX, int offsetY) {
  if (image1 == null || image2 == null) return null;
  offsetX = 1051;
  var _image1 = Image.decodeImage(image1);
  var _image2 = Image.decodeImage(image2);

  if (_image1 == null || _image2 == null) return null;

  var image = Image.Image(max(_image1.width, _image2.width) + offsetX.abs(), max(_image1.height, _image2.height) + offsetY.abs());

  image = _pasteImage(image, _image1, min(offsetX, 0).abs(), min(offsetY, 0).abs(), false);
  image = _pasteImage(image, _image2, max(offsetX, 0).abs(), max(offsetY, 0).abs(), true);
  
  return Image.encodePng(image);
}

Image.Image _pasteImage(Image.Image targetImage, Image.Image image, int offsetX, int offsetY, bool secondLayer) {
  if (secondLayer) {
    for (var x = 0; x < image.width; x++) {
      for (var y = 0; y < image.height; y++) {
        if (!_whitePixel(image.getPixel(x, y))) //black ??
          targetImage.setPixel(x + offsetX, y + offsetY, Colors.black.value);
      }
    }
  } else {
    for (var x = 0; x < image.width; x++) {
      for (var y = 0; y < image.height; y++) {
        if (_whitePixel(image.getPixel(x, y)))  // white ??
          targetImage.setPixel(x + offsetX, y + offsetY, Colors.white.value);
      }
    }
  }

  return targetImage;
}

bool _whitePixel(int color) {
  return color > 0; //Image.getLuminance(color)<128; //Image.rgbToHsl(Image.getRed(color), Image.getGreen(color), Image.getBlue(color))[2];
}

Tuple2<Uint8List, Uint8List> encodeImage(Uint8List image, int offsetX, int offsetY) {
  if (image == null) return null;

  var _image = Image.decodeImage(image);
  if (_image == null) return null;

  var image1 = Image.Image(_image.width*2, _image.height*2);
  var image2 = Image.Image(_image.width*2, _image.height*2);
  var image1OffsetX = max(offsetX, 0).abs();
  var image1OffsetY = max(offsetY, 0).abs();
  var image2OffsetX = min(offsetX, 0).abs();
  var image2OffsetY = min(offsetY, 0).abs();

  // init images with white
  for (var x = 0; x < _image.width; x++) {
    for (var y = 0; y < _image.height; y++) {
      var pixel =  _randomPixel(true);
      for (var x1=0; x1<2; x1++) {
        for (var y1=0; y1<2; y1++) {
          if (pixel.item1[2*x1+y1]) image1.setPixel(x*2 + x1, y*2 + y1, Colors.white.value);
          if (pixel.item2[2*x1+y1]) image2.setPixel(x*2 + x1, y*2 + y1, Colors.white.value);
        }
      }
    }
  }

  // draw overlapping areas
  for (var x = 0; x < _image.width - offsetX.abs(); x++) {
    for (var y = 0; y < _image.height - offsetY.abs(); y++) {
      var pixel =  _randomPixel(Image.getLuminance(_image.getPixel(x, y)) > 128);
      for (var x1=0; x1<2; x1++) {
        for (var y1=0; y1<2; y1++) {
          image1.setPixel((x + image1OffsetX)*2 + x1, (y + image1OffsetY)*2 + y1, (pixel.item1[2*x1+y1]) ? Colors.black.value : Colors.white.value);
          image2.setPixel((x + image2OffsetX)*2 + x1, (y + image2OffsetY)*2 + y1, (pixel.item2[2*x1+y1]) ? Colors.black.value : Colors.white.value);
        }
      }
    }
  }

  return Tuple2<Uint8List, Uint8List>(Image.encodePng(image1), Image.encodePng(image2));
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
    bool1[i] = (i == pixel1 || i == pixel2);
    bool2[i] = white ? bool1[i] : !bool1[i];
  }
  return Tuple2<List<bool>, List<bool>>(bool1, bool2);
}
