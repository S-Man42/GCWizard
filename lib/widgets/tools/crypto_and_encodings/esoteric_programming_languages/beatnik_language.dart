import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'file:///D:/Programmierung/GCWizard/lib/logic/tools/crypto_and_encodings/esoteric_programming_languages/beatnik_language.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/logic/tools/games/scrabble_sets.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

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
  bool _currentScrabble = true;
  bool _currentDebug = false;

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
        _currentMode == GCWSwitchPosition.right // generate Beatnik-programm
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
                ],
              )
            : Column( // interpret Beatnik-programm
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
              hintText: i18n(context, 'beatnik_hint_input'),
              onChanged: (text) {
                setState(() {
                  _currentInput = text;
                });
              },
            ),
          ],
        ),
        GCWTextDivider(
            text: i18n(context, 'beatnik_hint_output')
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    BeatnikOutput output;
    String outputData = '';
    var flexData;
    flexData = [1, 2, 3, 3];

    List<List<String>> columnData = new List<List<String>>();

    if (_currentMode == GCWSwitchPosition.right) { // generate beatnik
      output = generateBeatnik(_currentScrabbleVersion, _currentOutput);
    } else { // interpret beatnik
      output = interpretBeatnik(_currentScrabbleVersion, _currentProgramm.toUpperCase(), _currentInput);
    }

    outputData = buildOutputText(output);

    for (int i = 0; i< output.debug.length; i++) {
      columnData.add([output.debug[i].pc, output.debug[i].command, output.debug[i].stack, output.debug[i].output]);
    }


    return Column(
      children: <Widget>[
        GCWOutputText(
          text: outputData,
        ),
        GCWOnOffSwitch(
          title:i18n(context, 'beatnik_debug'),
          value: _currentDebug,
          onChanged: (value) {
            setState(() {
              _currentDebug = value;
            });
          },
        ),
        _currentDebug == true
            ? Column(
                children: <Widget>[
                  GCWOutput(
                    title: i18n(context, 'beatnik_debug'),
                    child: Column(
                        children: columnedMultiLineOutput(context, columnData, flexValues: flexData)
                    ),
                  ),
                  GCWTextDivider(
                    text: i18n(context, 'beatnik_hint_code'),
                  ),
                  GCWOnOffSwitch(
                    title: i18n(context, 'beatnik_show_scrabble'),
                    value: _currentScrabble,
                    onChanged: (value) {
                      setState(() {
                        _currentScrabble = value;
                      });
                    },
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _currentScrabble == true
                            ? Expanded(
                            flex: 2,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  child: Column(
                                      children: <Widget>[
                                        GCWTextDivider(
                                            text: i18n(context, 'beatnik_hint_code_scrabble')
                                        ),
                                        GCWOutputText(
                                          text: output.scrabble.join('\n'),
                                          isMonotype: true,
                                        ),
                                      ]
                                  ),
                                  padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                                )
                            )
                        )
                            : Container(),
                        Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    GCWTextDivider(
                                        text: i18n(context, 'beatnik_hint_code_assembler')
                                    ),
                                    GCWOutputText(
                                      text: output.assembler.join('\n'),
                                      isMonotype: true,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    GCWTextDivider(
                                        text: i18n(context, 'beatnik_hint_code_memnonic')
                                    ),
                                    GCWOutputText(
                                      text: output.memnonic.join('\n'),
                                      isMonotype: true,
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.only(left: DEFAULT_MARGIN),
                              ),
                            )
                        ),
                      ]
                  ),
                ]
              )
            : Container(),
      ],
    );
  }

  String buildOutputText(BeatnikOutput outputList){
    String output = '';
    outputList.output.forEach((element) {
      if (element.startsWith('beatnik_')) {
        output = output + i18n(context, element) + '\n';
      } else
        output = output + element + '\n';
    });
    return output;
  }

}