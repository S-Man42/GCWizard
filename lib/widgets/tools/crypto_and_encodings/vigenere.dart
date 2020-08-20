import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/text_onlyletters_textinputformatter.dart';

class Vigenere extends StatefulWidget {
  @override
  VigenereState createState() => VigenereState();
}

class VigenereState extends State<Vigenere> {
  var _inputController;
  var _keyController;

  String _currentInput = '';
  String _currentKey = '';
  int _currentAValue = 0;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  bool _currentAutokey = false;

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
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextField(
          inputFormatters: [TextOnlyLettersInputFormatter()],
          hintText: i18n(context, 'common_key'),
          controller: _keyController,
          onChanged: (text) {
            setState(() {
              _currentKey = text;
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
        GCWOnOffSwitch(
          title: i18n(context, 'vigenere_autokey'),
          onChanged: (value) {
            setState(() {
              _currentAutokey = value;
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
      output = encryptVigenere(_currentInput, _currentKey, _currentAutokey, aValue: _currentAValue);
    } else {
      output = decryptVigenere(_currentInput, _currentKey, _currentAutokey, aValue: _currentAValue);
    }

    return GCWDefaultOutput(
      text: output
    );

  }
}