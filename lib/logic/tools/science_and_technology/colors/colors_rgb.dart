import 'dart:math';

class RGB {
  double red;
  double green;
  double blue;

  RGB(double red, double green, double blue) {
    this.red = min(255.0, max(0.0, red));
    this.green = min(255.0, max(0.0, green));
    this.blue = min(255.0, max(0.0, blue));
  }

  double _percentage(double value) {
    return value / 255.0;
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

  bool get isShortHex {
    return hexCode[0] == hexCode[1] && hexCode[2] == hexCode[3] && hexCode[4] == hexCode[5];
  }

  String get shortHexCode {
    if (isShortHex)
      return '#' + hexCode[0] + hexCode[2] + hexCode[4];

    return null;
  }

  HexCode(String hexCode) {
    hexCode = hexCode.toUpperCase().replaceAll(RegExp(r'[^0-9A-F]'), '');

    if (hexCode.length == 3) { //shorthex
      hexCode = hexCode.split('').map((character) => character * 2).join();
    }

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