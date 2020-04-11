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