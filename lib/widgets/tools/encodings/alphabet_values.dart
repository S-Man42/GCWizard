import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/alphabet_values.dart' as logic;
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_output.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class AlphabetValues extends StatefulWidget {
  @override
  AlphabetValuesState createState() => AlphabetValuesState();
}

class AlphabetValuesState extends State<AlphabetValues> {
  final List<Alphabet> _alphabets = [
    alphabetAZ,
    alphabetGerman1,
    alphabetGerman2,
    alphabetGerman3,
    alphabetSpanish1,
    alphabetSpanish2,
    alphabetPolish1,
    alphabetGreek1,
    alphabetRussian1,
  ];

  var _encodeController;
  var _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  bool _currentCrosstotalMode = true;

  var _currentAlphabet;

  @override
  void initState() {
    super.initState();

    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput['text']);

    _currentAlphabet = _alphabets[0].key;
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
          ? GCWTextField(
              controller: _encodeController,
              onChanged: (text) {
                setState(() {
                  _currentEncodeInput = text;
                });
              },
            )
          : GCWIntegerListTextField(
              controller: _decodeController,
              onChanged: (text) {
                setState(() {
                  _currentDecodeInput = text;
                });
              },
            ),
        Column(
          children: [
            GCWDropDownButton(
              value: _currentAlphabet,
              items: _alphabets.map((alphabet) {
                print(alphabet.key);
                return DropdownMenuItem(
                  value: alphabet.key,
                  child: Text(alphabet.key),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _currentAlphabet = value;
                });
              },
            ),
          ],
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'lettervalues_mode_left'),
          rightValue: i18n(context, 'lettervalues_mode_right'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWCrosstotalSwitch(
          onChanged: (value) {
            setState(() {
              _currentCrosstotalMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          text: _calculateOutput()
        ),
        _buildCrossTotals()
      ],
    );
  }

  _buildCrossTotals() {
    if (!_currentCrosstotalMode)
      return Container();

    if (_currentMode == GCWSwitchPosition.left) {
      return GCWCrosstotalOutput(_currentEncodeInput, logic.AlphabetValues().textToValues(_currentEncodeInput, keepNumbers: true));
    } else {
      var text = logic.AlphabetValues().valuesToText(List<int>.from(_currentDecodeInput['values']));
      return GCWCrosstotalOutput(text, _currentDecodeInput['values']);
    }
  }

  _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return intListToString(logic.AlphabetValues().textToValues(_currentEncodeInput, keepNumbers: true), delimiter: ' | ');
    } else {
      return logic.AlphabetValues().valuesToText(List<int>.from(_currentDecodeInput['values']));
    }
  }
}