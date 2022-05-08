import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/alphabet_values.dart';
import 'package:prefs/prefs.dart';

class RotationAlphabet extends StatefulWidget {
  @override
  RotationAlphabetState createState() => RotationAlphabetState();
}

class RotationAlphabetState extends State<RotationAlphabet> {
  var _controller;
  List<Alphabet> _alphabets;
  List<String> _storedAlphabets;
  var _currentAlphabetKey;
  String _currentAlphabet;

  String _currentInput = '';
  int _currentKey = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput);

    // _encodeController = TextEditingController(text: _currentEncodeInput);
    // _decodeController = TextEditingController(text: _currentDecodeInput['text']);

    _storedAlphabets = Prefs.getStringList('alphabetvalues_custom_alphabets');
    _alphabets = List<Alphabet>.from(ALL_ALPHABETS);
    _alphabets.addAll(_storedAlphabets.map<Alphabet>((storedAlphabet) {
      var alphabet = Map<String, dynamic>.from(jsonDecode(storedAlphabet));
      return Alphabet(
          key: alphabet['key'],
          name: alphabet['name'],
          type: AlphabetType.CUSTOM,
          alphabet: Map<String, String>.from(alphabet['alphabet']));
    }).toList());

    _currentAlphabetKey = Prefs.get('alphabetvalues_default_alphabet');
    _setAlphabet();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_key'),
          onChanged: (value) {
            setState(() {
              _currentKey = value;
            });
          },
        ),
        GCWDropDownButton(
          value: _currentAlphabetKey,
          items: buildAlphabetItems(_alphabets, context),
          onChanged: (value) {
            setState(() {
              _currentAlphabetKey = value;
              _setAlphabet();
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null || _currentInput.isEmpty) return GCWDefaultOutput();

    var alphabetLength = _currentAlphabet.length;
    var reverseKey = modulo(alphabetLength - _currentKey, alphabetLength);

    return Column(
      children: [
        GCWDefaultOutput(
          child: Rotator().rotateAlphabet(_currentInput, _currentKey, _currentAlphabet),
        ),
        GCWOutput(
          title: i18n(context, 'rotation_general_reverse') +
              ' (' +
              i18n(context, 'common_key') +
              ': ' +
              reverseKey.toString() +
              ')',
          child: Rotator().rotateAlphabet(_currentInput, reverseKey, _currentAlphabet),
        ),
      ],
    );
  }

  Alphabet _getAlphabetByKey(String key) {
    return _alphabets.firstWhere((alphabet) => alphabet.key == key);
  }

  _setAlphabet() {
    var currentAlphabet = _getAlphabetByKey(_currentAlphabetKey).alphabet;

    _currentAlphabet = currentAlphabet.keys.join();
    // _currentIsEditingAlphabet = false;
    // _currentOffset = 0;
    // _currentReverseAlphabet = GCWSwitchPosition.left;
    // _currentCustomizeAlphabet = GCWSwitchPosition.left;

    // Prefs.setString('alphabetvalues_default_alphabet', _currentAlphabetKey);

    // _setReverseLabels();
  }
}
