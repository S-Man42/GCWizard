import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

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
  TextEditingController _controller;

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

    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return TextFormField(
          autocorrect: false,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            isDense: true,
            suffixIconConstraints: BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            suffixIcon: constraints.maxWidth > 100
              ? InkWell(
                  child: Container(
                    child: Icon(
                      Icons.clear,
                      color: ThemeColors.iconColor,
                    ),
                    padding: EdgeInsets.only(
                      right: 5,
                      top: 5,
                      bottom: 5
                    ),
                  ),
                  onTap: () {
                    if (widget.controller != null)
                      widget.controller.clear();

                    _controller.clear();

                    if (widget.onChanged != null)
                      widget.onChanged('');
                  },
                )
              : null
          ),
          onChanged: widget.onChanged,
          controller: widget.controller ?? _controller,
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
    );
  }
}
