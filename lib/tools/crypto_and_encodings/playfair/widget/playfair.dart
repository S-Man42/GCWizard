import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/playfair/logic/playfair.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_alphabetmodification_dropdownbutton/gcw_alphabetmodification_dropdownbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_twooptions_switch/gcw_twooptions_switch.dart';

class Playfair extends StatefulWidget {
  @override
  PlayfairState createState() => PlayfairState();
}

class PlayfairState extends State<Playfair> {
  var _inputController;
  var _keyController;

  String _currentInput = '';
  String _currentKey = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  AlphabetModificationMode _currentModificationMode = AlphabetModificationMode.J_TO_I;

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
          hintText: i18n(context, 'common_key'),
          controller: _keyController,
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),
        GCWAlphabetModificationDropDownButton(
          value: _currentModificationMode,
          allowedModifications: [
            AlphabetModificationMode.J_TO_I,
            AlphabetModificationMode.W_TO_VV,
            AlphabetModificationMode.C_TO_K
          ],
          onChanged: (value) {
            setState(() {
              _currentModificationMode = value;
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
      output = encryptPlayfair(_currentInput, _currentKey, mode: _currentModificationMode);
    } else {
      output = decryptPlayfair(_currentInput, _currentKey, mode: _currentModificationMode);
    }

    return GCWDefaultOutput(child: output);
  }
}
