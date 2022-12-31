import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/vigenere/logic/vigenere.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_output/widget/gcw_output.dart';

class Rot123 extends StatefulWidget {
  @override
  Rot123State createState() => Rot123State();
}

class Rot123State extends State<Rot123> {
  var _controller;

  String _currentInput = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null || _currentInput.isEmpty) return GCWDefaultOutput();

    return Column(
      children: [
        GCWDefaultOutput(child: encryptVigenere(_currentInput, alphabet_AZ.keys.join(), false, aValue: 1)),
        GCWOutput(
            title: i18n(context, 'rotation_general_reverse'),
            child: decryptVigenere(_currentInput, alphabet_AZ.keys.join(), false, aValue: 1)),
      ],
    );
  }
}
