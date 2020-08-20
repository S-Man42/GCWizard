import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/base.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_standard_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Base32 extends StatefulWidget {
  @override
  Base32State createState() => Base32State();
}

class Base32State extends State<Base32> {
  var _inputController;

  String _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    if (_currentMode == GCWSwitchPosition.left) {
      output = base32Encode(_currentInput);
    } else {
      output = decode(_currentInput, base32Decode);
    }

    return GCWStandardOutput(
      text: output
    );
  }
}