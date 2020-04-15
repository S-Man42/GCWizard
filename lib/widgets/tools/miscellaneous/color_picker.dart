import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_cmyk.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_hue.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_rgb.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_yuv.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_rgb.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:intl/intl.dart';

class ColorPicker extends StatefulWidget {
  @override
  ColorPickerState createState() => ColorPickerState();
}

class ColorPickerState extends State<ColorPicker> {
  dynamic _currentColor = defaultColor;
  String _currentColorSpace = keyColorSpaceRGB;

  final NumberFormat _numberFormat = NumberFormat('0.' + '#' * COLOR_DOUBLE_PRECISION);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
//        CircleColorPicker(
//          initialColor: _currentColor,
//          strokeWidth: 6,
//          onChanged: (Color color) {
//            setState(() {
//              _currentColor = color;
//            });
//          },
//        ),
        GCWColors(
          color: _currentColor,
          colorSpace: _currentColorSpace,
          onChanged: (result) {
            setState(() {
              _currentColorSpace = result['colorSpace'];
              _currentColor = result['color'];
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {

    RGB rgb = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceRGB);
    HexCode hex = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceHex);

    HSV hsv = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceHSV);
    HSL hsl = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceHSL);
    HSI hsi = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceHSI);

    CMYK cmyk = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceCMYK);
    CMY cmy = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceCMY);

    YUV yuv = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceYUV);
    YPbPr yPbPr = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceYPbPr);
    YCbCr yCbCr = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceYCbCr);
    YIQ yiq = convertColorSpace(_currentColor, _currentColorSpace, keyColorSpaceYIQ);

    var colorSpaceOutputs = [
      [
        i18n(context, 'colors_colorspace_rgb_title'),

        i18n(context, 'colors_colorspace_rgb_red') + '\n'
        + i18n(context, 'colors_colorspace_rgb_green') + '\n'
        + i18n(context, 'colors_colorspace_rgb_blue'),

        _numberFormat.format(rgb.red) + '\n'
        + _numberFormat.format(rgb.green) + '\n'
        + _numberFormat.format(rgb.blue)
      ],
      [
        i18n(context, 'colors_colorspace_hex_title'),

        i18n(context, 'colors_colorspace_hex_hexcode') + '\n'
          + i18n(context, 'colors_colorspace_hex_shorthexcode'),

        hex.toString() + '\n'
          + (hex.isShortHex ? hex.shortHexCode : '-'),
      ],
      [
        i18n(context, 'colors_colorspace_hsv_title'),

        i18n(context, 'colors_colorspace_hsv_hue') + '\n'
            + i18n(context, 'colors_colorspace_hsv_saturation') + '\n'
            + i18n(context, 'colors_colorspace_hsv_value'),

        _numberFormat.format(hsv.hue) + '\n'
            + _numberFormat.format(hsv.saturation * 100.0) + '\n'
            + _numberFormat.format(hsv.value * 100.0)
      ],
      [
        i18n(context, 'colors_colorspace_hsl_title'),

        i18n(context, 'colors_colorspace_hsl_hue') + '\n'
            + i18n(context, 'colors_colorspace_hsl_saturation') + '\n'
            + i18n(context, 'colors_colorspace_hsl_lightness'),

        _numberFormat.format(hsl.hue) + '\n'
            + _numberFormat.format(hsl.saturation * 100.0) + '\n'
            + _numberFormat.format(hsl.lightness * 100.0)
      ],
      [
        i18n(context, 'colors_colorspace_hsi_title'),

        i18n(context, 'colors_colorspace_hsi_hue') + '\n'
            + i18n(context, 'colors_colorspace_hsi_saturation') + '\n'
            + i18n(context, 'colors_colorspace_hsi_intensity'),

        _numberFormat.format(hsi.hue) + '\n'
            + _numberFormat.format(hsi.saturation * 100.0) + '\n'
            + _numberFormat.format(hsi.intensity * 100.0)
      ],
      [
        i18n(context, 'colors_colorspace_cmyk_title'),

        i18n(context, 'colors_colorspace_cmyk_cyan') + '\n'
            + i18n(context, 'colors_colorspace_cmyk_magenta') + '\n'
            + i18n(context, 'colors_colorspace_cmyk_yellow') + '\n'
            + i18n(context, 'colors_colorspace_cmyk_key'),

        _numberFormat.format(cmyk.cyan * 100.0) + '\n'
            + _numberFormat.format(cmyk.magenta * 100.0) + '\n'
            + _numberFormat.format(cmyk.yellow * 100.0) + '\n'
            + _numberFormat.format(cmyk.key * 100.0)
      ],
      [
        i18n(context, 'colors_colorspace_cmy_title'),

        i18n(context, 'colors_colorspace_cmy_cyan') + '\n'
            + i18n(context, 'colors_colorspace_cmy_magenta') + '\n'
            + i18n(context, 'colors_colorspace_cmy_yellow'),

        _numberFormat.format(cmy.cyan * 100.0) + '\n'
            + _numberFormat.format(cmy.magenta * 100.0) + '\n'
            + _numberFormat.format(cmy.yellow * 100.0)
      ],
      [
        i18n(context, 'colors_colorspace_yuv_title'),

        i18n(context, 'colors_colorspace_yuv_y') + '\n'
            + i18n(context, 'colors_colorspace_yuv_u') + '\n'
            + i18n(context, 'colors_colorspace_yuv_v'),

        _numberFormat.format(yuv.y * 100.0) + '\n'
            + _numberFormat.format(yuv.u * 100.0) + '\n'
            + _numberFormat.format(yuv.v * 100.0)
      ],
      [
        i18n(context, 'colors_colorspace_ypbpr_title'),

        i18n(context, 'colors_colorspace_ypbpr_y') + '\n'
            + i18n(context, 'colors_colorspace_ypbpr_pb') + '\n'
            + i18n(context, 'colors_colorspace_ypbpr_pr'),

        _numberFormat.format(yPbPr.y * 100.0) + '\n'
            + _numberFormat.format(yPbPr.pb * 100.0) + '\n'
            + _numberFormat.format(yPbPr.pr * 100.0)
      ],
      [
        i18n(context, 'colors_colorspace_ycbcr_title'),

        i18n(context, 'colors_colorspace_ycbcr_y') + '\n'
            + i18n(context, 'colors_colorspace_ycbcr_cb') + '\n'
            + i18n(context, 'colors_colorspace_ycbcr_cr'),

        _numberFormat.format(yCbCr.y) + '\n'
            + _numberFormat.format(yCbCr.cb) + '\n'
            + _numberFormat.format(yCbCr.cr)
      ],
      [
        i18n(context, 'colors_colorspace_yiq_title'),

        i18n(context, 'colors_colorspace_yiq_y') + '\n'
            + i18n(context, 'colors_colorspace_yiq_i') + '\n'
            + i18n(context, 'colors_colorspace_yiq_q'),

        _numberFormat.format(yiq.y * 100.0) + '\n'
            + _numberFormat.format(yiq.i * 100.0) + '\n'
            + _numberFormat.format(yiq.q * 100.0)
      ],
    ];

    var rows = columnedMultiLineOutput(colorSpaceOutputs, flexValues: [1,3,2]);

    rows.insert(0,
      GCWTextDivider(
          text: i18n(context, 'common_output')
      )
    );

    return Column(
      children: rows
    );
  }
}