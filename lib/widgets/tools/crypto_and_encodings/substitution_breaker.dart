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


class SubstitutionBreaker extends StatefulWidget {
  @override
  SubstitutionBreakerState createState() => SubstitutionBreakerState();
}

class SubstitutionBreakerState extends State<SubstitutionBreaker> {

  String _currentInput = '';
  BreakerAlphabet _currentAlphabet = BreakerAlphabet.German;


  @override
  Widget build(BuildContext context) {
    var BreakerAlphabetItems = {
      BreakerAlphabet.English : i18n(context, 'substitution_breaker_alphabet_german'),
      BreakerAlphabet.German : i18n(context, 'substitution_breaker_alphabet_english'),
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
              _buildOutput();
            });
          },
        ),
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput();

    var _currentOutput = break_cipher(_currentInput, _currentAlphabet);
    if (_currentOutput == null)
      return GCWDefaultOutput();
    if (_currentOutput.errorCode != ErrorCode.OK)
      return GCWDefaultOutput(child: _currentOutput.errorCode.toString());

    return GCWMultipleOutput(
      children: [
        _currentOutput.plaintext,
        GCWOutput(
          title: i18n(context, 'common_key'),
          child: GCWOutputText(

            text:
            _currentOutput.alphabet +'\n' + _currentOutput.key
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
}