import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/kamasutra.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Kamasutra extends StatefulWidget {
  @override
  KamasutraState createState() => KamasutraState();
}

class KamasutraState extends State<Kamasutra> {
  var _currentInput = '';
  var _currentAlphabet = '';
  var _currentAlphabetMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'common_alphabet'),
          leftValue: 'A-Z',
          rightValue: i18n(context, 'common_custom'),
          value: _currentAlphabetMode,
          onChanged: (value) {
            setState(() {
              _currentAlphabetMode = value;
            });
          },
        ),
        if (_currentAlphabetMode == GCWSwitchPosition.right)
          GCWTextField(
            onChanged: (text) {
              setState(() {
                _currentAlphabet = text;
              });
            }
          ),
        GCWDefaultOutput(
          child: _calculateOutput()
        )
      ],
    );
  }

  _calculateOutput() {
    var alphabet = _currentAlphabetMode == GCWSwitchPosition.left ? alphabet_AZString : _currentAlphabet;
    return encryptKamasutra(_currentInput, alphabet);
  }
}