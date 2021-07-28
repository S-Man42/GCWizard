import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/roman_numbers/roman_numbers.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
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
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  RomanNumberType _currentRomanNumbersTypeMode = RomanNumberType.USE_SUBTRACTION_RULE;

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
                  });
                },
              )
            : GCWTextField(
                controller: _decodeController,
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
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
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    List<dynamic> output;

    if (_currentMode == GCWSwitchPosition.left) {
      if (_currentEncodeInput == null || _currentEncodeInput['text'] == null || _currentEncodeInput['text'].isEmpty)
        return GCWDefaultOutput();

      output = [
        encodeRomanNumbers(_currentEncodeInput['value'], type: RomanNumberType.USE_SUBTRACTION_RULE) ?? '',
        encodeRomanNumbers(_currentEncodeInput['value'], type: RomanNumberType.ONLY_ADDITION) ?? ''
      ];
    } else {
      if (_currentDecodeInput == null || _currentDecodeInput.isEmpty) return GCWDefaultOutput();

      output = [
        decodeRomanNumbers(_currentDecodeInput, type: RomanNumberType.USE_SUBTRACTION_RULE) ?? '',
        decodeRomanNumbers(_currentDecodeInput, type: RomanNumberType.ONLY_ADDITION) ?? ''
      ];
    }

    return GCWMultipleOutput(children: [
      output[0],
      GCWOutput(
        child: output[1],
        title: i18n(context, 'romannumbers_withoutsubtractionrule'),
      )
    ]);
  }
}
