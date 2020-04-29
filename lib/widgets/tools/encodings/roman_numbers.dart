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
  var _encodeController;
  var _decodeController;

  var _currentEncodeInput = defaultIntegerText;
  var _currentDecodeInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  RomanNumberType _currentRomanNumbersTypeMode = RomanNumberType.USE_SUBTRACTION_RULE;

  String _output = '';

  @override
  void initState() {
    super.initState();

    _encodeController = TextEditingController(text: _currentEncodeInput['text']);
    _decodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
          ? GCWIntegerTextField(
              controller: _encodeController,
              max: 100000,
              onChanged: (text) {
                setState(() {
                  _currentEncodeInput = text;
                  _calculateOutput();
                });
              },
            )
          : GCWTextField(
              controller: _decodeController,
              onChanged: (text) {
                setState(() {
                  _currentDecodeInput = text;
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
    if (_currentMode == GCWSwitchPosition.left) {
      _output = encodeRomanNumbers(_currentEncodeInput['value'], type: _currentRomanNumbersTypeMode) ?? '';
    } else {
      var value = decodeRomanNumbers(_currentDecodeInput);
      _output = value == null ? '' : value.toString();
    }
  }
}