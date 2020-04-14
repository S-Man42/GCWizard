import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_cmyk.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_hue.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_rgb.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_yuv.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_cmy.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_cmyk.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_hex.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_hsi.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_hsl.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_hsv.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_rgb.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_ycbcr.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_yiq.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_ypbpr.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_yuv.dart';

class GCWColors extends StatefulWidget {
  final Function onChanged;
  final dynamic color;
  final String colorSpace;

  const GCWColors({Key key, this.onChanged, this.colorSpace, this.color}) : super(key: key);

  @override
  GCWColorsState createState() => GCWColorsState();
}

class GCWColorsState extends State<GCWColors> {

  String _currentColorSpace;
  dynamic _currentColor = defaultColor;

  @override
  Widget build(BuildContext context) {
    _currentColorSpace = widget.colorSpace ?? defaultColorSpace;

    List<Map<String, dynamic>> _colorWidgets = [
      {
        'colorSpace': getColorSpaceByKey(keyColorsRGB),
        'widget': GCWColorRGB(
          color: _currentColorSpace == keyColorsRGB ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsHex),
        'widget': GCWColorHexCode(
          color: _currentColorSpace == keyColorsHex ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsHSV),
        'widget': GCWColorHSV(
          color: _currentColorSpace == keyColorsHSV ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsHSL),
        'widget': GCWColorHSL(
          color: _currentColorSpace == keyColorsHSL ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsHSI),
        'widget': GCWColorHSI(
          color: _currentColorSpace == keyColorsHSI ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsCMYK),
        'widget': GCWColorCMYK(
          color: _currentColorSpace == keyColorsCMYK ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsCMY),
        'widget': GCWColorCMY(
          color: _currentColorSpace == keyColorsCMY ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsYUV),
        'widget': GCWColorYUV(
          color: _currentColorSpace == keyColorsYUV ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsYPbPr),
        'widget': GCWColorYPbPr(
          color: _currentColorSpace == keyColorsYPbPr ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsYCbCr),
        'widget': GCWColorYCbCr(
          color: _currentColorSpace == keyColorsYCbCr ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorsYIQ),
        'widget': GCWColorYIQ(
          color: _currentColorSpace == keyColorsYIQ ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
    ];

    List<ColorSpace> _onlyColorSpaces = _colorWidgets.map((entry) => entry['colorSpace'] as ColorSpace).toList();

    Column _widget = Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentColorSpace,
          onChanged: (newValue) {
            setState(() {
              _currentColor = convertColorSpace(_currentColor, _currentColorSpace, newValue);
              _currentColorSpace = newValue;

              _setCurrentValueAndEmitOnChange();
            });
          },
          items: _onlyColorSpaces.map((colorSpace) {
            return DropdownMenuItem(
              value: colorSpace.key,
              child: Text(colorSpace.name),
            );
          }).toList(),
        ),
      ],
    );

    var _currentWidget = _colorWidgets
      .firstWhere((entry) => entry['colorSpace'].key == _currentColorSpace)['widget'];

    _widget.children.add(_currentWidget);

    return _widget;
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged({
      'colorSpace': _currentColorSpace,
      'color': _currentColor
    });
  }
}