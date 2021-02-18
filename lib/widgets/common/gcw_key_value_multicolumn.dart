import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class GCWKeyValueMultiColumn extends StatefulWidget {
  final TextEditingController keyController;
  final Function onKeyChanged;
  final String keyHintText;
  final TextEditingController valueController;
  final List<TextInputFormatter> valueInputFormatters;
  final Function onValueChanged;
  final String valueHintText;
  final Function onAddPressed;

  const GCWKeyValueMultiColumn({
    Key key,
    this.onKeyChanged,
    this.keyHintText,
    this.keyController,
    this.valueController,
    this.valueInputFormatters,
    this.onValueChanged,
    this.valueHintText,
    this.onAddPressed
  }) : super(key: key);

  @override
  _GCWKeyValueMultiColumn createState() => _GCWKeyValueMultiColumn();
}

class _GCWKeyValueMultiColumn extends State<GCWKeyValueMultiColumn> {
  TextEditingController _controller;

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
                )
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
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: widget.onAddPressed,
            )
          ],
        ),
      ],
    );
  }
}
