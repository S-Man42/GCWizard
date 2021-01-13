import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/malbolge.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';


class Malbolge extends StatefulWidget {

  @override
  MalbolgeState createState() => MalbolgeState();
}

class MalbolgeState extends State<Malbolge> {
  var _programmController;
  var _inputController;
  var _outputController;

  var _currentProgramm = '';
  var _currentInput = '';
  var _currentOutput = '';
  bool _currentDebug = false;
  bool _currentStrict = false;

  malbolgeOutput output = malbolgeOutput([], [], [], []);

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
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'malbolge_mode_interpret'),
          rightValue: i18n(context, 'malbolge_mode_generate'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right // generate malbolge-programm
            ? Column(
                children: <Widget>[
                  GCWTextField(
                    controller: _outputController,
                    hintText: i18n(context, 'malbolge_hint_output'),
                    onChanged: (text) {
                      setState(() {
                        _currentOutput = text;
                      });
                    },
                  ),
/*
                  GCWToolBar(
                    children: [
                      GCWButton(
                        text: 'Start',
                        onPressed: () {
                          output = generateMalbolge(_currentOutput);
                          _currentDebug = false;
                          setState((){

                          });
                        },
                      )
                    ],
                  )
*/
                ],
              )
            : Column( // interpret malbolge-programm
                children: <Widget>[
                  GCWOnOffSwitch(
                    title:i18n(context, 'malbolge_mode_interpret_strict'),
                    value: _currentStrict,
                    onChanged: (value) {
                      setState(() {
                        _currentStrict = value;
                      });
                    },
                  ),
                  GCWTextField(
                    controller: _programmController,
                    hintText: i18n(context, 'malbolge_hint_code'),
                    onChanged: (text) {
                      setState(() {
                        _currentProgramm = text;
                      });
                    },
                  ),
                  GCWTextField(
                    controller: _inputController,
                    hintText: i18n(context, 'malbolge_hint_input'),
                    onChanged: (text) {
                      setState(() {
                        _currentInput = text;
                      });
                    },
                  ),
                ],
              ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String outputData = '';

    List<List<String>> columnData = new List<List<String>>();

    if (_currentMode == GCWSwitchPosition.left) { // interpret malbolge
      output = interpretMalbolge(_currentProgramm, _currentInput, _currentStrict);
    }
    else {
      output = generateMalbolge(_currentOutput);
    }

    outputData = buildOutputText(output);

    for (int i = 0; i< output.debug.length; i++) {
      columnData.add([output.debug[i].pc, output.debug[i].command, output.debug[i].stack, output.debug[i].output]);
    }


    return Column(
      children: <Widget>[
        GCWDefaultOutput(
          child: GCWOutputText(
            text: outputData,
            isMonotype: true,
          ),
        ),
        _currentMode == GCWSwitchPosition.right // generate malbolge-programm
        ? GCWOutput(
          title: i18n(context, 'malbolge_normalize'),
          child: GCWOutputText(
            text: output.assembler.join(''),
            isMonotype: true,
          ),
        )
        : Container(),
        _currentMode == GCWSwitchPosition.left // interpret malbolge-programm
        ? GCWOnOffSwitch(
          title:i18n(context, 'malbolge_debug'),
          value: _currentDebug,
          onChanged: (value) {
            setState(() {
              _currentDebug = value;
            });
          },
        )
        : Container(),
        _currentDebug == true
          ? Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            GCWTextDivider(
                              text: i18n(context, 'malbolge_hint_code_assembler')
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
                    flex: 5,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            GCWTextDivider(
                              text: i18n(context, 'malbolge_hint_code_memnonic')
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

  String buildOutputText(malbolgeOutput outputList){
    String output = '';
    outputList.output.forEach((element) {
      if (element != null)
        if (element.startsWith('malbolge_')) {
          output = output + i18n(context, element) + '\n';
        } else
          output = output + element + '\n';
    });
    return output;
  }

}