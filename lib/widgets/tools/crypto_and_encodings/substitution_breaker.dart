import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/breaker.dart';

import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';

class SubstitutionBreaker extends StatefulWidget {
  @override
  SubstitutionBreakerState createState() => SubstitutionBreakerState();
}

class SubstitutionBreakerState extends State<SubstitutionBreaker> {

  String _currentInput = '';
  BreakerAlphabet _currentAlphabet = BreakerAlphabet.German;
  BreakerResult _currentOutput = null;

  var _isStarted = false;


  @override
  Widget build(BuildContext context) {
    var BreakerAlphabetItems = {
      BreakerAlphabet.English : i18n(context, 'substitution_breaker_alphabet_english'),
      BreakerAlphabet.German : i18n(context, 'substitution_breaker_alphabet_german'),
      BreakerAlphabet.Spanish : i18n(context, 'substitution_breaker_alphabet_spanish'),
      BreakerAlphabet.Polish : i18n(context, 'substitution_breaker_alphabet_polish'),
      BreakerAlphabet.Greek : i18n(context, 'substitution_breaker_alphabet_greek'),
      BreakerAlphabet.France : i18n(context, 'substitution_breaker_alphabet_france'),
      BreakerAlphabet.Russian : i18n(context, 'substitution_breaker_alphabet_russian'),
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
        GCWButton(
          text: i18n(context, 'substitution_breaker_start'),
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
    if (_currentOutput.errorCode != ErrorCode.OK){
      switch (_currentOutput.errorCode) {
        case ErrorCode.MAX_ROUNDS_PARAMETER:
          showToast("maximum number of rounds not in the valid range 1..10000");
          break;
        case ErrorCode.MAX_ROUNDS_PARAMETER:
          showToast("consolidate parameter out of valid range 1..30");
          break;
        case ErrorCode.TEXT_TOO_SHORT:
          showToast("ciphertext is too short");
          break;
        case ErrorCode.WRONG_GENERATE_TEXT:
          showToast("More than three characters from the given alphabet are required");
          break;
        case ErrorCode.ALPHABET_TOO_LONG:
          showToast("Alphabet must have less or equal than 32 characters");
          break;
      }
      return GCWDefaultOutput();
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.plaintext,
        GCWOutput(
          title: i18n(context, 'common_key'),
          child: GCWOutputText(

            text:
            _currentOutput.alphabet +'\n' + _currentOutput.key + '\n'
            + '\n'
            + 'keys/s: ' + _currentOutput.keys_per_second.toString() + '\n'
            + 'keys: ' + _currentOutput.nbr_keys.toString() + '\n'
            + 'rounds: ' + _currentOutput.nbr_rounds .toString() + '\n'
            + 'seconds: ' + _currentOutput.seconds .toString() + 's'
            ,
            isMonotype: true,
          ),
        )
      ],
    );
  }

  _calcOutput() async {
    if (_currentInput == null || _currentInput.length == 0 || _isStarted)
      return;

    try {
      _isStarted = true;

      _currentOutput = await break_cipher(_currentInput, _currentAlphabet);
      this.setState(() {});
    }
    finally {_isStarted = false;}
  }
}