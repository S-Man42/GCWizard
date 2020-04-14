import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_color_rgb.dart';
import 'package:gc_wizard/widgets/common/colors/gcw_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class ColorPicker extends StatefulWidget {
  @override
  ColorPickerState createState() => ColorPickerState();
}

class ColorPickerState extends State<ColorPicker> {
  dynamic _currentColor = defaultColor;

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
          onChanged: (result) {
            setState(() {
              _currentColor = result['color'];
              _output = result.toString();
            });
          },
        ),
        GCWDefaultOutput(
          text: _output
        )
      ],
    );
  }
}