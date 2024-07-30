import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/porta/logic/porta.dart';

import '../../../../application/i18n/logic/app_localizations.dart';

class Porta extends StatefulWidget {
  const Porta({Key? key}) : super(key: key);

  @override
  _PortaState createState() => _PortaState();
}

class _PortaState extends State<Porta> {
  late TextEditingController _inputController;
  late TextEditingController _keyController;

  var _currentInput = '';
  var _currentKey = '';
  var _currentTableVersion = GCWSwitchPosition.left;

  String _output = '';

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _keyController = TextEditingController(text: _currentKey);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          hintText: i18n(context,"common_input"),
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextField(
          hintText: i18n(context,"common_key"),
          controller: _keyController,
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          leftValue: 'v1',
          rightValue: 'v2',
          value: _currentTableVersion,
          onChanged: (value) {
            setState(() {
              _currentTableVersion = value;
            });
          },
        ),
        
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentTableVersion == GCWSwitchPosition.left) {
      _output =
          togglePorta(_currentInput, _currentKey, version: 1);
    } else {
      _output =
          togglePorta(_currentInput, _currentKey, version: 2);
    }

    return GCWDefaultOutput(child: _output);
  }
}
