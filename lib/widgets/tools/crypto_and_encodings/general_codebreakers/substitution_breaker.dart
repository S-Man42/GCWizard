import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/substitution_breaker.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class SubstitutionBreaker extends StatefulWidget {
  @override
  SubstitutionBreakerState createState() => SubstitutionBreakerState();
}

class SubstitutionBreakerState extends State<SubstitutionBreaker> {

  String _currentInput = '';
  SubstitutionBreakerAlphabet _currentAlphabet = SubstitutionBreakerAlphabet.GERMAN;
  SubstitutionBreakerResult _currentOutput = null;

  var _quadgrams = Map<SubstitutionBreakerAlphabet, Quadgrams>();
  var _isLoading = false;
  var _isStarted = false;

  @override
  void initState() {
    super.initState();

   _loadQuadgramsAssets();
  }

  @override
  Widget build(BuildContext context) {
    var BreakerAlphabetItems = {
      SubstitutionBreakerAlphabet.ENGLISH : i18n(context, 'common_language_english'),
      SubstitutionBreakerAlphabet.GERMAN : i18n(context, 'common_language_german'),
      SubstitutionBreakerAlphabet.SPANISH : i18n(context, 'common_language_spanish'),
      SubstitutionBreakerAlphabet.POLISH : i18n(context, 'common_language_polish'),
      SubstitutionBreakerAlphabet.GREEK : i18n(context, 'common_language_greek'),
      SubstitutionBreakerAlphabet.FRENCH : i18n(context, 'common_language_french'),
      SubstitutionBreakerAlphabet.RUSSIAN : i18n(context, 'common_language_russian'),
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
              _loadQuadgramsAssets();
            });
          },
          items: BreakerAlphabetItems.entries.map((alphabet) {
            return GCWDropDownMenuItem(
              value: alphabet.key,
              child: alphabet.value,
            );
          }).toList(),
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

    if (_currentOutput.errorCode != SubstitutionBreakerErrorCode.OK){
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

  Future<void> _loadQuadgramsAssets() async {
    while (_isLoading) {}

    if (_quadgrams.containsKey(_currentAlphabet))
      return;

    _isLoading = true;

    Quadgrams quadgrams = getQuadgrams(_currentAlphabet);

    String data = await DefaultAssetBundle.of(context).loadString(quadgrams.assetLocation);
    Map<String, dynamic> jsonData = jsonDecode(data);
    quadgrams.quadgramsCompressed = Map<int, List<int>>();
    jsonData.entries.forEach((entry) {
      quadgrams.quadgramsCompressed.putIfAbsent(
        int.tryParse(entry.key),
        () => List<int>.from(entry.value)
      );
    });

    _quadgrams.putIfAbsent(_currentAlphabet, () => quadgrams);

    _isLoading = false;
  }

  _calcOutput() async {
    if (_currentInput == null || _currentInput.length == 0 || _isStarted)
      return;

    _isStarted = true;

    await _loadQuadgramsAssets();
    var _currentOutputFuture = break_cipher(_currentInput, _quadgrams[_currentAlphabet]);
    _currentOutputFuture.then((output) {
      _currentOutput = output;
      _isStarted = false;
      this.setState(() {});
    });
  }
}