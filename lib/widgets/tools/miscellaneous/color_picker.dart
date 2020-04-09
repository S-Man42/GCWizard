import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

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