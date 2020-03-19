import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_textinputformatter.dart';

class GCWIntegerListTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final textInputFormatter;
  final hintText;
  final min;
  final max;

  const GCWIntegerListTextField({
    Key key,
    this.onChanged,
    this.controller,
    this.textInputFormatter,
    this.hintText,
    this.min: 0,
    this.max
  }) : super(key: key);

  @override
  _GCWIntegerListTextFieldState createState() => _GCWIntegerListTextFieldState();
}

class _GCWIntegerListTextFieldState extends State<GCWIntegerListTextField> {
  @override
  Widget build(BuildContext context) {
    var allowNegativeValues = widget.min == null || widget.min < 0;

    return GCWTextField(
        hintText: widget.hintText,
        onChanged: (text) {
          setState(() {
            var list = textToIntList(text, allowNegativeValues: allowNegativeValues);
            widget.onChanged({'text': text, 'values': list});
          });
        },
        controller: widget.controller,
        inputFormatters: [widget.textInputFormatter ?? IntegerTextInputFormatter(
            min: widget.min,
            max: widget.max,
            allowNumberList: true)],
        keyboardType: TextInputType.numberWithOptions(
          signed: allowNegativeValues,
          decimal: false
        ),
      );
  }
}