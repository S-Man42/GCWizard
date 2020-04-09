import 'dart:math';

import 'package:flutter/widgets.dart';

const keyColorsRGB = 'colors_rgb';
const keyColorsHex = 'colors_hex';
const keyColorsHSL = 'colors_hsl';

class ColorFormat {
  final key;
  String name;

  ColorFormat(this.key, this.name);
}

List<ColorFormat> allCoordFormats = [
  ColorFormat(keyColorsRGB, 'colors_format_rgb'),
  ColorFormat(keyColorsHex, 'colors_format_hex'),
  ColorFormat(keyColorsHSL, 'colors_format_hsl'),
];

class RGB {
  double red;
  double green;
  double blue;

  RGB(double red, double green, double blue) {
    this.red = min(255, max(0, red));
    this.green = min(255, max(0, green));
    this.blue = min(255, max(0, blue));
  }

  double _percentage(double value) {
    return 100.0 * value / 255;
  }

  double get redPercentage {
    return _percentage(red);
  }

  double get greenPercentage {
    return _percentage(green);
  }

  double get bluePercentage {
    return _percentage(blue);
  }

  @override
  toString() {
    return 'RGB($red, $green, $blue)';
  }
}

class HexCode {
  String hexCode;

  HexCode(String hexCode) {
    hexCode = hexCode.toUpperCase().replaceAll(RegExp(r'[^0-9A-F]'), '');
    if (hexCode.length < 6)
      hexCode = hexCode.padRight(6, '0');
    if (hexCode.length > 6)
      hexCode = hexCode.substring(0, 6);

    this.hexCode = hexCode;
  }

  RGB toRGB() {
    var r = int.parse(hexCode.substring(0, 2), radix: 16).toDouble();
    var g = int.parse(hexCode.substring(2, 4), radix: 16).toDouble();
    var b = int.parse(hexCode.substring(4, 6), radix: 16).toDouble();

    return RGB(r, g, b);
  }

  static HexCode fromRGB(RGB rgb) {
    return HexCode(
      rgb.red.round().toRadixString(16).padLeft(2, '0') +
      rgb.green.round().toRadixString(16).padLeft(2, '0') +
      rgb.blue.round().toRadixString(16).padLeft(2, '0')
    );
  }

  @override
  toString() {
    return '#' + hexCode;
  }
}

class HSL {
  HSLColor hsl;

  HSL(double hue, double saturation, double lightness) {
    hue = min(360, max(0, hue));
    saturation = min(1, max(0, saturation));
    lightness = min(1, max(0, lightness));

    hsl = HSLColor.fromAHSL(1.0, hue, saturation, lightness);
  }

  double get hue {
    return hsl.hue;
  }

  double get saturation {
    return hsl.saturation;
  }

  double get lightness {
    return hsl.lightness;
  }

  double get saturationPercentage {
    return hsl.saturation * 100;
  }

  double get lightnessPercentage {
    return hsl.lightness * 100;
  }

  RGB toRGB() {
    return toHSV().toRGB();
  }

  //source: https://de.wikipedia.org/wiki/HSV-Farbraum#Umrechnung_RGB_in_HSV/HSL
  static HSL fromRGB(RGB rgb) {
    var red = rgb.redPercentage / 100;
    var green = rgb.greenPercentage / 100;
    var blue = rgb.bluePercentage / 100;

    var maxComponent = max(max(red, green), blue);
    var minComponent = min(min(red, green), blue);
    var diff = maxComponent - minComponent;

    var hue = 0.0;
    if (diff > 0.0) {
      if (maxComponent == red) {
        hue = 60.0 * (0.0 - (green - blue) / diff);
      } else if (maxComponent == green) {
        hue = 60.0 * (2.0 + (blue - red) / diff);
      } else if (maxComponent == blue) {
        hue = 60.0 * (4.0 + (red - green) / diff);
      }
    }

    var saturation = 0.0;
    if (maxComponent > 0.0 && minComponent < 1.0)
      saturation = diff / (1 - (maxComponent + minComponent - 1).abs());

    var lightness = (maxComponent + minComponent) / 2.0;

    return HSL(hue, saturation, lightness);
  }

  HSV toHSV() {
    return HSV.fromHSL(HSL(hue, saturation, lightness));
  }

  static HSL fromHSV(HSV hsv) {
    return hsv.toHSL();
  }

  @override
  toString() {
    return hsl.toString();
  }
}

class HSV {
  HSVColor hsv;

  HSV(double hue, double saturation, double value) {
    hue = min(360, max(0, hue));
    saturation = min(1, max(0, saturation));
    value = min(1, max(0, value));

    hsv = HSVColor.fromAHSV(1.0, hue, saturation, value);
  }

  double get hue {
    return hsv.hue;
  }

  double get saturation {
    return hsv.saturation;
  }

  double get value {
    return hsv.value;
  }

  double get saturationPercentage {
    return hsv.saturation * 100;
  }

  double get valuePercentage {
    return hsv.value * 100;
  }

  //source: https://de.wikipedia.org/wiki/HSV-Farbraum#Umrechnung_HSV_in_RGB
  RGB toRGB() {
    var h_i = (hsv.hue / 60.0).floor();
    var f = (hsv.hue / 60.0) - h_i;
    var p = hsv.value * (1 - hsv.saturation);
    var q = hsv.value * (1 - hsv.saturation * f);
    var t = hsv.value * (1 - hsv.saturation * (1 - f));

    double red;
    double green;
    double blue;

    switch (h_i) {
      case 0:
      case 6:
        red = hsv.value;
        green = t;
        blue = p;
        break;
      case 1:
        red = q;
        green = hsv.value;
        blue = p;
        break;
      case 2:
        red = p;
        green = hsv.value;
        blue = t;
        break;
      case 3:
        red = p;
        green = q;
        blue = hsv.value;
        break;
      case 4:
        red = t;
        green = p;
        blue = hsv.value;
        break;
      case 5:
        red = hsv.value;
        green = p;
        blue = q;
        break;
    }

    return RGB(red * 255, green * 255, blue * 255);
  }

  //source: https://de.wikipedia.org/wiki/HSV-Farbraum#Umrechnung_RGB_in_HSV/HSL
  static HSV fromRGB(RGB rgb) {
    var red = rgb.redPercentage / 100;
    var green = rgb.greenPercentage / 100;
    var blue = rgb.bluePercentage / 100;

    var maxComponent = max(max(red, green), blue);
    var minComponent = min(min(red, green), blue);
    var diff = maxComponent - minComponent;

    var hue = 0.0;
    if (diff > 0.0) {
      if (maxComponent == red) {
        hue = 60.0 * (0.0 - (green - blue) / diff);
      } else if (maxComponent == green) {
        hue = 60.0 * (2.0 + (blue - red) / diff);
      } else if (maxComponent == blue) {
        hue = 60.0 * (4.0 + (red - green) / diff);
      }
    }

    var saturation = maxComponent == 0.0 ? 0.0 : diff / maxComponent;

    return HSV(hue, saturation, maxComponent);
  }

  //source: https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_HSL
  HSL toHSL() {
    var lightness = hsv.value * (1 - hsv.saturation / 2);
    var saturation = 0.0;
    if (lightness > 0.0 && lightness < 1.0)
      saturation = ((hsv.value - lightness) / min(lightness, 1 - lightness));

    return HSL(hsv.hue, saturation, lightness);
  }

  //source: https://en.wikipedia.org/wiki/HSL_and_HSV#HSL_to_HSV
  static HSV fromHSL(HSL hsl) {
    var value = hsl.lightness + hsl.saturation * min(hsl.lightness, 1 - hsl.lightness);
    var saturation = value == 0.0 ? 0.0 : 2 * (hsl.lightness / value);

    return HSV(hsl.hue, saturation, value);
  }

  @override
  toString() {
    return hsv.toString();
  }
}


main() {
  var rgb = RGB(123, 230, 14);
  print(rgb);
  print(HexCode.fromRGB(rgb));
  print(HexCode.fromRGB(rgb).toRGB());
  print(HexCode.fromRGB(HexCode.fromRGB(rgb).toRGB()));

  rgb = RGB(0, 0, 0);
  print(rgb);
  print(HexCode.fromRGB(rgb));
  print(HexCode.fromRGB(rgb).toRGB());
  print(HexCode.fromRGB(HexCode.fromRGB(rgb).toRGB()));

  rgb = RGB(255, 255, 255);
  print(rgb);
  print(HexCode.fromRGB(rgb));
  print(HexCode.fromRGB(rgb).toRGB());
  print(HexCode.fromRGB(HexCode.fromRGB(rgb).toRGB()));
}