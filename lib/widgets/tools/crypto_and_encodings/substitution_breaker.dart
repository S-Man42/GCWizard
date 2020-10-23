import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/english_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/german_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';

class SubstitutionBreaker extends StatefulWidget {
  @override
  SubstitutionBreakerState createState() => SubstitutionBreakerState();
}

class SubstitutionBreakerState extends State<SubstitutionBreaker> {

  String _currentInput = '';
  BreakerAlphabet _currentAlphabet = BreakerAlphabet.German;
  BreakerResult _currentOutput = null;

  var _quadgrams = Map<BreakerAlphabet, Quadgrams>();
  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadQuadgramsAssets();
  }

  @override
  Widget build(BuildContext context) {
    var BreakerAlphabetItems = {
      BreakerAlphabet.English : i18n(context, 'substitution_breaker_alphabet_english'),
      BreakerAlphabet.German : i18n(context, 'substitution_breaker_alphabet_german'),
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
          text: i18n(context, 'substitution_breaker_start'),
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
    if (_currentOutput.errorCode != ErrorCode.OK){
      switch (_currentOutput.errorCode) {
        case ErrorCode.MAX_ROUNDS_PARAMETER:
          showToast("maximum number of rounds not in the valid range 1..10000");
          break;
        case ErrorCode.MAX_ROUNDS_PARAMETER:
          showToast("consolidate parameter out of valid range 1..30");
          break;
        case ErrorCode.TEXT_TOO_SHORT:
          showToast("ciphertext is too short");
          break;
        case ErrorCode.WRONG_GENERATE_TEXT:
          showToast("More than three characters from the given alphabet are required");
          break;
        case ErrorCode.ALPHABET_TOO_LONG:
          showToast("Alphabet must have less or equal than 32 characters");
          break;
      }
      return GCWDefaultOutput();
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.plaintext,
        GCWOutput(
          title: i18n(context, 'common_key'),
          child: GCWOutputText(

            text:
            _currentOutput.alphabet +'\n' + _currentOutput.key + '\n'
            + '\n'
            + 'keys/s: ' + _currentOutput.keys_per_second.toString() + '\n'
            + 'keys: ' + _currentOutput.nbr_keys.toString() + '\n'
            + 'rounds: ' + _currentOutput.nbr_rounds .toString() + '\n'
            + 'seconds: ' + _currentOutput.seconds .toString() + 's'
            ,
            isMonotype: true,
          ),
        )
      ],
    );
  }

  Future<void> _loadQuadgramsAssets() async {
    while (_isLoading) {
    }

    if (_quadgrams.containsKey(_currentAlphabet))
      return;

    _isLoading = true;

    Quadgrams quadgrams;
    switch (_currentAlphabet) {
      case BreakerAlphabet.English:
        quadgrams = EnglishQuadgrams();
        break;
      case BreakerAlphabet.German:
        quadgrams = GermanQuadgrams();
        break;
      default:
        return null;
    }

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
    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput();

    while (_isLoading){}

    _currentOutput = await break_cipher(_currentInput, _quadgrams[_currentAlphabet]);
  }
}