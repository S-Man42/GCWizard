import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/base/hsv_picker/widget/hsv_picker.dart';

class GCWColorPicker extends StatefulWidget {
  final Function onChanged;
  final HSVColor hsvColor;

  const GCWColorPicker({Key key, @required this.hsvColor, @required this.onChanged}) : super(key: key);

  @override
  GCWColorPickerState createState() => GCWColorPickerState();
}

class GCWColorPickerState extends State<GCWColorPicker> {
  HSVColor _currentColor;

  @override
  Widget build(BuildContext context) {
    _currentColor = widget.hsvColor;

    return Row(
      children: [
        Container(
          height: 100,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: themeColors().mainFont(), width: 1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(3 * ROUNDED_BORDER_RADIUS)),
            color: _currentColor.toColor(),
          ),
          margin: EdgeInsets.only(right: 7 * DEFAULT_MARGIN),
        ),
        Expanded(
            child: HSVPicker(
          color: _currentColor,
          onChanged: widget.onChanged,
        )),
      ],
    );
  }
}
