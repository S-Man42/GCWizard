import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/double_textinputformatter.dart';

class GCWDoubleTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final allowNegativeValues;
  final textInputFormatter;
  final hintText;

  const GCWDoubleTextField({
    Key key,
    this.onChanged,
    this.controller,
    this.allowNegativeValues,
    this.textInputFormatter,
    this.hintText
  }) : super(key: key);

  @override
  _GCWDoubleTextFieldState createState() => _GCWDoubleTextFieldState();
}

class _GCWDoubleTextFieldState extends State<GCWDoubleTextField> {

  @override
  Widget build(BuildContext context) {
    return GCWTextField(
        hintText: widget.hintText,
        onChanged: (text) {
          setState(() {
            var _value;

            text = text.replaceFirst(',', '.');

            if (['', '-', '.'].contains(text)) {
              _value = 0.0;
            } else {
              _value = double.tryParse(text);
            }

            widget.onChanged({'text': text, 'value': _value});
          });
        },
        controller: widget.controller,
        inputFormatters: [widget.textInputFormatter ?? DoubleTextInputFormatter(allowNegativeValues: widget.allowNegativeValues ?? true)],
        keyboardType: TextInputType.numberWithOptions(
          signed: true,
          decimal: true
        ),
      );
  }
}
