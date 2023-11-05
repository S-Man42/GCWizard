import 'package:flutter/material.dart';
import 'package:prefs/prefs.dart';

import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

class UpsideDown extends StatefulWidget {
  const UpsideDown({Key? key}) : super(key: key);

  @override
  UpsideDownState createState() => UpsideDownState();
}

class UpsideDownState extends State<UpsideDown> {
  late TextEditingController _inputControllerDecode;
  late TextEditingController _inputControllerEncode;

  String _currentInputEncode = '';
  String _currentInputDecode = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  double _fontSize = Prefs.getDouble(PREFERENCE_THEME_FONT_SIZE);

  @override
  void initState() {
    super.initState();
    _inputControllerDecode = TextEditingController(text: _currentInputDecode);
    _inputControllerEncode = TextEditingController(text: _currentInputEncode);
  }

  @override
  void dispose() {
    _inputControllerDecode.dispose();
    _inputControllerEncode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
            ? GCWTextField(
                controller: _inputControllerDecode,
                style: TextStyle(fontFamily: 'Quirkus', fontSize: _fontSize),
                onChanged: (text) {
                  setState(() {
                    _currentInputDecode = text;
                  });
                })
            : GCWTextField(
                controller: _inputControllerEncode,
                onChanged: (text) {
                  setState(() {
                    _currentInputEncode = text;
                  });
                }),
        _buildOutput(),
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      // decode
      return GCWDefaultOutput(
        child: _currentInputDecode.split('').reversed.toList().join(''),
      );
    } else {
      // encode
      return GCWDefaultOutput(
            child: Text(
              _currentInputEncode.split('').reversed.toList().join(''),
              style: TextStyle(
                  fontFamily: 'Quirkus',
                  fontSize: _fontSize,
                  letterSpacing: 1),
            )
      );
    }
  }
}
