import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';

class ColorPicker extends StatefulWidget {
  @override
  ColorPickerState createState() => ColorPickerState();
}

class ColorPickerState extends State<ColorPicker> {
  Color _currentColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleColorPicker(
          initialColor: _currentColor,
          strokeWidth: 6,
          onChanged: (Color color) {
            setState(() {
              _currentColor = color;
            });
          },
        ),
        GCWDoubleSpinner(
          min: 3.534,
          max: 10.56,
          value: 4.0,
          numberDecimalDigits: 3,
          onChanged: (bla) {
            print(bla);
          },
        ),
       TextField(
          onChanged: (text) {
            setState(() {
              _currentColor = Colors.yellow;
            });
          },
        )
      ],
    );
  }
}