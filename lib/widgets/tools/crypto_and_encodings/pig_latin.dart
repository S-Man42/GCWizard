import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/pig_latin.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_standard_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class PigLatin extends StatefulWidget {
  @override
  PigLatinState createState() => PigLatinState();
}

class PigLatinState extends State<PigLatin> {
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
        GCWStandardOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null)
      return '';

    var out = _currentMode == GCWSwitchPosition.left
      ? encryptPigLatin(_currentInput)
      : decryptPigLatin(_currentInput);

    return out;
  }
}