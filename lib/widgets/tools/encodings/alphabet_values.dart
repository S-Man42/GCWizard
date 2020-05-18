import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/alphabet_values.dart' as logic;
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_output.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
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

  var _fromController;
  var _toController;
  var _currentFromInput = '';
  var _currentToInput = '';

  var _encodeController;
  var _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  bool _currentCrosstotalMode = true;

  var _currentAlphabetKey;
  Map<String, String> _currentAlphabet;
  Map<String, String> _currentCustomizedAlphabet;
  var _currentIsEditingAlphabet = false;
  var _currentReverseAlphabet = GCWSwitchPosition.left;
  var _reverseSwitchTitleLeft;
  var _reverseSwitchTitleRight;
  var _currentFirstValueOffset = 0;
  var _currentCustomizeAlphabet = GCWSwitchPosition.left;

  var _currentAddAndAdjustEnabled = true;

  @override
  void initState() {
    super.initState();

    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput['text']);

    _fromController = TextEditingController(text: _currentFromInput);
    _toController = TextEditingController(text: _currentToInput);

    _currentAlphabetKey = _alphabets[0].key;
    _setAlphabet();
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    _fromController.dispose();
    _toController.dispose();

    super.dispose();
  }

  Map<String, String> _getAlphabetByKey(String key) {
    return _alphabets.firstWhere((alphabet) => alphabet.key == key).alphabet;
  }

  _setAlphabet() {
    _currentAlphabet = _getAlphabetByKey(_currentAlphabetKey);
    _currentIsEditingAlphabet = false;
    _currentCustomizeAlphabet = GCWSwitchPosition.left;

    _setReverseLabels();
  }

  _setReverseLabels() {
    var firstEntry = _currentAlphabet.entries.first;
    var lastEntry = _currentAlphabet.entries.last;

    var firstValue = _setValueOffset(firstEntry.value);
    var lastValue = _setValueOffset(lastEntry.value);

    _reverseSwitchTitleLeft = firstEntry.key + '-' + lastEntry.key + ' ' + String.fromCharCode(8594) + ' ' + firstValue + '-' + lastValue;
    _reverseSwitchTitleRight = lastEntry.key + '-' + firstEntry.key + ' ' + String.fromCharCode(8594) + ' ' + firstValue + '-' + lastValue;
  }

  _setValueOffset(String value) {
    return value.split(',').map((value) => int.tryParse(value) + _currentFirstValueOffset).join(',');
  }

  Map<String, String> _setOffset(Map<String, String> alphabet) {
    return alphabet.map((key, value) => MapEntry(key, _setValueOffset(value)));
  }

  Map<String, String> _setReverse(Map<String, String> alphabet) {
    if (_currentReverseAlphabet == GCWSwitchPosition.left)
      return alphabet;

    var reversedMap = <String, String>{};
    var entries = alphabet.entries.toList();
    var length = entries.length;

    for (int i = 0; i < length; i++) {
      reversedMap.putIfAbsent(entries[length - i - 1].key, () => entries[i].value);
    }

    return Map<String, String>.fromEntries(reversedMap.entries);
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
            Row(
              children: [
                Expanded(
                  child: GCWDropDownButton(
                    value: _currentAlphabetKey,
                    items: _alphabets.map((alphabet) {
                      return DropdownMenuItem(
                        value: alphabet.key,
                        child: Text(alphabet.key),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentAlphabetKey = value;
                        _setAlphabet();
                      });
                    },
                  ),
                ),
                GCWIconButton(
                  iconData: _currentIsEditingAlphabet ? Icons.check : Icons.edit,
                  onPressed: () {
                    setState(() {
                      _currentIsEditingAlphabet = !_currentIsEditingAlphabet;
                    });
                  },
                )
              ],
            ),
            _currentIsEditingAlphabet ? _buildEditingAlphabet() : Container(),
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

  _buildEditingAlphabet() {
    return Column(
      children: [
        GCWTwoOptionsSwitch(
          value: _currentCustomizeAlphabet,
          leftValue: 'Adjust',
          rightValue: 'Customize',
          onChanged: (value) {
            setState(() {
              _currentCustomizeAlphabet = value;

              if (_currentCustomizeAlphabet == GCWSwitchPosition.right) {
                _currentCustomizedAlphabet = Map<String, String>.from(_currentAlphabet);
                _currentCustomizedAlphabet = _setOffset(_currentCustomizedAlphabet);
                _currentCustomizedAlphabet = _setReverse(_currentCustomizedAlphabet);
              } else {
                _currentCustomizedAlphabet = null;
              }
            });
          },
        ),
        _currentCustomizeAlphabet == GCWSwitchPosition.left
          ? Column(
              children: [
                GCWIntegerSpinner(
                  title: 'First Value',
                  value: _currentFirstValueOffset + 1,
                  onChanged: (value) {
                    setState(() {
                      _currentFirstValueOffset = value - 1;
                      _setReverseLabels();
                    });
                  },
                ),
                GCWTwoOptionsSwitch(
                  title: 'Reverse',
                  leftValue: _reverseSwitchTitleLeft,
                  rightValue: _reverseSwitchTitleRight,
                  value: _currentReverseAlphabet,
                  onChanged: (value) {
                    setState(() {
                      _currentReverseAlphabet = value;
                    });
                  },
                ),
                GCWDivider()
              ],
            )
            : Column(
                children: [
                  GCWButton(
                    text: 'Save as new alphabet',
                    onPressed: () {
                      setState(() {

                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child:  Row(
                      children: [
                        Expanded(
                          child: GCWTextField(
                            hintText: i18n(context, 'substitution_from'),
                            controller: _fromController,
                            onChanged: (text) {
                              setState(() {
                                _currentFromInput = text;
                              });
                            },
                          )
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: ThemeColors.gray,
                        ),
                        Expanded(
                          child: GCWTextField(
                            hintText: i18n(context, 'substitution_to'),
                            controller: _toController,
                            onChanged: (text) {
                              setState(() {
                                _currentToInput = text;
                              });
                            },
                          ),
                        ),
                        Container(
                          child: GCWButton(
                            text: 'Add',
                            onPressed: () {
                              setState(() {
                                _addNewLetter(context, _currentFromInput, _currentToInput, adjust: false);
                              });
                            },
                          ),
                          padding: EdgeInsets.only(left: 4, right: 2)
                        ),
                        Container(
                          child: GCWButton(
                            text: 'Einfügen &\nAnpassen',
                            onPressed: _isAddAndAdjustEnabled() ? () {
                              setState(() {
                                _addNewLetter(context, _currentFromInput, _currentToInput);
                              });
                            } : null,
                          ),
                          padding: EdgeInsets.only(left: 2)
                        )
                      ],
                    )
                  ),
                  _buildCustomizeableAlphabet(),
                  GCWDivider()
                ],
              )
          ],
        )
      ;
  }

  _isAddAndAdjustEnabled() {
    if (_currentCustomizedAlphabet.containsKey(_currentFromInput))
      return false;

    if (_currentToInput.contains(','))
      return false;

    return true;
  }

  _addNewLetter(BuildContext context, String letter, String value, {adjust: true}) {
    if (letter == null || letter.length == 0 || value == null)
      return;

    value = value.split(',')
      .where((character) => character != null && character.length > 0)
      .map((character) => character.toUpperCase())
      .join(',');

    if (value.length == 0)
      return;


    letter = letter.toUpperCase();
    if (_currentCustomizedAlphabet.containsKey(letter)) {
      showGCWDialog(context, 'Ersetzen?', 'Bla\nBla\nBla\nBla\nBla\nBla\nBla\nBla\nBla\nBla\n', [
        GCWDialogButton(
          text: 'Replace',
          onPressed: () {
            setState(() {
              _currentCustomizedAlphabet.addAll({letter : value});
            });
          }
        )
      ]);
    } else {
      setState(() {
        if (adjust) {
          var insertedValue = int.tryParse(value);
          _currentCustomizedAlphabet = _currentCustomizedAlphabet.map((currentKey, currentValue) {
            var newValue = currentValue.split(',').map((value) {
              var intValue = int.tryParse(value);
              if (intValue >= insertedValue)
                intValue++;

              return intValue.toString();
            }).join(',');

            return MapEntry(currentKey, newValue);
          });
        }

        _currentCustomizedAlphabet.putIfAbsent(letter, () => value);
      });
    }

    setState(() {
      _fromController.clear();
      _toController.clear();
      _currentFromInput = '';
      _currentToInput = '';
    });
  }

  _removeLetter(BuildContext context, String key) {
    var _valueToDelete = _currentCustomizedAlphabet[key];
    var _isList = _valueToDelete.contains(',');

    var buttons = [
      GCWDialogButton(
        text: 'Remove',
        onPressed: () {
          setState(() {
            _currentCustomizedAlphabet.remove(key);
          });
        }
      )
    ];

    if (!_isList) {
      var deleteValue = int.tryParse(_valueToDelete);

      buttons.add(
        GCWDialogButton(
          text: 'Remove\n& Adjust',
          onPressed: () {
            _currentCustomizedAlphabet = _currentCustomizedAlphabet.map((currentKey, currentValue) {
              var newValue = currentValue.split(',').map((value) {
                var intValue = int.tryParse(value);
                if (intValue > deleteValue)
                  intValue--;

                return intValue.toString();
              }).join(',');

              return MapEntry(currentKey, newValue);
            });

            setState(() {
              _currentCustomizedAlphabet.remove(key);
            });
          },
        )
      );
    }

    showGCWDialog(context, 'Löschen', 'Bla\nBla\nBla\nBla\nBla\nBla\nBla\nBla\nBla\nBla\n', buttons);
  }

  _buildCustomizeableAlphabet() {
    var odd = true;
    var rows = _currentCustomizedAlphabet.entries.map((entry) {
      Widget output;

      var row = Container(
        child: Row (
          children: <Widget>[
            Expanded(
              child: GCWText (
                text: entry.key
              ),
              flex: 1,
            ),
            Icon(
              Icons.arrow_forward,
              color: ThemeColors.gray,
            ),
            Expanded(
              child: GCWText (
                text: entry.value.toString()
              ),
              flex: 1
            ),
            GCWIconButton(
              iconData: Icons.remove,
              onPressed: () {
                setState(() {
                  _removeLetter(context, entry.key);
                  _calculateOutput();
                });
              },
            )
          ],
        ),
        margin: EdgeInsets.only(
            left: 10
        ),
      );

      if (odd) {
        output = Container(
          color: ThemeColors.oddRows,
          child: row
        );
      } else {
        output = Container(
          child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    return Column(
      children: rows
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
    var alphabet = _currentAlphabet;
    if (_currentIsEditingAlphabet) {
      if (_currentCustomizeAlphabet == GCWSwitchPosition.right) {
        alphabet = _currentCustomizedAlphabet;
      } else {
        alphabet = _setOffset(alphabet);
        alphabet = _setReverse(alphabet);
      }
    }

    if (_currentMode == GCWSwitchPosition.left) {
      return intListToString(logic.AlphabetValues(alphabet: alphabet).textToValues(_currentEncodeInput, keepNumbers: true), delimiter: ' | ');
    } else {
      return logic.AlphabetValues(alphabet: alphabet).valuesToText(List<int>.from(_currentDecodeInput['values']));
    }
  }
}