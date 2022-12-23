import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/integer_textinputformatter/widget/integer_textinputformatter.dart';

class GCWIntegerTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final textInputFormatter;
  final hintText;
  final min;
  final max;
  final FocusNode focusNode;

  const GCWIntegerTextField(
      {Key key,
      this.onChanged,
      this.controller,
      this.textInputFormatter,
      this.hintText,
      this.min,
      this.max,
      this.focusNode})
      : super(key: key);

  @override
  _GCWIntegerTextFieldState createState() => _GCWIntegerTextFieldState();
}

class _GCWIntegerTextFieldState extends State<GCWIntegerTextField> {
  var _integerInputFormatter;

  @override
  void initState() {
    super.initState();

    _integerInputFormatter = IntegerTextInputFormatter(min: widget.min, max: widget.max);
  }

  @override
  Widget build(BuildContext context) {
    return GCWTextField(
      hintText: widget.hintText,
      onChanged: (text) {
        setState(() {
          var _value = ['', '-'].contains(text) ? max<int>(widget.min ?? 0, 0) : int.tryParse(text);

          if (widget.min != null && _value < widget.min) _value = widget.min;

          if (widget.max != null && _value > widget.max) _value = widget.max;

          widget.onChanged({'text': text, 'value': _value});
        });
      },
      controller: widget.controller,
      inputFormatters: [widget.textInputFormatter ?? _integerInputFormatter],
      keyboardType: TextInputType.numberWithOptions(signed: widget.min == null || widget.min < 0, decimal: false),
      focusNode: widget.focusNode,
    );
  }
}
