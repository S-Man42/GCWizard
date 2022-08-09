import 'dart:isolate';
import 'dart:typed_data';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:image/image.dart' as Image;


Image.Image decodeImage(Uint8List image) {
  return Image.decodeImage(image);
}

int magicEyeSolver(Image.Image image) {
  const int MIN_DISPLACEMENT_ALLOWED = 10;
  var testedLines = _computeTestedLines(image);
  int maxDisplacementAllowed = (image.width / 3).toInt();

  var differences = <double>[]; // displacement=0 is considered as unavailable so set a high value for it

  for (int displacement = MIN_DISPLACEMENT_ALLOWED; displacement <= maxDisplacementAllowed; displacement++) {
    var totalDifference = 0.0;
    testedLines.forEach((y) {
      for (int x = displacement; x < image.width; x++) {
        var _pixel1 = image.getPixel(x, y);
        var _pixel2 = image.getPixel(x - displacement, y);

        var red = Image.getRed(_pixel1) - Image.getRed(_pixel2);
        var green = Image.getGreen(_pixel1) - Image.getGreen(_pixel2);
        var blue = Image.getBlue(_pixel1) - Image.getBlue(_pixel2);

        var difference = (red.abs() + green.abs() + blue.abs()) / 3.0;
        totalDifference += difference;
      }
    });

    var nbPixels = (testedLines.length * (image.width - displacement));
    var averageDifference = totalDifference / nbPixels;
    differences.add(averageDifference);
  }
  return _computeBestDisplacement(differences) + MIN_DISPLACEMENT_ALLOWED;
}

List<int> _computeTestedLines(Image.Image image) {
  const MAX_TESTED_LINES_COUNT = 50;
  var lines = <int>[];
  var delta = (image.height < MAX_TESTED_LINES_COUNT) ? 1 : (image.height / MAX_TESTED_LINES_COUNT);

  for (double i = 0; i < image.height; i += delta)
    lines.add(i.floor());

  return lines;
}

/// when reaching the correct delta, on most stereograms the total difference is at its lowest, and goes right up just after
/// so try to detect this point
int _computeBestDisplacement(List<double> differences) {
  var highestGradientIndex = 1;
  var highestGradient = -1.0;
  for (var i = 2; i < differences.length - 1; i++)
  {
    var gradient = differences[i + 1] - differences[i];
    if (gradient > highestGradient)
    {
      highestGradientIndex = i;
      highestGradient = gradient;
    }
  }
  // The gradient helps determine the end of the lowest plateau.
  // Once found, check what was just before because maybe it was better
  for (var i = 0; i < 3; i++)
  {
    if (highestGradientIndex > 0 && differences[highestGradientIndex - 1] < differences[highestGradientIndex])
    highestGradientIndex--;
  }
  return highestGradientIndex;
}

Uint8List createResultImage(Image.Image image, int displacement) {
  var bitmap = Image.Image(image.width, image.height);
  for (int y = 0; y < bitmap.height; y++)
    for (int x = 0; x < displacement; x++)
      bitmap.setPixel(x, y, image.getPixel(x, y));

  for (int y = 0; y < bitmap.height; y++) {
    for (int x = displacement; x < bitmap.width; x++) {
      var _pixel1 = image.getPixel(x, y);
      var _pixel2 = image.getPixel(x - displacement, y);

      var color = Image.Color.fromRgb(
          (Image.getRed(_pixel1) - Image.getRed(_pixel2)).abs(),
          (Image.getGreen(_pixel1) - Image.getGreen(_pixel2)).abs(),
          (Image.getBlue(_pixel1) - Image.getBlue(_pixel2)).abs());
      bitmap.setPixel(x, y, color);
    }
  }
  return encodeTrimmedPng(bitmap);
}