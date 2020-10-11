import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/homophone.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Homophone extends StatefulWidget {
  @override
  HomophoneState createState() => HomophoneState();
}

class HomophoneState extends State<Homophone> {
  var _currentMode = GCWSwitchPosition.left;

  var _currentRotationController;
  String _currentInput = '';
  Alphabet _currentAlphabet = Alphabet.alphabetGerman1 ;
  KeyType _currentKeyType = KeyType.GENERATED;
  int _currentRotation = 1;
  int _currentMultiplierIndex = 0;
  String _currentOwnKeys = '';

  final aKeys = [1,3,5,7,9,11,15,17,19,21,25];

  @override
  void initState() {
    super.initState();

    _currentRotationController =  TextEditingController(text: _currentRotation.toString());
  }

  @override
  void dispose() {
    _currentRotationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var HomophoneKeyTypeItems = {
      KeyType.GENERATED : i18n(context, 'homophone_keytype_generated'),
      KeyType.OWN : i18n(context, 'homophone_keytype_own'),
    };

    var HomophoneAlphabetItems = {
      Alphabet.alphabetGerman1 : i18n(context, 'homophone_alphabetGerman1'),
      Alphabet.alphabetEnglish1 : i18n(context, 'homophone_alphabetEnglish1'),
      Alphabet.alphabetSpanish2 : i18n(context, 'homophone_alphabetSpanish2'),
      Alphabet.alphabetPolish1 : i18n(context, 'homophone_alphabetPolish1'),
      Alphabet.alphabetGreek1 : i18n(context, 'homophone_alphabetGreek1'),
      Alphabet.alphabetRussian1 : i18n(context, 'homophone_alphabetRussian1'),
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
        Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                text: i18n(context, 'homophone_keytype') + ':'
              ),
              flex: 1
            ),
            Expanded(
              child : GCWDropDownButton(
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
              flex: 2
            ),
          ]
        ),

        _currentKeyType == KeyType.GENERATED
          ? Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                text: i18n(context, 'homophone_rotation') + ':'
              ),
              flex: 1
            ),
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
              flex: 2
            ),
          ]
        )
        : Container(),
        _currentKeyType == KeyType.GENERATED
        ? Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                text: i18n(context, 'homophone_multiplier') + ':'
              ),
              flex: 1
            ),
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
              flex: 2
            ),
          ]
        )
        :  GCWTextField(
          hintText: "Keys",
          onChanged: (text) {
          setState(() {
            _currentOwnKeys = text;
          });
        },
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                  text: i18n(context, 'homophone_alphabet') + ':'
              ),
              flex: 1
            ),
            Expanded(
              child : GCWDropDownButton(
                value: _currentAlphabet,
                onChanged: (value) {
                  setState(() {
                    _currentAlphabet = value;
                  });
                },
                items: HomophoneAlphabetItems.entries.map((alphabet) {
                  return GCWDropDownMenuItem(
                    value: alphabet.key,
                    child: alphabet.value,
                  );
                }).toList(),
              ),
              flex: 2
            ),
          ]
        ),

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

    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput(child: '');
    int _currentMultiplier = getMultipliers()[_currentMultiplierIndex];

    HomophonOutput _currentOutput ;
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptHomophon(
        _currentInput,
        _currentKeyType,
        _currentAlphabet,
        _currentRotation,
        _currentMultiplier,
        _currentOwnKeys
      );
    } else {
      _currentOutput = decryptHomophon(
        _currentInput,
        _currentKeyType,
        _currentAlphabet,
        _currentRotation,
        _currentMultiplier,
        _currentOwnKeys
      );
    }

    if (_currentOutput.errorCode != ErrorCode.OK) {
      switch (_currentOutput.errorCode) {
        case  ErrorCode.OWNKEYCOUNT:
          showToast(i18n(context, "homophone_error_own_keys"));
      }
      return GCWDefaultOutput(child: '');
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.output,
        GCWOutput(
          title: i18n(context, 'homophone_used_key'),
          child: GCWOutputText(
            text: _currentOutput.grid,
            isMonotype: true,
          )
        )
      ],
    );
  }
}