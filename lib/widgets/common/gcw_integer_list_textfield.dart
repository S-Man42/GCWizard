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
            var values = textToIntList(text, allowNegativeValues: allowNegativeValues);

            values = values.where((value) {
              if (widget.min != null && value < widget.min) {
                return false;
              }
  
              if (widget.max != null && value > widget.max) {
                return false;
              }
              
              return true;
            }).toList().cast<int>();
            
            widget.onChanged({'text': text, 'values': values});
          });
        },
        controller: widget.controller,
        inputFormatters: [widget.textInputFormatter ?? IntegerTextInputFormatter(
          allowNegativeValues: allowNegativeValues,
          allowNumberList: true
        )],
        keyboardType: TextInputType.numberWithOptions(
          signed: allowNegativeValues,
          decimal: false
        ),
      );
  }
}