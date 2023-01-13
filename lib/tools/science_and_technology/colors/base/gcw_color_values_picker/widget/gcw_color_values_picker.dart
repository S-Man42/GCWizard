import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/gcw_dropdownbutton.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_cmy/widget/gcw_color_cmy.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_cmyk/widget/gcw_color_cmyk.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_hex/widget/gcw_color_hex.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_hsi/widget/gcw_color_hsi.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_hsl/widget/gcw_color_hsl.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_hsv/widget/gcw_color_hsv.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_rgb/widget/gcw_color_rgb.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_ycbcr/widget/gcw_color_ycbcr.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_yiq/widget/gcw_color_yiq.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_ypbpr/widget/gcw_color_ypbpr.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/gcw_color_yuv/widget/gcw_color_yuv.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors.dart';

class GCWColorValuesPicker extends StatefulWidget {
  final Function onChanged;
  final dynamic color;
  final String colorSpace;

  const GCWColorValuesPicker({Key key, this.onChanged, this.colorSpace, this.color}) : super(key: key);

  @override
  GCWColorValuesPickerState createState() => GCWColorValuesPickerState();
}

class GCWColorValuesPickerState extends State<GCWColorValuesPicker> {
  String _currentColorSpace;
  dynamic _currentColor = defaultColor;

  @override
  Widget build(BuildContext context) {
    _currentColorSpace = widget.colorSpace ?? defaultColorSpace;
    _currentColor = widget.color ?? defaultColor;

    List<Map<String, dynamic>> _colorWidgets = [
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceRGB),
        'widget': GCWColorRGB(
          color: _currentColorSpace == keyColorSpaceRGB ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceHex),
        'widget': GCWColorHexCode(
          color: _currentColorSpace == keyColorSpaceHex ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceHSV),
        'widget': GCWColorHSV(
          color: _currentColorSpace == keyColorSpaceHSV ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceHSL),
        'widget': GCWColorHSL(
          color: _currentColorSpace == keyColorSpaceHSL ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceHSI),
        'widget': GCWColorHSI(
          color: _currentColorSpace == keyColorSpaceHSI ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceCMYK),
        'widget': GCWColorCMYK(
          color: _currentColorSpace == keyColorSpaceCMYK ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceCMY),
        'widget': GCWColorCMY(
          color: _currentColorSpace == keyColorSpaceCMY ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceYUV),
        'widget': GCWColorYUV(
          color: _currentColorSpace == keyColorSpaceYUV ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceYPbPr),
        'widget': GCWColorYPbPr(
          color: _currentColorSpace == keyColorSpaceYPbPr ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceYCbCr),
        'widget': GCWColorYCbCr(
          color: _currentColorSpace == keyColorSpaceYCbCr ? _currentColor : null,
          onChanged: (newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceYIQ),
        'widget': GCWColorYIQ(
          color: _currentColorSpace == keyColorSpaceYIQ ? _currentColor : null,
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
            return GCWDropDownMenuItem(
              value: colorSpace.key,
              child: i18n(context, colorSpace.name),
            );
          }).toList(),
        ),
      ],
    );

    var _currentWidget = _colorWidgets.firstWhere((entry) => entry['colorSpace'].key == _currentColorSpace)['widget'];

    _widget.children.add(_currentWidget);

    return _widget;
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged({'colorSpace': _currentColorSpace, 'color': _currentColor});
  }
}
