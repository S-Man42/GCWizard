import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class GCWCheckBox extends StatefulWidget {
  final bool value;
  final Function onChanged;
  final Alignment align;
  final bool tristate;
  final Color activeColor;
  final MaterialStateProperty<Color> fillColor;
  final Color checkColor;
  final Color focusColor;
  final Color hoverColor;
  final MaterialStateProperty<Color> overlayColor;

  const GCWCheckBox(
      {Key key,
      this.value,
      this.onChanged,
      this.align: Alignment.centerLeft,
      this.tristate = false,
      this.activeColor,
      this.fillColor,
      this.checkColor,
      this.focusColor,
      this.hoverColor,
      this.overlayColor})
      : super(key: key);

  @override
  _GCWCheckBoxState createState() => _GCWCheckBoxState();
}

class _GCWCheckBoxState extends State<GCWCheckBox> {
  ThemeColors colors = themeColors();

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: widget.align,
        child: Checkbox(
          value: widget.value,
          onChanged: widget.onChanged,
          tristate: widget.tristate,
          activeColor: widget.activeColor,
          fillColor: widget.fillColor,
          checkColor: widget.checkColor,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          overlayColor: widget.overlayColor,
        ));
  }
}
