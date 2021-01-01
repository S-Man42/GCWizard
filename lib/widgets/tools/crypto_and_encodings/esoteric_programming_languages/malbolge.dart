import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/malbolge.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

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
          ],
        )
            : Column( // interpret malbolge-programm
          children: <Widget>[
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
        GCWTextDivider(
            text: i18n(context, 'malbolge_hint_output')
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    malbolgeOutput output;
    String outputData = '';
    var flexData;
    flexData = [1, 2, 3, 3];

    List<List<String>> columnData = new List<List<String>>();

    if (_currentMode == GCWSwitchPosition.right) { // generate malbolge
      output = generateMalbolge(_currentOutput);
    } else { // interpret malbolge
      output = interpretMalbolge(_currentProgramm.toUpperCase(), _currentInput);
    }

    outputData = buildOutputText(output);

    for (int i = 0; i< output.debug.length; i++) {
      columnData.add([output.debug[i].pc, output.debug[i].command, output.debug[i].stack, output.debug[i].output]);
    }


    return Column(
      children: <Widget>[
        GCWOutputText(
          text: outputData,
          isMonotype: true,
        ),
        GCWOnOffSwitch(
          title:i18n(context, 'malbolge_debug'),
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
                title: i18n(context, 'malbolge_debug'),
                child: Column(
                    children: columnedMultiLineOutput(context, columnData, flexValues: flexData)
                ),
              ),
              GCWTextDivider(
                text: i18n(context, 'malbolge_hint_code'),
              ),
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
                    flex: 2,
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