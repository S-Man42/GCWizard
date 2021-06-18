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
        if (_blackPixel(image.getPixel(x, y))) // black ??
          targetImage.setPixel(x + offsetX, y + offsetY, Colors.black.value);
      }
    }
  } else {
    for (var x = 0; x < image.width; x++) {
      for (var y = 0; y < image.height; y++) {
        if (!_blackPixel(image.getPixel(x, y)))  // white ??
          targetImage.setPixel(x + offsetX, y + offsetY, Colors.white.value);
      }
    }
  }

  return targetImage;
}

  var counter1 = 0;
Tuple2<int, int> offsetAutoCalc(Uint8List image1, Uint8List image2) {
  if (image1 == null || image2 == null) return null;

  var _image1 = Image.decodeImage(image1);
  var _image2 = Image.decodeImage(image2);

  if (_image1 == null || _image2 == null) return null;

  Tuple2<int, int> result ;
  var maxCount = 0;

  var minX = -_image2.width + 2;
  var maxX = _image1.width + _image2.width - 2;
  var minY = -_image2.height + 2;
  var maxY = _image1.width + _image2.width - 2;
counter1 = 0;
  for (var x = minX; x < maxX; x++) {
    //for (var y = minY; y < maxY; y++) {
    var y = 0;
      var count = _calcBlackBlockCount(_image1, _image2, x, y);
      if (count == null) return null;
      if (count > maxCount) {
        maxCount = count;
        result = Tuple2<int, int> (x, y);
      }
    //}
  }
print("counter2 =" +counter1.toString());
  return result;
}

Uint8List cleanImage(Uint8List image1, Uint8List image2, int offsetX, int offsetY) {
  if (image1 == null || image2 == null) return null;

  var _image1 = Image.decodeImage(image1);
  var _image2 = Image.decodeImage(image2);

  if (_image1 == null || _image2 == null) return null;

  var coreImageSize = _coreImageSize(_image1, _image2, offsetX, offsetY);
  var image = Image.Image(coreImageSize.item2 - coreImageSize.item1, coreImageSize.item4 - coreImageSize.item3);

  for (var x = coreImageSize.item1; x < coreImageSize.item2-1; x+=2) {
    for (var y = coreImageSize.item3; y < coreImageSize.item4-1; y+=2) {
      if (!(_blackArea(_image1, _image2, x, y, offsetX, offsetY)))
        image.setPixel(x   - coreImageSize.item1, y   - coreImageSize.item3, Colors.white.value);
        image.setPixel(x+1 - coreImageSize.item1, y   - coreImageSize.item3, Colors.white.value);
        image.setPixel(x   - coreImageSize.item1, y+1 - coreImageSize.item3, Colors.white.value);
        image.setPixel(x+1 - coreImageSize.item1, y+1 - coreImageSize.item3, Colors.white.value);
    }
  }

  return Image.encodePng(image);
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

int _calcBlackBlockCount(Image.Image image1, Image.Image image2, int offsetX, int offsetY) {
  var counter = 0;
  var coreImageSize = _coreImageSize(image1, image2, offsetX, offsetY);

  for (var x = coreImageSize.item1; x < coreImageSize.item2-1; x+=2) {
    for (var y = coreImageSize.item3; y < coreImageSize.item4-1; y+=2) {
      try {
        if (_blackArea(image1, image2, x, y, offsetX, offsetY))
          counter++;
      } catch (e) {
        print(e);
        print((x - offsetX).toString() + " " + (y - offsetY).toString()+ " " + image1.width.toString()+ " " + image1.height.toString() + " " + image2.width.toString()+ " " + image2.height.toString());
        print(x.toString() + " " +y.toString()+ " " +image1.width.toString()+ " " +image2.width.toString()+ " " +offsetX.toString() + " " +offsetY.toString());
        return null;
      }
      counter1++;
    }
  }

  return counter;
}

bool _blackPixel(int color) {
  return color == 0; //Image.getLuminance(color)<128; //Image.rgbToHsl(Image.getRed(color), Image.getGreen(color), Image.getBlue(color))[2];
}

bool _blackResultPixel(int color1, int color2) {
  return (_blackPixel(color1) || _blackPixel(color2));
}

bool _blackArea(Image.Image image1, Image.Image image2, int x, int y, int offsetX, int offsetY) {
  return _blackResultPixel(image1.getPixel(x,   y  ), image2.getPixel(x   - offsetX, y   - offsetY)) &&
         _blackResultPixel(image1.getPixel(x+1, y  ), image2.getPixel(x+1 - offsetX, y   - offsetY)) &&
         _blackResultPixel(image1.getPixel(x,   y+1), image2.getPixel(x   - offsetX, y+1 - offsetY)) &&
         _blackResultPixel(image1.getPixel(x+1, y+1), image2.getPixel(x+1 - offsetX, y+1 - offsetY));
}

Tuple4<int, int, int, int> _coreImageSize(Image.Image image1, Image.Image image2, int offsetX, int offsetY) {
  var minX = max(offsetX, 0);
  var maxX = min(image1.width, image2.width + offsetX);
  var minY = max(offsetY, 0);
  var maxY = min(image1.height, image2.height + offsetY);

  return Tuple4<int, int, int, int>(minX, maxX, minY, maxY);
}
