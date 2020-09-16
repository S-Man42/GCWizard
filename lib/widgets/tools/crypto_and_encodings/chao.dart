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

  ChaoAlphabet _currentAlphabetTypePlain = ChaoAlphabet.AZ;
  ChaoAlphabet _currentAlphabetTypeChiffre = ChaoAlphabet.AZ;

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
    var ChaoPlainAlphabetItems = {
      ChaoAlphabet.AZ : i18n(context, 'chao_alphabet_az'),
      ChaoAlphabet.ZA : i18n(context, 'chao_alphabet_za'),
      ChaoAlphabet.CUSTOM : i18n(context, 'chao_alphabet_custom'),
    };
    var ChaoChiffreAlphabetItems = {
      ChaoAlphabet.AZ : i18n(context, 'chao_alphabet_az'),
      ChaoAlphabet.ZA : i18n(context, 'chao_alphabet_za'),
      ChaoAlphabet.CUSTOM : i18n(context, 'chao_alphabet_custom'),
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
            text: i18n(context, 'chao_alphabet_chiffre')
        ),
        GCWDropDownButton(
          value: _currentAlphabetTypeChiffre,
          onChanged: (value) {
            setState(() {
              _currentAlphabetTypeChiffre = value;
            });
          },
          items: ChaoChiffreAlphabetItems.entries.map((alphabetChiffre) {
            return DropdownMenuItem(
              value: alphabetChiffre.key,
              child: Text(alphabetChiffre.value),
            );
          }).toList(),
        ),
        _currentAlphabetTypeChiffre == ChaoAlphabet.CUSTOM
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
        GCWTextDivider(
            text: i18n(context, 'chao_alphabet_plain')
        ),
        GCWDropDownButton(
          value: _currentAlphabetTypePlain,
          onChanged: (value) {
            setState(() {
              _currentAlphabetTypePlain = value;
            });
          },
          items: ChaoPlainAlphabetItems.entries.map((alphabetPlain) {
            return DropdownMenuItem(
              value: alphabetPlain.key,
              child: Text(alphabetPlain.value),
            );
          }).toList(),
        ),
        _currentAlphabetTypePlain == ChaoAlphabet.CUSTOM
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
            text: i18n(context, 'common_output')
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput(child: '');

    var alphabetChiffre = '';
    var alphabetPlain = '';

    switch (_currentAlphabetTypePlain){
      case ChaoAlphabet.AZ: alphabetPlain = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; break;
      case ChaoAlphabet.ZA: alphabetPlain = 'ZYXWVUTSRQPONMLKJIHGFEDCBA'; break;
      case ChaoAlphabet.CUSTOM: alphabetPlain = _currentAlphabetPlain.toUpperCase(); break;
    }

    switch (_currentAlphabetTypeChiffre){
      case ChaoAlphabet.AZ: alphabetChiffre = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; break;
      case ChaoAlphabet.ZA: alphabetChiffre = 'ZYXWVUTSRQPONMLKJIHGFEDCBA'; break;
      case ChaoAlphabet.CUSTOM: alphabetChiffre = _currentAlphabetChiffre.toUpperCase(); break;
    }

    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptChao(_currentInput, alphabetPlain, alphabetChiffre);
    } else {
      _currentOutput = decryptChao(_currentInput, alphabetPlain, alphabetChiffre);
    }
    return GCWOutputText(
              text: _currentOutput,
            );
  }
}