import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:intl/intl.dart';

class GCWDoubleSpinner extends StatefulWidget {
  final Function onChanged;
  final title;
  final value;
  final min;
  final max;
  final controller;
  final numberDecimalDigits;
  final SpinnerLayout layout;
  final focusNode;

  var _numberFormat;

  GCWDoubleSpinner({
    Key key,
    this.onChanged,
    this.title,
    this.value,
    this.min,
    this.max,
    this.numberDecimalDigits: 2,
    this.controller,
    this.layout: SpinnerLayout.horizontal,
    this.focusNode
  }) : super(key: key) {
    var formatString = '0';
    if (numberDecimalDigits > 0)
      formatString += '.' + '0' * numberDecimalDigits;

    _numberFormat = NumberFormat(formatString);
  }

  @override
  GCWDoubleSpinnerState createState() => GCWDoubleSpinnerState();
}

class GCWDoubleSpinnerState extends State<GCWDoubleSpinner> {
  var _controller;

  var _currentValue = 0.0;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller;
    } else {
      print(widget.value);
      if (widget.value != null)
        _currentValue = widget.value;

      _controller = TextEditingController(text: widget._numberFormat.format(_currentValue));
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
        var newValue = _currentValue;
        if (newValue.floor() == newValue) {
          newValue--;
        } else {
          newValue = newValue.floor().toDouble();
        }

        _currentValue = max(widget.min, newValue);
      }

      _setCurrentValueAndEmitOnChange(setTextFieldText: true);
    });
  }

  _increaseValue() {
    setState(() {
      if (widget.max == null || _currentValue < widget.max) {
        var newValue = _currentValue;
        if (newValue.ceil() == newValue) {
          newValue++;
        } else {
          newValue = newValue.ceil().toDouble();
        }

        _currentValue = min(widget.max, newValue);
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
    return GCWDoubleTextField(
      focusNode: widget.focusNode,
      min: widget.min,
      max: widget.max,
      controller: _controller,
      onChanged: (ret) {
        setState(() {
          _currentValue = ret['value'];
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
                  margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0
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
                  margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0
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
      _controller.text = widget._numberFormat.format(_currentValue);

    widget.onChanged(_currentValue);
  }
}