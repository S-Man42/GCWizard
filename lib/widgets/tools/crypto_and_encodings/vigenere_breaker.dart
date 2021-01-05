import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/vigenere_breaker.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';


class VigenereBreaker extends StatefulWidget {
  @override
  VigenereBreakerState createState() => VigenereBreakerState();
}

class VigenereBreakerState extends State<VigenereBreaker> {

  String _currentInput = '';
  VigenereBreakerAlphabet _currentAlphabet = VigenereBreakerAlphabet.GERMAN;
  VigenereBreakerResult _currentOutput = null;
  bool _currentAutokey = false;
  var _minKeyLengthController;
  var _maxKeyLengthController;
  int _minKeyLength = 3;
  int _maxKeyLength = 30;


  var _isStarted = false;

  @override
  void initState() {
    super.initState();

    _minKeyLengthController =  TextEditingController(text: _minKeyLength.toString());
    _maxKeyLengthController =  TextEditingController(text: _maxKeyLength.toString());
  }

  @override
  void dispose() {
    _minKeyLengthController.dispose();
    _maxKeyLengthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var BreakerAlphabetItems = {
      VigenereBreakerAlphabet.ENGLISH : i18n(context, 'common_language_english'),
      VigenereBreakerAlphabet.GERMAN : i18n(context, 'common_language_german'),
      VigenereBreakerAlphabet.SPANISH : i18n(context, 'common_language_spanish'),
      VigenereBreakerAlphabet.FRENCH : i18n(context, 'common_language_french'),
    };

    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'vigenere_autokey'),
          onChanged: (value) {
            setState(() {
              _currentAutokey = value;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'common_alphabet')
        ),
        GCWDropDownButton(
          value: _currentAlphabet,
          onChanged: (value) {
            setState(() {
              _currentAlphabet = value;
            });
          },
          items: BreakerAlphabetItems.entries.map((alphabet) {
            return GCWDropDownMenuItem(
              value: alphabet.key,
              child: alphabet.value,
            );
          }).toList(),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                  text: i18n(context, 'vigenere_breaker_key_length_min') + ':'
              ),
              flex: 1
            ),
            Expanded(
              child: GCWIntegerSpinner(
                controller: _minKeyLengthController,
                value: _minKeyLength,
                min: 3,
                max: 999,
                onChanged: (value) {
                  setState(() {
                    _minKeyLength = value;
                    _maxKeyLength = max(_minKeyLength, _maxKeyLength);
                    _maxKeyLengthController.text = _maxKeyLength.toString();
                  });
                },
              ),
              flex: 2
            ),
          ]
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                text: i18n(context, 'vigenere_breaker_key_length_max') + ':' + ':'
              ),
              flex: 1
            ),
            Expanded(
              child: GCWIntegerSpinner(
                controller: _maxKeyLengthController,
                value: _maxKeyLength,
                min: 3,
                max: 999,
                onChanged: (value) {
                  setState(() {
                    _maxKeyLength = value;
                    _minKeyLength = min(_minKeyLength, _maxKeyLength);
                    _minKeyLengthController.text = _minKeyLength.toString();
                  });
                },
              ),
              flex: 2
            ),
          ]
        ),
        GCWButton(
          text: i18n(context, 'vigenere_breaker_start'),
          onPressed: () {
            setState(() {
              _calcOutput();
            });
          },
        ),

        _buildOutput(context),
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput();

    if (_currentOutput == null)
      return GCWDefaultOutput();

    if (_currentOutput.errorCode != VigenereBreakerErrorCode.OK){
      showToast( i18n(context, 'substitutionbreaker_error', parameters: [_currentOutput.errorCode]));
      return GCWDefaultOutput();
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.plaintext,
        Column(
          children: [
            GCWOutput(
              title: i18n(context, 'common_key'),
              child: GCWOutputText(
                text: _currentOutput.key
              ),
            ),
          ],
        )
      ],
    );
  }


  _calcOutput() async {
    if (_currentInput == null || _currentInput.length == 0 || _isStarted)
      return;

    _isStarted = true;

    var _currentOutputFuture = break_cipher(_currentInput, _currentAutokey ? VigenereBreakerType.AUTOKEYVIGENERE : VigenereBreakerType.VIGENERE, _currentAlphabet, _minKeyLength, _maxKeyLength);
    _currentOutputFuture.then((output) {
      _currentOutput = output;
      _isStarted = false;
      this.setState(() {});
    });
  }

}