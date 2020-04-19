import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/roman_numbers.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class RomanNumbers extends StatefulWidget {
  @override
  RomanNumbersState createState() => RomanNumbersState();
}

class RomanNumbersState extends State<RomanNumbers> {
  var _controller;

  var _currentInput = defaultIntegerText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  RomanNumberType _currentRomanNumbersTypeMode = RomanNumberType.USE_SUBTRACTION_RULE;

  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput['text']);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
          ? GCWIntegerTextField(
              controller: _controller,
              max: 100000,
              onChanged: (text) {
                setState(() {
                  _currentInput = text;
                  _calculateOutput();
                });
              },
            )
          : GCWTextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  _currentInput = {'text': text, 'value' : null};
                  _calculateOutput();
                });
              },
            ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'romannumbers_numberstoroman'),
          rightValue: i18n(context, 'romannumbers_romantonumbers'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;

              if (_currentMode == GCWSwitchPosition.left) {
                var value = extractIntegerFromText(_currentInput['text']);
                var text = value == null ? '' : value.toString();
                _currentInput = {'text': text, 'value': value};
                _controller.text = text;
              }

              _calculateOutput();
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
          ? GCWOnOffSwitch(
              title: i18n(context, 'romannumbers_subtractionrule'),
              value: _currentRomanNumbersTypeMode == RomanNumberType.USE_SUBTRACTION_RULE,
              onChanged: (value) {
                setState(() {
                  _currentRomanNumbersTypeMode = value ? RomanNumberType.USE_SUBTRACTION_RULE : RomanNumberType.ONLY_ADDITION;
                  _calculateOutput();
                });
              },
            )
          : Container(),
        GCWDefaultOutput(
          text: _output
        )
      ],
    );
  }

  _calculateOutput() {
    String text = _currentInput['text'];

    if (_currentMode == GCWSwitchPosition.left) {
      _output = encodeRomanNumbers(_currentInput['value'], type: _currentRomanNumbersTypeMode) ?? '';
    } else {
      var value = decodeRomanNumbers(_currentInput['text']);
      _output = value == null ? '' : value.toString();
    }
  }
}