import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/fox.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Fox extends StatefulWidget {
  @override
  FoxState createState() => FoxState();
}

class FoxState extends State<Fox> {
  String _currentInput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

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
          value: _currentMode,
          onChanged: (mode) {
            setState(() {
              _currentMode = mode;
            });
          },
        ),
        GCWDefaultOutput(
          child: _buildOutput(),
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encodeFox(_currentInput);
    } else {
      return decodeFox(_currentInput);
    }
  }
}
