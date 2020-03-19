import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto/playfair.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/text_onlyspaceandletters_textinputformatter.dart';

class Playfair extends StatefulWidget {
  @override
  PlayfairState createState() => PlayfairState();
}

class PlayfairState extends State<Playfair> {
  var _inputController;
  var _keyController;

  String _currentInput = '';
  String _currentKey = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentPlayfairMode = GCWSwitchPosition.left;


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
          inputFormatters: [TextOnlySpaceAndLettersInputFormatter()],
          hintText: i18n(context, 'common_key'),
          controller: _keyController,
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'playfair_mode'),
          leftValue: i18n(context, 'playfair_mode_jtoi'),
          rightValue: i18n(context, 'playfair_mode_wtovv'),
          onChanged: (value) {
            setState(() {
              _currentPlayfairMode = value;
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

    var playFairMode = _currentPlayfairMode == GCWSwitchPosition.left ? PlayFairMode.JToI : PlayFairMode.WToVV;

    if (_currentMode == GCWSwitchPosition.left) {
      output = encryptPlayfair(_currentInput, _currentKey, mode: playFairMode);
    } else {
      output = decryptPlayfair(_currentInput, _currentKey, mode: playFairMode);;
    }

    return GCWDefaultOutput(
      text: output
    );

  }
}