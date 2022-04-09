import 'dart:core';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class PietImageReader {
  List<List<int>> ReadImage(Uint8List image) {
    var _image = img.decodeImage(image);
    return _ReadImage(_image);
  }

  List<List<int>> _ReadImage(img.Image image) {
    var step = EstimateCodelSize(image);
    var pixels = <List<int>>[];

    int outY = 0;
    for (var y = 0; y < image.height; y += step, outY++) {
      pixels.add(<int>[]);
      for (var x = 0; x < image.width; x += step) {
        var pix = image.getPixel(x, y);
        pixels[outY].add(_ToRgb(pix));
      }
    }
    return pixels;
  }

  int _ToRgb(int rgb24) {
    return ((rgb24 & 0x000000FF) << 16) | (rgb24 & 0x0000FF00) | ((rgb24 & 0x00FF0000) >> 16); //AABBGGRR -> RGB
  }

  int EstimateCodelSize(img.Image image) {
    // test the first row
    int count = 1;
    int minCount = 9999999999999; //int.MaxValue;

    for (var rowIndex = 0; rowIndex < image.height; rowIndex++) {
      var prevColour = _ToRgb(image.getPixel(0, rowIndex));
      for (var i = 1; i < image.width; i++) {
        var currentColour = _ToRgb(image.getPixel(i, rowIndex));
        if (currentColour == prevColour)
          count++;
        else {
          if (count < minCount) minCount = count;

          prevColour = currentColour;
          count = 1;
        }
      }

      if (count < minCount) minCount = count;
    }
    return minCount;
  }
}

