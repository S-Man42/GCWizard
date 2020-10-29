import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/Vigenere_breaker/bigrams/bigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/vigenere_breaker.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class VigenereBreaker extends StatefulWidget {
  @override
  VigenereBreakerState createState() => VigenereBreakerState();
}

class VigenereBreakerState extends State<VigenereBreaker> {

  String _currentInput = '';
  VigenereBreakerAlphabet _currentAlphabet = VigenereBreakerAlphabet.GERMAN;
  VigenereBreakerResult _currentOutput = null;
  var _minKeyLengthController;
  var _maxKeyLengthController;
  int _minKeyLength = 3;
  int _maxKeyLength = 30;


  var _isStarted = false;

  @override
  void initState() {
    super.initState();

    _minKeyLengthController =  TextEditingController(text: _minKeyLength.toString());
    _maxKeyLengthController =  TextEditingController(text: _maxKeyLength.toString());
  }

  @override
  void dispose() {
    _minKeyLengthController.dispose();
    _maxKeyLengthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var BreakerAlphabetItems = {
      VigenereBreakerAlphabet.ENGLISH : i18n(context, 'substitutionbreaker_alphabet_english'),
      VigenereBreakerAlphabet.GERMAN : i18n(context, 'substitutionbreaker_alphabet_german'),
    };

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
          text: i18n(context, 'common_alphabet')
        ),
        GCWDropDownButton(
          value: _currentAlphabet,
          onChanged: (value) {
            setState(() {
              _currentAlphabet = value;
            });
          },
          items: BreakerAlphabetItems.entries.map((alphabet) {
            return GCWDropDownMenuItem(
              value: alphabet.key,
              child: alphabet.value,
            );
          }).toList(),
        ),
        Row(
            children: <Widget>[
              Expanded(
                  child: GCWText(
                      text: 'Key Length min: ', //i18n(context, 'homophone_rotation') + ':'
                  ),
                  flex: 1
              ),
              Expanded(
                  child: GCWIntegerSpinner(
                    controller: _minKeyLengthController,
                    min: 1,
                    max: 999,
                    onChanged: (value) {
                      setState(() {
                        _minKeyLength = value;
                        _maxKeyLengthController.text = max(_minKeyLength, _maxKeyLength).toString();
                      });
                    },
                  ),
                  flex: 2
              ),
            ]
        ),
        Row(
          children: <Widget>[
         Expanded(
                  child: GCWText(
                    text: 'Key Length  max: ', //i18n(context, 'homophone_rotation') + ':'
                  ),
                  flex: 1
              ),
              Expanded(
                  child: GCWIntegerSpinner(
                    controller: _maxKeyLengthController,
                    min: 1,
                    max: 999,
                    onChanged: (value) {
                      setState(() {
                        _maxKeyLength = value;
                        _minKeyLengthController.text = min(_minKeyLength, _maxKeyLength).toString();
                      });
                    },
                  ),
                  flex: 2
              ),
            ]
        ),
        GCWButton(
          text: i18n(context, 'substitutionbreaker_start'),
          onPressed: () {
            setState(() {
              _calcOutput();
            });
          },
        ),

        _buildOutput(context),
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput();

    if (_currentOutput == null)
      return GCWDefaultOutput();

    if (_currentOutput.errorCode != VigenereBreakerErrorCode.OK){
      showToast( i18n(context, 'substitutionbreaker_error', parameters: [_currentOutput.errorCode]));
      return GCWDefaultOutput();
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.plaintext,
        Column(
          children: [
            GCWOutput(
              title: i18n(context, 'common_key'),
              child: GCWOutputText(
                text:
                _currentOutput.alphabet.toUpperCase() +'\n'
                  + _currentOutput.key.toUpperCase(),
                isMonotype: true,
              ),
            ),
            GCWButton(
              text: i18n(context, 'substitutionbreaker_exporttosubstition'),
              onPressed: () {
                Map<String, String> substitutions = {};
                for (int i = 0; i < _currentOutput.alphabet.length; i++)
                  substitutions.putIfAbsent(_currentOutput.key[i], () => _currentOutput.alphabet[i]);

                Navigator.push(context, NoAnimationMaterialPageRoute(
                  builder: (context) => GCWTool(
                    tool: Substitution(input: _currentOutput.ciphertext, substitutions: substitutions),
                    toolName: i18n(context, 'substitution_title')
                  )
                ));
              },
            )
          ],
        )
      ],
    );
  }


  _calcOutput() async {
    if (_currentInput == null || _currentInput.length == 0 || _isStarted)
      return;

    _isStarted = true;

    var _currentOutputFuture = break_cipher(_currentInput, VigenereBreakerType.VIGENERE, _currentAlphabet, _minKeyLength, _maxKeyLength);
    _currentOutputFuture.then((output) {
      _currentOutput = output;
      _isStarted = false;
      this.setState(() {});
    });
  }
}