import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/trithemius.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Trithemius extends StatefulWidget {
  @override
  TrithemiusState createState() => TrithemiusState();
}

class TrithemiusState extends State<Trithemius> {
  var _inputController;

  String _currentInput = '';
  int _currentAValue = 0;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

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
        GCWIntegerSpinner(
          title: 'A',
          onChanged: (value) {
            setState(() {
              _currentAValue = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
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
      output = encryptTrithemius(_currentInput, aValue: _currentAValue);
    } else {
      output = decryptTrithemius(_currentInput, aValue: _currentAValue);
    }

    return GCWDefaultOutput(child: output);
  }
}
