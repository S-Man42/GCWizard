import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_hue.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_yuv.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_hsv.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_rgb.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_yuv.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class GCWColors extends StatefulWidget {
  final Function onChanged;
  final dynamic color;
  final String text;

  const GCWColors({Key key, this.text, this.onChanged, this.color}) : super(key: key);

  @override
  GCWColorsState createState() => GCWColorsState();
}

class GCWColorsState extends State<GCWColors> {

  String _currentColorSpace = defaultColorSpace;
  dynamic _currentColor = defaultColor;

  @override
  Widget build(BuildContext context) {
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
    ];

    List<ColorSpace> _onlyColorSpaces = _colorWidgets.map((entry) => entry['colorSpace'] as ColorSpace).toList();

    Column _widget = Column(
      children: <Widget>[
        GCWTextDivider(
          text: widget.text
        ),
        GCWDropDownButton(
          value: _currentColorSpace,
          onChanged: (newValue) {
            setState(() {
              _convertColorSpace(newValue);
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

  _convertColorSpace(newColorSpace) {
    if (newColorSpace == _currentColorSpace) {
      return;
    }

    if (_currentColorSpace != keyColorsRGB) {
      _currentColor = _currentColor.toRGB();
    }

    switch (newColorSpace) {
      case keyColorsRGB: break;
      case keyColorsHSV: _currentColor = HSV.fromRGB(_currentColor); break;
      case keyColorsYUV: _currentColor = YUV.fromRGB(_currentColor); break;
    }
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged({
      'colorSpace': _currentColorSpace,
      'color': _currentColor
    });
  }
}