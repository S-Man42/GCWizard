import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_rgb.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class ColorPicker extends StatefulWidget {
  @override
  ColorPickerState createState() => ColorPickerState();
}

class ColorPickerState extends State<ColorPicker> {
  dynamic _currentColor = defaultColor;

  String _currentColorSpace = keyColorsRGB;
  String _currentOutputColorSpace = keyColorsHex;

  String _output = '';

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
              _output = result.toString();
            });
          },
        ),
        GCWDropDownButton(
          value: _currentOutputColorSpace,
          onChanged: (newValue) {
            setState(() {
              _currentOutputColorSpace = newValue;
            });
          },
          items: allColorSpaces.map((colorSpace) {
            return DropdownMenuItem(
              value: colorSpace.key,
              child: Text(colorSpace.name),
            );
          }).toList(),
        ),
        GCWDefaultOutput(
          text: _calculateOutput()
        )
      ],
    );
  }

  _calculateOutput() {
    var color = convertColorSpace(_currentColor, _currentColorSpace, _currentOutputColorSpace).toString();
    return '$_currentColorSpace -> $_currentOutputColorSpace\n$color';
  }
}