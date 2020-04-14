import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_cmyk.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_hue.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_rgb.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_yuv.dart';

const keyColorsRGB = 'colors_rgb';
const keyColorsHex = 'colors_hex';
const keyColorsHSV = 'colors_hsv';
const keyColorsHSL = 'colors_hsl';
const keyColorsHSI = 'colors_hsi';
const keyColorsCMYK = 'colors_cmyk';
const keyColorsCMY = 'colors_cmy';
const keyColorsYUV = 'colors_yuv';
const keyColorsYPbPr = 'colors_ypbpr';
const keyColorsYCbCr = 'colors_ycbcr';
const keyColorsYIQ = 'colors_yiq';

class ColorSpace {
  final key;
  String name;

  ColorSpace(this.key, this.name);
}

final String defaultColorSpace = keyColorsRGB;
final RGB defaultColor = RGB(128.0, 128.0, 128.0);
final int COLOR_DOUBLE_PRECISION = 5;

final List<ColorSpace> allColorSpaces = [
  ColorSpace(keyColorsRGB, 'colors_format_rgb'),
  ColorSpace(keyColorsHex, 'colors_format_hex'),
  ColorSpace(keyColorsHSV, 'colors_format_hsv'),
  ColorSpace(keyColorsHSL, 'colors_format_hsl'),
  ColorSpace(keyColorsHSI, 'colors_format_hsi'),
  ColorSpace(keyColorsCMYK, 'colors_format_cmyk'),
  ColorSpace(keyColorsCMY, 'colors_format_cmy'),
  ColorSpace(keyColorsYUV, 'colors_format_yuv'),
  ColorSpace(keyColorsYPbPr, 'colors_format_ypbpr'),
  ColorSpace(keyColorsYCbCr, 'colors_format_ycbcr'),
  ColorSpace(keyColorsYIQ, 'colors_format_yiq'),
];

ColorSpace getColorSpaceByKey(String key) {
  return allColorSpaces.firstWhere((colorSpace) => colorSpace.key == key);
}

convertColorSpace(dynamic color, String oldColorSpace, String newColorSpace) {
  if (newColorSpace == oldColorSpace) {
    return color;
  }

  if (oldColorSpace != keyColorsRGB) {
    color = color.toRGB();
  }

  switch (newColorSpace) {
    case keyColorsRGB: return color;
    case keyColorsHex: return HexCode.fromRGB(color);
    case keyColorsHSV: return HSV.fromRGB(color);
    case keyColorsHSL: return HSL.fromRGB(color);
    case keyColorsHSI: return HSI.fromRGB(color);
    case keyColorsCMYK: return CMYK.fromRGB(color);
    case keyColorsCMY: return CMY.fromRGB(color);
    case keyColorsYUV: return YUV.fromRGB(color);
    case keyColorsYPbPr: return YPbPr.fromRGB(color);
    case keyColorsYCbCr: return YCbCr.fromRGB(color);
    case keyColorsYIQ: return YIQ.fromRGB(color);
  }
}