import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/double_textinputformatter.dart';

class GCWDoubleTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final textInputFormatter;
  final hintText;
  final min;
  final max;
  final FocusNode focusNode;
  final numberDecimalDigits;

  const GCWDoubleTextField({
    Key key,
    this.onChanged,
    this.controller,
    this.textInputFormatter,
    this.hintText,
    this.min,
    this.max,
    this.focusNode,
    this.numberDecimalDigits
  }) : super(key: key);

  @override
  _GCWDoubleTextFieldState createState() => _GCWDoubleTextFieldState();
}

class _GCWDoubleTextFieldState extends State<GCWDoubleTextField> {
  var _doubleInputFormatter;

  @override
  void initState() {
    super.initState();

    _doubleInputFormatter = DoubleTextInputFormatter(
      min: widget.min,
      max: widget.max,
      numberDecimalDigits: widget.numberDecimalDigits
    );
  }

  @override
  Widget build(BuildContext context) {
    return GCWTextField(
      focusNode: widget.focusNode,
      hintText: widget.hintText,
      onChanged: (text) {
        setState(() {
          double _value;

          text = text.replaceFirst(',', '.');

          if (['', '-', '.'].contains(text)) {
            _value = 0.0;
          } else {
            _value = double.tryParse(text);
          }

          if (widget.min != null && _value < widget.min)
            _value = widget.min;

          if (widget.max != null && _value > widget.max)
            _value = widget.max;

          widget.onChanged({'text': text, 'value': _value});
        });
      },
      controller: widget.controller,
      inputFormatters: [widget.textInputFormatter ?? _doubleInputFormatter],
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: true
      ),
    );
  }
}
