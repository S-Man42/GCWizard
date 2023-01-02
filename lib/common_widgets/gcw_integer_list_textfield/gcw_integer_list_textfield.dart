import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';

class GCWIntegerListTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final hintText;

  const GCWIntegerListTextField({
    Key key,
    this.onChanged,
    this.controller,
    this.hintText,
  }) : super(key: key);

  @override
  _GCWIntegerListTextFieldState createState() => _GCWIntegerListTextFieldState();
}

class _GCWIntegerListTextFieldState extends State<GCWIntegerListTextField> {
  @override
  Widget build(BuildContext context) {
    return GCWTextField(
      hintText: widget.hintText,
      onChanged: (text) {
        setState(() {
          var list = textToIntList(text);
          widget.onChanged({'text': text, 'values': list});
        });
      },
      controller: widget.controller,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9\s]'))],
    );
  }
}
