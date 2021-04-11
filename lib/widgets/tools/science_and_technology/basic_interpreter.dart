import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/basic_interpreter.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class BasicInterpreter extends StatefulWidget {
  @override
  BasicInterpreterState createState() => BasicInterpreterState();
}

class BasicInterpreterState extends State<BasicInterpreter> {
  var _programmController;
  var _inputController;

  var _currentProgram = '';
  var _currentInput = '';

  @override
  void initState() {
    super.initState();
    _programmController = TextEditingController(text: _currentProgram);
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _programmController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         Column(
          // interpret Beatnik-programm
          children: <Widget>[
            GCWTextField(
              controller: _programmController,
              hintText: i18n(context, 'basicinterpreter_hint_program'),
              onChanged: (text) {
                setState(() {
                  _currentProgram = text;
                });
              },
            ),
            GCWTextField(
              controller: _inputController,
              hintText: i18n(context, 'basicinterpreter_hint_input'),
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
    return Column(
      children: <Widget>[
        GCWDefaultOutput(
          child: GCWOutputText(
            text: interpretBasic(_currentProgram, _currentInput)
          ),
        ),
      ],
    );
  }

}
