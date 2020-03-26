import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_textinputformatter.dart';
import 'package:gc_wizard/utils/common_utils.dart';

import 'dart:math';

class GCWIntegerTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final textInputFormatter;
  final hintText;
  final min;
  final max;
  final FocusNode focusNode;

  const GCWIntegerTextField({
    Key key,
    this.onChanged,
    this.controller,
    this.textInputFormatter,
    this.hintText,
    this.min,
    this.max,
    this.focusNode
  }) : super(key: key);

  @override
  _GCWIntegerTextFieldState createState() => _GCWIntegerTextFieldState();
}

class _GCWIntegerTextFieldState extends State<GCWIntegerTextField> {

  @override
  Widget build(BuildContext context) {
    var allowNegativeValues = widget.min == null || widget.min < 0;
    
    return GCWTextField(
        hintText: widget.hintText,
        onChanged: (text) {
          setState(() {
            
            List<int> values = textToIntList(text, allowNegativeValues: allowNegativeValues);
            int value = 0;
            
            if (values.length > 0) {
              
              value = values[0];
  
              if (widget.min != null && value < widget.min) {
                value = widget.min;
              }

              if (widget.max != null && value > widget.max) {
                value = widget.max;
              }
            } else {
              if (widget.min != null) {
                value = widget.min;
              } else if (widget.max) {
                value = widget.max;
              } else {
                value = 0;
              }
            }

            widget.onChanged({'text': text, 'value': value});
          });
        },
        controller: widget.controller,
        inputFormatters: [widget.textInputFormatter ?? IntegerTextInputFormatter(
          allowNegativeValues: allowNegativeValues,
          allowNumberList: false
        )],
        keyboardType: TextInputType.numberWithOptions(
          signed: widget.min == null || widget.min < 0,
          decimal: false
        ),
        focusNode: widget.focusNode,
      );
  }
}