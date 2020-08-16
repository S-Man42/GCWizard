import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class GCWIntegerSpinner extends StatefulWidget {
  final Function onChanged;
  final title;
  final value;
  final min;
  final max;
  final controller;
  final SpinnerLayout layout;
  final focusNode;
  final isBinary;

  const GCWIntegerSpinner({
    Key key,
    this.onChanged,
    this.title,
    this.value: 0,
    this.min: -9007199254740991,
    this.max: 9007199254740992,
    this.controller,
    this.layout: SpinnerLayout.horizontal,
    this.focusNode,
    this.isBinary: false
  }) : super(key: key);

  @override
  GCWIntegerSpinnerState createState() => GCWIntegerSpinnerState();
}

class GCWIntegerSpinnerState extends State<GCWIntegerSpinner> {
  var _controller;
  var _currentValue = 1;

  var _binaryMaskFormatter = MaskTextInputFormatter(
    mask: '#' * 10000,
    filter: {"#": RegExp(r'[01]')}
  );

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller;
    } else {
      if (widget.value != null)
        _currentValue = widget.value;

      _controller = TextEditingController(text: widget.isBinary ? _currentValue.toRadixString(2) : _currentValue.toString());
    }
  }

  @override
  void dispose() {
    if (widget.controller == null)
      _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSpinner();
  }

  _decreaseValue() {
    setState(() {
      if (widget.min == null || _currentValue > widget.min) {
        _currentValue--;
      } else if (_currentValue == widget.min && widget.max != null) {
        _currentValue = widget.max;
      }

      _setCurrentValueAndEmitOnChange(setTextFieldText: true);
    });
  }

  _increaseValue() {
    setState(() {
      if (widget.max == null || _currentValue < widget.max) {
        _currentValue++;
      } else if (_currentValue == widget.max && widget.min != null) {
        _currentValue = widget.min;
      }

      _setCurrentValueAndEmitOnChange(setTextFieldText: true);
    });
  }

  Widget _buildTitle() {
    return widget.title == null ?  Container() :
      Expanded(
        child: GCWText(
          text: widget.title + ':'
        ),
        flex: 1
      );
  }

  Widget _buildTextField() {
    return GCWIntegerTextField(
      focusNode: widget.focusNode,
      min: widget.min,
      max: widget.max,
      textInputFormatter: widget.isBinary ? _binaryMaskFormatter : null,
      controller: _controller,
      onChanged: (ret) {
        setState(() {
          _currentValue = widget.isBinary ? int.tryParse(ret['value'].toString(), radix: 2) : ret['value'];
          _setCurrentValueAndEmitOnChange();
        });
      }
    );
  }

  Widget _buildSpinner() {
    if (widget.layout == SpinnerLayout.horizontal) {
      return Row(
        children: <Widget>[
          _buildTitle(),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  child: GCWIconButton(
                    iconData: Icons.remove,
                    onPressed: _decreaseValue
                  ),
                  margin: EdgeInsets.only(
                    right: 2 * DEFAULT_MARGIN
                  ),
                ),
                Expanded(
                  child: _buildTextField()
                ),
                Container(
                  child: GCWIconButton(
                    iconData: Icons.add,
                    onPressed: _increaseValue
                  ),
                  margin: EdgeInsets.only(
                    left: 2 * DEFAULT_MARGIN
                  ),
                )
              ],
            ),
            flex: 3
          )
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          _buildTitle(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GCWIconButton(
                  iconData: Icons.arrow_drop_up,
                  onPressed: _increaseValue
                ),
                _buildTextField(),
                GCWIconButton(
                  iconData: Icons.arrow_drop_down,
                  onPressed: _decreaseValue
                ),
              ],
            ),
            flex: 3
          ),
        ],
      );
    }
  }

  _setCurrentValueAndEmitOnChange({setTextFieldText: false}) {
    if (setTextFieldText)
      _controller.text = widget.isBinary ? _currentValue.toRadixString(2) : _currentValue.toString();

    widget.onChanged(_currentValue);
  }
}