import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/homophone.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_key_value_editor.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_paste_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Homophone extends StatefulWidget {
  @override
  HomophoneState createState() => HomophoneState();
}

class HomophoneState extends State<Homophone> {
  var _currentMode = GCWSwitchPosition.right;

  var _currentRotationController;
  TextEditingController _newKeyController;
  String _currentInput = '';
  Alphabet _currentAlphabet = Alphabet.alphabetGerman1;
  KeyType _currentKeyType = KeyType.GENERATED;
  int _currentRotation = 1;
  int _currentMultiplierIndex = 0;
  String _currentOwnKeys = '';
  var _currentSubstitutions = Map<String, String>();


  final aKeys = [1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 25];

  @override
  void initState() {
    super.initState();

    _currentRotationController = TextEditingController(text: _currentRotation.toString());
    _newKeyController = TextEditingController(text: _maxLetter());
  }

  @override
  void dispose() {
    _currentRotationController.dispose();
    _newKeyController.dispose();

    super.dispose();
  }

  String _maxLetter() {
    int maxLetterIndex = 0;
    var alphabetTable = getAlphabetTable(_currentAlphabet);
    _currentSubstitutions.forEach((key, value) {
      if (key.length != 1) return;

      if (alphabetTable.containsKey(key.toUpperCase()))
        maxLetterIndex = max(maxLetterIndex, alphabetTable.keys.toList().indexOf(key.toUpperCase()) + 1);
    });

    if (maxLetterIndex < alphabetTable.length) {
      return alphabetTable.keys.elementAt(maxLetterIndex);
    }

    return '';
  }

  _addEntry(String currentFromInput, String currentToInput, BuildContext context) {
    if (currentFromInput.length > 0)
      _currentSubstitutions.putIfAbsent(currentFromInput.toUpperCase(), () =>  currentToInput);

    _newKeyController.text = _maxLetter();

    setState(() {});
  }

  // _updateNewEntry(String currentFromInput, String currentToInput, BuildContext context) {
  //   _currentFromInput = currentFromInput;
  //   _currentToInput = currentToInput;
  //   //_calculateOutput();
  // }

  _updateEntry(dynamic id, String key, String value) {
    _currentSubstitutions[id] = value;
    setState(() {});
  }

  _removeEntry(dynamic id, BuildContext context) {
    _currentSubstitutions.remove(id);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    var HomophoneKeyTypeItems = {
      KeyType.GENERATED: i18n(context, 'homophone_keytype_generated'),
      KeyType.OWN1: i18n(context, 'homophone_keytype_own') + " 1",
      KeyType.OWN2: i18n(context, 'homophone_keytype_own') + " 2",
    };

    var HomophoneAlphabetItems = {
      Alphabet.alphabetGerman1: i18n(context, 'common_language_german'),
      Alphabet.alphabetEnglish1: i18n(context, 'common_language_english'),
      Alphabet.alphabetSpanish2: i18n(context, 'common_language_spanish'),
      Alphabet.alphabetPolish1: i18n(context, 'common_language_polish'),
      Alphabet.alphabetGreek1: i18n(context, 'homophone_alphabetGreek1'),
      Alphabet.alphabetGreek2: i18n(context, 'homophone_alphabetGreek2'),
      Alphabet.alphabetRussian1: i18n(context, 'common_language_russian'),
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
        Row(children: <Widget>[
          Expanded(child: GCWText(text: i18n(context, 'homophone_keytype') + ':'), flex: 1),
          Expanded(
              child: GCWDropDownButton(
                value: _currentKeyType,
                onChanged: (value) {
                  setState(() {
                    _currentKeyType = value;
                  });
                },
                items: HomophoneKeyTypeItems.entries.map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode.key,
                    child: Text(mode.value),
                  );
                }).toList(),
              ),
              flex: 2),
        ]),
        _currentKeyType == KeyType.GENERATED
            ? Row(children: <Widget>[
                Expanded(child: GCWText(text: i18n(context, 'homophone_rotation') + ':'), flex: 1),
                Expanded(
                    child: GCWIntegerSpinner(
                      controller: _currentRotationController,
                      min: 0,
                      max: 999999,
                      onChanged: (value) {
                        setState(() {
                          _currentRotation = value;
                        });
                      },
                    ),
                    flex: 2),
              ])
            : Container(),
        _currentKeyType == KeyType.GENERATED
            ? Row(children: <Widget>[
                Expanded(child: GCWText(text: i18n(context, 'homophone_multiplier') + ':'), flex: 1),
                Expanded(
                    child: GCWDropDownSpinner(
                      index: _currentMultiplierIndex,
                      items: getMultipliers().map((item) => GCWText(text: item.toString())).toList(),
                      onChanged: (value) {
                        setState(() {
                          _currentMultiplierIndex = value;
                        });
                      },
                    ),
                    flex: 2),
              ])
            : Container(),
        _currentKeyType == KeyType.OWN1
            ? GCWTextField(
                hintText: "Keys",
                onChanged: (text) {
                  setState(() {
                    _currentOwnKeys = text;
                  });
                },
              )
            : Container(),
        _currentKeyType == KeyType.OWN2
            ? _buildVariablesEditor()
            : Container(),
        Row(children: <Widget>[
          Expanded(child: GCWText(text: i18n(context, 'common_alphabet') + ':'), flex: 1),
          Expanded(
              child: GCWDropDownButton(
                value: _currentAlphabet,
                onChanged: (value) {
                  setState(() {
                    _currentAlphabet = value;
                    _newKeyController.text = _maxLetter();
                  });
                },
                items: HomophoneAlphabetItems.entries.map((alphabet) {
                  return GCWDropDownMenuItem(
                    value: alphabet.key,
                    child: alphabet.value,
                    subtitle: _generateItemDescription(alphabet.key),
                  );
                }).toList(),
              ),
              flex: 2),
        ]),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null || _currentInput.length == 0) return GCWDefaultOutput(child: '');
    int _currentMultiplier = getMultipliers()[_currentMultiplierIndex];

    HomophoneOutput _currentOutput;
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptHomophone(
          _currentInput, _currentKeyType, _currentAlphabet, _currentRotation, _currentMultiplier, _currentOwnKeys, _currentSubstitutions);
    } else {
      _currentOutput = decryptHomophone(
          _currentInput, _currentKeyType, _currentAlphabet, _currentRotation, _currentMultiplier, _currentOwnKeys, _currentSubstitutions);
    }

    if (_currentOutput.errorCode != ErrorCode.OK) {
      switch (_currentOutput.errorCode) {
        case ErrorCode.OWNKEYCOUNT:
          showToast(i18n(context, "homophone_error_own_keys"));
          return GCWDefaultOutput(child: '');
          break;
        case ErrorCode.OWNDOUBLEKEY:
          showToast(i18n(context, "homophone_error_own_double_keys"));
      }
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.output,
        GCWOutput(
            title: i18n(context, 'homophone_used_key'),
            child: GCWOutputText(
              text: _currentOutput.grid,
              isMonotype: true,
            ))
      ],
    );
  }

  _generateItemDescription(Alphabet alphabet) {
    switch (alphabet) {
      case Alphabet.alphabetGreek1:
        return i18n(context, 'homophone_alphabetGreek1_description');
        break;
      case Alphabet.alphabetGreek2:
        return i18n(context, 'homophone_alphabetGreek2_description');
        break;
    }

    return null;
  }

  Widget _buildVariablesEditor() {
    return GCWKeyValueEditor(
        keyController: _newKeyController,
        valueHintText: i18n(context, 'homophone_own_keys_hint'),
        valueFlex: 2,
        keyValueMap: _currentSubstitutions,
        //onNewEntryChanged: _updateNewEntry,
        onAddEntry: _addEntry,
        middleWidget: GCWTextDivider(
          trailing: GCWPasteButton(
              iconSize: IconButtonSize.SMALL,
            onSelected: _addPasteAndAddInput,
          ),
        ),
        onUpdateEntry: _updateEntry,
        onRemoveEntry: _removeEntry);
  }

  _addPasteAndAddInput(String text) {
    if (text == null) return;

    List<String> lines = new LineSplitter().convert(text);
    if (lines == null) return;

    lines.forEach((line) {
      var regExp = RegExp(r"^([\s]*)([\S])([\s]*)([=]?)([\s]*)([\s*\S+]+)([\s]*)");
      var match = regExp.firstMatch(line);
      if (match != null) {
        _addEntry(match.group(2), match.group(6), context);
      }
    });
  }
}
