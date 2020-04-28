import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/morse.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Morse extends StatefulWidget {
  @override
  MorseState createState() => MorseState();
}

class MorseState extends State<Morse> {
  TextEditingController _inputController;

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
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildMorseButtons(context),
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildMorseButtons(BuildContext context) {
    if (_currentMode == GCWSwitchPosition.left)
      return Container();

    return GCWToolBar(
      children: [
        GCWButton(
          text: i18n(context, 'morse_short'),
          onPressed: () {
            setState(() {
              _addCharacter('.');
            });
          },
        ),
        GCWButton(
          text: i18n(context, 'morse_long'),
          onPressed: () {
            setState(() {
              _addCharacter('-');
            });
          },
        ),
        GCWButton(
          text: i18n(context, 'morse_next_letter'),
          onPressed: () {
            setState(() {
              _addCharacter(' ');
            });
          },
        ),
        GCWButton(
          text: i18n(context, 'morse_next_word'),
          onPressed: () {
            setState(() {
              _addCharacter(' | ');
            });
          },
        ),
      ]
    );
  }

  _addCharacter(String input) {
    var cursorPosition = max(_inputController.selection.end, 0);

    _currentInput = _currentInput.substring(0, cursorPosition) + input + _currentInput.substring(cursorPosition);
    _inputController.text = _currentInput;
    _inputController.selection = TextSelection.collapsed(offset: cursorPosition + input.length);
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    var textStyle = gcwTextStyle();
    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeMorse(_currentInput);
      textStyle = TextStyle(
        fontSize: textStyle.fontSize + 15,
        fontFamily: textStyle.fontFamily,
        fontWeight: FontWeight.bold
      );
    } else
      output = decodeMorse(_currentInput);


    return GCWOutput(
      child: GCWText(
        text: output,
        style: textStyle
      ),
    );

  }
}