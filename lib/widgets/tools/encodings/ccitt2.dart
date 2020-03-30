import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/ccitt2.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_crosstotal_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_output.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class CCITT2 extends StatefulWidget {
  @override
  CCITT2State createState() => CCITT2State();
}

class CCITT2State extends State<CCITT2> {
  var _controller;

  var _currentInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  
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
              });
            },
          ) :
          GCWIntegerListTextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {
                _currentInput = text;
              });
            },
          ),
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;

              if (_currentMode == GCWSwitchPosition.right) {
                var text = _currentInput['text'];
                _currentInput = {'text': text, 'values': textToIntList(text)};
              }
            });
          },
        ),
        GCWDefaultOutput(
          text: _buildOutput()
        ),
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encodeCCITT2(_currentInput['text']);
    } else {
      return decodeCCITT2(_currentInput['values']);
    }
  }
}