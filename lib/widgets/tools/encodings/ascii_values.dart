import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_output.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class ASCIIValues extends StatefulWidget {
  @override
  ASCIIValuesState createState() => ASCIIValuesState();
}

class ASCIIValuesState extends State<ASCIIValues> {
  var _controller;

  var _currentInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  bool _currentCrosstotalMode = true;
  
  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput['text']);
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
        _currentMode == GCWSwitchPosition.left ?
          GCWTextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {
                _currentInput = {'text': text, 'values' : []};
                _calculateOutput();
              });
            },
          ) :
          GCWIntegerListTextField(
            controller: _controller,
            min: 0,
            max: 0xffff,
            onChanged: (text) {
              setState(() {
                _currentInput = text;
                _calculateOutput();
              });
            },
          ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'asciivalues_mode_left'),
          rightValue: i18n(context, 'asciivalues_mode_right'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;

              if (_currentMode == GCWSwitchPosition.right) {
                var text = _currentInput['text'];
                /**
                 * The call to textToIntList is needed for two reasons.
                 * First, it converts the dynamic list to an integer list, which is needed later for intListToString.
                 * Second, when switching modes to 'right', it parses the old string and prints out only valid numbers.
                 */
                _currentInput = {'text': text, 'values': textToIntList(text)};
              }

              _calculateOutput();
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'crosstotal_title'),
          value: true,
          onChanged: (value) {
            setState(() {
              _currentCrosstotalMode = value;
              _calculateOutput();
            });
          },
        ),
        GCWDefaultOutput(
          text: _output
        ),
        _currentCrosstotalMode ? GCWCrosstotalOutput(_currentInput['text'], _currentInput['values']) : Container()
      ],
    );
  }

  _calculateOutput() {
    String text = _currentInput['text'];

    if (_currentMode == GCWSwitchPosition.left) {
      _currentInput = {'text': text, 'values': text.codeUnits};
      _output = intListToString(_currentInput['values'], delimiter: ', ');
    } else {
      _output = String.fromCharCodes(_currentInput['values']);
    }
  }
}