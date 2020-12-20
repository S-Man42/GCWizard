import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/beatnik_language.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/logic/tools/games/scrabble_sets.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';

class Beatnik extends StatefulWidget {

  @override
  BeatnikState createState() => BeatnikState();
}

class BeatnikState extends State<Beatnik> {
  var _programmController;
  var _inputController;
  var _outputController;

  var _currentProgramm = '';
  var _currentInput = '';
  var _currentOutput = '';
  var _currentScrabbleVersion = scrabbleID_EN;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;    // interpret

  @override
  void initState() {
    super.initState();
    _programmController = TextEditingController(text: _currentProgramm);
    _inputController = TextEditingController(text: _currentInput);
    _outputController = TextEditingController(text: _currentOutput);
  }

  @override
  void dispose() {
    _programmController.dispose();
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentScrabbleVersion,
          onChanged: (value) {
            setState(() {
              _currentScrabbleVersion = value;
            });
          },
          items: scrabbleSets.entries.map((set) {
            return GCWDropDownMenuItem(
              value: set.key,
              child: i18n(context, set.value.i18nNameId),
            );
          }).toList(),
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'beatnik_mode_interpret'),
          rightValue: i18n(context, 'beatnik_mode_generate'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right // generate Chef-programm
            ? Column(
          children: <Widget>[
            GCWTextField(
              controller: _outputController,
              hintText: i18n(context, 'beatnik_hint_output'),
              onChanged: (text) {
                setState(() {
                  _currentOutput = text;
                });
              },
            ),
            GCWTextDivider(
                text: i18n(context, 'beatnik_hint_code')
            ),
          ],
        )
            : Column(
          children: <Widget>[
            GCWTextField(
              controller: _programmController,
              hintText: i18n(context, 'beatnik_hint_code'),
              onChanged: (text) {
                setState(() {
                  _currentProgramm = text;
                });
              },
            ),
            GCWTextField(
              controller: _inputController,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),],
              hintText: i18n(context, 'beatnik_hint_input'),
              onChanged: (text) {
                setState(() {
                  _currentInput = text;
                });
              },
            ),
            GCWTextDivider(
                text: i18n(context, 'beatnik_hint_output')
            ),
          ],
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String output = '';
    if (_currentMode == GCWSwitchPosition.right) { // generate chef
        output = generateBeatnik(_currentScrabbleVersion, _currentOutput);
    } else { // interpret chef
        output = buildOutputText(interpretBeatnik(_currentScrabbleVersion, _currentProgramm.toUpperCase(), _currentInput));
    }
    return GCWOutputText(
      text: output.trim(),
      isMonotype: true,
    );
  }

  String buildOutputText(List<String> outputList){
    String output = '';
    outputList.forEach((element) {
      if (element.startsWith('beatnik_')) {
        output = output
            + i18n(context, element) + '\n';
      } else
        output = output + element + '\n';
    });
    return output;
  }
}