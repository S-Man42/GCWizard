import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/beghilos.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Beghilos extends StatefulWidget {
  @override
  BeghilosState createState() => BeghilosState();
}

class BeghilosState extends State<Beghilos> {
  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.right;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(onChanged: (text) {
          setState(() {
            _currentInput = text;
          });
        }),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWDefaultOutput(child:  _currentMode == GCWSwitchPosition.left ? decodeBeghilos(_currentInput) : encodeBeghilos(_currentInput))
      ],
    );
  }
}
