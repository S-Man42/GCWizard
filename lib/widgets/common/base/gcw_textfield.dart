import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class GCWTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function onChanged;
  final Function validate;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final hintText;
  final FocusNode focusNode;
  final autofocus;
  final icon;

  const GCWTextField({
    Key key,
    this.onChanged,
    this.controller,
    this.validate,
    this.inputFormatters,
    this.keyboardType,
    this.hintText,
    this.focusNode,
    this.autofocus,
    this.icon
  }) : super(key: key);

  @override
  _GCWTextFieldState createState() => _GCWTextFieldState();
}

class _GCWTextFieldState extends State<GCWTextField> {

  @override
  void initState() {
    super.initState();

    if (widget.focusNode != null && widget.controller != null) {
      widget.focusNode.addListener(() {
        if (widget.focusNode.hasFocus) {
          widget.controller.selection = TextSelection(baseOffset: 0, extentOffset: widget.controller.text.length);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: widget.icon,
        hintText: widget.hintText ?? i18n(context, 'common_hinttext_default')
      ),
      onChanged: widget.onChanged,
      controller: widget.controller,
      autovalidate: true,
      validator: widget.validate,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      maxLines: null,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus ?? false,
      style: TextStyle(fontSize: defaultFontSize())
    );
  }
}
