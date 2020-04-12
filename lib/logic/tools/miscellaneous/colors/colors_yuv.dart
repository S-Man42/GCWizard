import 'dart:math';

import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_rgb.dart';

//source: https://en.wikipedia.org/wiki/YUV#Conversion_to/from_RGB
class YUV {
  double y; //luminance/luma;
  double u; //chrominance: blue projection
  double v; //chrominance: red projection

  static final double _U_MAX = 0.436;
  static final double _V_MAX = 0.615;

  static final double _W_R = 0.299;
  static final double _W_B = 0.114;
  static final double _W_G = 1.0 - _W_B - _W_R;

  YUV(double y, double u, double v) {
    this.y = min(1.0, max(0.0, y));
    this.u = min(_U_MAX, max(-_U_MAX, u));
    this.v = min(_V_MAX, max(-_V_MAX, v));
  }

  RGB toRGB() {
    double red = y + v * ((1.0 - _W_R) / _V_MAX);
    double green = y - u * (_W_B * (1.0 - _W_B) / (_U_MAX * _W_G)) - v * (_W_R * (1.0 - _W_R) / (_V_MAX * _W_G));
    double blue = y + u * ((1.0 - _W_B) / _U_MAX);

    return RGB(red * 255.0, green * 255.0, blue * 255.0);
  }

  static YUV fromRGB(RGB rgb) {
    double red = rgb.redPercentage;
    double green = rgb.greenPercentage;
    double blue = rgb.bluePercentage;

    double y = _W_R * red + _W_G * green + _W_B * blue;
    double u = _U_MAX * ((blue - y) / (1.0 - _W_B));
    double v = _V_MAX * ((red - y) / (1.0 - _W_R));

    return YUV(y, u, v);
  }

  @override
  String toString() {
    return 'YUV($y, $u, $v)';
  }
}

//source https://en.wikipedia.org/wiki/YCbCr#ITU-R_BT.601_conversion
class YPbPr {
  double y; //luminance/luma;
  double p_b; //chrominance: blue projection
  double p_r; //chrominance: red projection

  static final double _K_R = 0.299;
  static final double _K_B = 0.114;
  static final double _K_G = 1.0 - _K_R - _K_B;

  YPbPr(double y, double p_b, double p_r) {
    this.y = min(1.0, max(0.0, y));
    this.p_b = min(0.5, max(-0.5, p_b));
    this.p_r = min(0.5, max(-0.5, p_r));
  }

  RGB toRGB() {
    double red = y + p_r * (2.0 - 2.0 * _K_R);
    double green = y - p_b * (_K_B / _K_G * (2.0 - 2.0 * _K_B)) - p_r * (_K_R / _K_G * (2.0 - 2.0 * _K_R));
    double blue = y + p_b * (2.0 - 2.0 * _K_B);

    return RGB(red * 255.0, green * 255.0, blue * 255.0);
  }

  static YPbPr fromRGB(RGB rgb) {
    double red = rgb.redPercentage;
    double green = rgb.greenPercentage;
    double blue = rgb.bluePercentage;

    double y = _K_R * red + _K_G * green + _K_B * blue;
    double p_b = 0.5 * (blue - y) / (1.0 - _K_B);
    double p_r = 0.5 * (red - y) / (1.0 - _K_R);

    return YPbPr(y, p_b, p_r);
  }

  @override
  String toString() {
    return 'YPbPr($y, $p_b, $p_r)';
  }
}

//source https://en.wikipedia.org/wiki/YCbCr#ITU-R_BT.601_conversion
class YCbCr {
  double y; //luminance/luma;
  double c_b; //chrominance: blue projection
  double c_r; //chrominance: red projection

  static final double _K_R = 0.299;
  static final double _K_B = 0.114;
  static final double _K_G = 1.0 - _K_R - _K_B;

  YCbCr(double y, double p_b, double p_r) {
    this.y = min(235.0, max(16.0, y));
    this.c_b = min(240.0, max(16.0, p_b));
    this.c_r = min(240.0, max(16.0, p_r));
  }

  YPbPr toYPbPr() {
    double y_pbpr = (y - 16.0) / 219.0;
    double p_b = (c_b - 128.0) / 224.0;
    double p_r = (c_r - 128.0) / 224.0;

    return YPbPr(y_pbpr, p_b, p_r);
  }

  RGB toRGB() {
    return toYPbPr().toRGB();
  }

  static YCbCr fromYPbPr(YPbPr yPbPr) {
    double y = 16.0 + 219.0 * yPbPr.y;
    double c_b = 128.0 + 224.0 * yPbPr.p_b;
    double c_r = 128.0 + 224.0 * yPbPr.p_r;

    return YCbCr(y, c_b, c_r);
  }

  static YCbCr fromRGB(RGB rgb) {
    return fromYPbPr(YPbPr.fromRGB(rgb));
  }

  @override
  String toString() {
    return 'YCbCr($y, $c_b, $c_r)';
  }
}

main() {
  RGB rgb = RGB(123, 230, 12);
  var ycc = YCbCr.fromRGB(rgb);
  print(ycc);
  print(ycc.toRGB());
}