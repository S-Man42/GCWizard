import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/whitespace_language.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class WhitespaceLanguage extends StatefulWidget {
  @override
  WhitespaceLanguageState createState() => WhitespaceLanguageState();
}

class WhitespaceLanguageState extends State<WhitespaceLanguage> {

  WhitespaceResult _currentOutput = null;

  String _currentInput = '';
  String _currentKey = '';
  var _isStarted = false;

  var _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),

        GCWTextDivider(
          text: i18n(context, 'common_key')
        ),
        GCWTextField(
          hintText: i18n(context, 'common_key'),
          onChanged: (text) {
            setState(() {
              _currentKey = text;
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

        GCWButton(
          text: i18n(context, 'substitutionbreaker_start'),
          onPressed: () {
            setState(() {
              _calcOutput();
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput();

    if (_currentOutput == null)
      return GCWDefaultOutput();

    return GCWMultipleOutput(
      children: [
        _currentOutput.output,
        GCWOutput(
          title: i18n(context, 'solitaire_keystream'),
          child: GCWOutputText(
            text: _currentOutput.output,
          ),
        ),
        GCWOutput(
          title: i18n(context, 'solitaire_resultdeck'),
          child: GCWOutputText(
            text: _currentOutput.error ? _currentOutput.errorText + '\n' : '' + _currentOutput.code,
          ),
        )
      ],
    );
  }

  _calcOutput() async {
    if (_currentInput == null || _currentInput.length == 0 || _isStarted)
      return;

    _isStarted = true;

    if (_currentMode == GCWSwitchPosition.left) {
      var currentOutputFuture = encodeWhitespace(_currentInput);
      currentOutputFuture.then((output) {
        _currentOutput = output;
        _isStarted = false;
        this.setState(() {});
      });
    } else {
      var currentOutputFuture = decodeWhitespace(_currentInput, _currentKey);
      currentOutputFuture.then((output) {
        _currentOutput = output;
        _isStarted = false;
        this.setState(() {});
      });
    }
  }
}