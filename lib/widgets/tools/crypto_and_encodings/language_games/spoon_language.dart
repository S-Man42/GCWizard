import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/language_games/spoon_language.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class SpoonLanguage extends StatefulWidget {
  @override
  SpoonLanguageState createState() => SpoonLanguageState();
}

class SpoonLanguageState extends State<SpoonLanguage> {
  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.right;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          }
        ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          child: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null)
      return '';

    var out = _currentMode == GCWSwitchPosition.left
      ? encryptSpoonLanguage(_currentInput)
      : decryptSpoonLanguage(_currentInput);

    return out;
  }
}