import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chao.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Chao extends StatefulWidget {
  @override
  ChaoState createState() => ChaoState();
}

class ChaoState extends State<Chao> {
  var _inputController;
  var _alphabetControllerPlain;
  var _alphabetControllerChiffre;

  var _currentMode = GCWSwitchPosition.left;

  String _currentInput = '';
  String _currentOutput = '';
  String _currentAlphabetPlain = '';
  String _currentAlphabetChiffre = '';

  PolybiosMode _currentChaoModePlain = PolybiosMode.AZ09;
  PolybiosMode _currentChaoModeChiffre = PolybiosMode.AZ09;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _alphabetControllerPlain = TextEditingController(text: _currentAlphabetPlain);
    _alphabetControllerChiffre = TextEditingController(text: _currentAlphabetChiffre);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _alphabetControllerPlain.dispose();
    _alphabetControllerChiffre.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ChaoModeItems = {
      PolybiosMode.AZ09 : i18n(context, 'polybios_mode_az09'),
      PolybiosMode.ZA90 : i18n(context, 'polybios_mode_za90'),
      PolybiosMode.CUSTOM : i18n(context, 'polybios_mode_custom'),
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

        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'chao_alphabet_plain')
        ),

        GCWDropDownButton(
          value: _currentChaoModePlain,
          onChanged: (value) {
            setState(() {
              _currentChaoModePlain = value;
            });
          },
          items: ChaoModeItems.entries.map((mode) {
            return DropdownMenuItem(
              value: mode.key,
              child: Text(mode.value),
            );
          }).toList(),
        ),

        _currentChaoModePlain == PolybiosMode.CUSTOM
            ? GCWTextField(
          hintText: i18n(context, 'chao_alphabet_plain'),
          controller: _alphabetControllerPlain,
          onChanged: (text) {
            setState(() {
              _currentAlphabetPlain = text;
            });
          },
        )
            : Container(),
        GCWTextDivider(
            text: i18n(context, 'chao_alphabet_chiffre')
        ),

        GCWDropDownButton(
          value: _currentChaoModeChiffre,
          onChanged: (value) {
            setState(() {
              _currentChaoModeChiffre = value;
            });
          },
          items: ChaoModeItems.entries.map((mode) {
            return DropdownMenuItem(
              value: mode.key,
              child: Text(mode.value),
            );
          }).toList(),
        ),

        _currentChaoModeChiffre == PolybiosMode.CUSTOM
            ? GCWTextField(
          hintText: i18n(context, 'common_alphabet'),
          controller: _alphabetControllerChiffre,
          onChanged: (text) {
            setState(() {
              _currentAlphabetChiffre = text;
            });
          },
        )
            : Container(),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput(child: '');

    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptChao(
          _currentInput,
          modePlain: _currentChaoModePlain,
          alphabetPlain: _currentAlphabetPlain,
          modeChiffre: _currentChaoModeChiffre,
          alphabetChiffre: _currentAlphabetChiffre
      );
    } else {
      _currentOutput = decryptChao(
          _currentInput,
          modePlain: _currentChaoModePlain,
          alphabetPlain: _currentAlphabetPlain,
          modeChiffre: _currentChaoModeChiffre,
          alphabetChiffre: _currentAlphabetChiffre
      );
    }
    return GCWOutputText(
              text: _currentOutput,
            );

  }
}