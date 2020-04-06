import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto/polybios.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_encrypt_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class Polybios extends StatefulWidget {
  @override
  PolybiosState createState() => PolybiosState();
}

class PolybiosState extends State<Polybios> {
  var _inputController;
  var _keyController;
  var _alphabetController;

  String _currentInput = '';
  String _currentKey = '12345';

  PolybiosMode _currentPolybiosMode = PolybiosMode.AZ09;
  String _currentAlphabet = '';

  var _currentOutput = PolybiosOutput('', '');

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _keyController = TextEditingController(text: _currentKey);
    _alphabetController = TextEditingController(text: _currentAlphabet);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _keyController.dispose();
    _alphabetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var polybiosModeItems = {
      PolybiosMode.AZ09 : i18n(context, 'polybios_mode_az09'),
      PolybiosMode.ZA90 : i18n(context, 'polybios_mode_za90'),
      PolybiosMode.custom : i18n(context, 'common_custom'),
    };

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
        GCWTextDivider(
            text: i18n(context, 'common_key')
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
        GCWTextDivider(
          text: i18n(context, 'common_alphabet')
        ),
        GCWDropDownButton(
          value: _currentPolybiosMode,
          onChanged: (value) {
            setState(() {
              _currentPolybiosMode = value;
            });
          },
          items: polybiosModeItems.entries.map((mode) {
            return DropdownMenuItem(
              value: mode.key,
              child: Text(mode.value),
            );
          }).toList(),
        ),
        _currentPolybiosMode == PolybiosMode.custom ? GCWTextField(
          hintText: i18n(context, 'common_alphabet'),
          controller: _alphabetController,
          onChanged: (text) {
            setState(() {
              _currentAlphabet = text;
            });
          },
        ) : Container(),
        GCWEncryptButtonBar(
          onPressedEncode: () {
            setState(() {
              _currentOutput = encryptPolybios(_currentInput, _currentKey, mode: _currentPolybiosMode, alphabet: _currentAlphabet);
            });
          },
          onPressedDecode: () {
            setState(() {
              _currentOutput = decryptPolybios(_currentInput, _currentKey, mode: _currentPolybiosMode, alphabet: _currentAlphabet);
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentOutput == null || _currentOutput.output.length == 0) {
      return GCWDefaultOutput(
        text: '' //TODO: Exception
      );
    }

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWOutputText(
            text: _currentOutput.output
          ),
          GCWTextDivider(
            text: i18n(context, 'polybios_usedgrid')
          ),
          GCWOutputText(
            text: _currentOutput.grid,
            isMonotype: true,
          )
        ],
      ),
    );
  }
}