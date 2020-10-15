import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class SubstitutionBreaker extends StatefulWidget {
  @override
  SubstitutionBreakerState createState() => SubstitutionBreakerState();
}

class SubstitutionBreakerState extends State<SubstitutionBreaker> {

  String _currentInput = '';
  BreakerAlphabet _currentAlphabet = BreakerAlphabet.English;


  @override
  Widget build(BuildContext context) {
    var BreakerAlphabetItems = {
      BreakerAlphabet.English : i18n(context, 'chao_alphabet_az'),
      BreakerAlphabet.English : i18n(context, 'chao_alphabet_za'),
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
          text: i18n(context, 'chao_alphabet_cipher')
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

        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput();

    var _currentOutput = break_cipher(_currentInput, _currentAlphabet);
    if (_currentOutput == null)
      return GCWDefaultOutput();

    return GCWDefaultOutput(
      child: _currentOutput.plaintext,
    );
  }
}