import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chicken_language.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class ChickenLanguage extends StatefulWidget {
  @override
  ChickenLanguageState createState() => ChickenLanguageState();
}

class ChickenLanguageState extends State<ChickenLanguage> {
  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.left;

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
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null)
      return '';

    var out = _currentMode == GCWSwitchPosition.left
      ? encryptChickenLanguage(_currentInput)
      : decryptChickenLanguage(_currentInput);

    return out;
  }
}