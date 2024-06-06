import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/ragbaby/logic/ragbaby.dart';

class Ragbaby extends StatefulWidget {
  const Ragbaby({Key? key}) : super(key: key);

  @override
  _RagbabyState createState() => _RagbabyState();
}

class _RagbabyState extends State<Ragbaby> {
  late TextEditingController _inputController;
  late TextEditingController _passwordController;

  String _currentInput = '';
  String _currentPassword = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();

  _inputController = TextEditingController(text: _currentInput);
  _passwordController = TextEditingController(text: _currentPassword);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          hintText: i18n(context, 'common_programming_hint_input'),
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextField(
          hintText: i18n(context, 'common_key'),
          controller: _passwordController,
          onChanged: (text) {
            setState(() {
              _currentPassword = text;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, "common_alphabet")),
        GCWText(text: translatePasswordIntoKey(_currentPassword)),
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
      output = encryptRagbaby(
        _currentInput,
        _currentPassword,
      );
    } else {
      output = decryptRagbaby(
        _currentInput,
        _currentPassword,
      );
    }

    return GCWDefaultOutput(child: output);
  }
}
