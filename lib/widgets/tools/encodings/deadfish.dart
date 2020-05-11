import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/deadfish.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Deadfish extends StatefulWidget {
  @override
  DeadfishState createState() => DeadfishState();
}

class DeadfishState extends State<Deadfish> {
  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.left;
  var _currentOutputMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          }
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'deadfish_mode_left'),
          rightValue: i18n(context, 'deadfish_mode_right'),
          onChanged: (value) {
            setState(() {
              _currentOutputMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null)
      return '';

    var out = _currentMode == GCWSwitchPosition.left
      ? encodeDeadfish(_currentInput)
      : decodeDeadfish(
      _currentOutputMode == GCWSwitchPosition.right
        ? _currentInput.replaceAll('x', 'i').replaceAll('k', 's').replaceAll('c', 'o')
        : _currentInput
    );
    if (_currentMode == GCWSwitchPosition.left && _currentOutputMode == GCWSwitchPosition.right)
      out = out.replaceAll('i', 'x').replaceAll('s', 'k').replaceAll('o', 'c');

    return out;
  }
}
