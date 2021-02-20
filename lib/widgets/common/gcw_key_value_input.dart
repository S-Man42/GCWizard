import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class GCWKeyValueInput extends StatefulWidget {
  final TextEditingController keyController;
  final Function onKeyChanged;
  final String keyHintText;
  final TextEditingController valueController;
  final List<TextInputFormatter> valueInputFormatters;
  final Function onValueChanged;
  final String valueHintText;
  final int valueFlex;
  final Function onAddPressed;
  final Widget replaceAdd;
  final Widget trailing;

  const GCWKeyValueInput({
    Key key,
    this.keyController,
    this.keyHintText,
    this.onKeyChanged,
    this.valueHintText,
    this.valueController,
    this.valueInputFormatters,
    this.onValueChanged,
    this.valueFlex,
    this.onAddPressed,
    this.replaceAdd,
    this.trailing
  }) : super(key: key);

  @override
  _GCWKeyValueInput createState() => _GCWKeyValueInput();
}

class _GCWKeyValueInput extends State<GCWKeyValueInput> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: GCWTextField(
                hintText: widget.keyHintText,
                controller: widget.keyController,
                onChanged: widget.onKeyChanged,
              ),
              flex: 1
            ),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
              child: GCWTextField(
                hintText: widget.valueHintText,
                controller:  widget.valueController,
                inputFormatters: widget.valueInputFormatters,
                onChanged: widget.onValueChanged,
              ),
              flex: widget.valueFlex ?? 1,
            ),
            widget.replaceAdd ??
            GCWIconButton(
              iconData: Icons.add,
              onPressed: widget.onAddPressed,
            ),
            widget.trailing ?? Container()
          ],
        ),
      ],
    );
  }
}
