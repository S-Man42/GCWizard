import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/one_time_pad.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/text_onlyletters_textinputformatter.dart';

class OneTimePad extends StatefulWidget {
  @override
  OneTimePadState createState() => OneTimePadState();
}

class OneTimePadState extends State<OneTimePad> {
  String _currentInput = '';
  String _currentKey = '';

  var _currentOffset = 0;

  var _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          hintText: i18n(context, 'onetimepad_input'),
          inputFormatters: [TextOnlyLettersInputFormatter()],
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextField(
          hintText: i18n(context, 'onetimepad_key'),
          inputFormatters: [TextOnlyLettersInputFormatter()],
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'onetimepad_keyoffset'),
          value: _currentOffset + 1,
          onChanged: (value) {
            setState(() {
              _currentOffset = value - 1;
            });
          },
        ),
        GCWTwoOptionsSwitch(
            value: _currentMode,
            onChanged: (value) {
              setState(() {
                _currentMode = value;
              });
            }
        ),
        GCWDefaultOutput(
            text: _calculateOutput()
        )
      ],
    );
  }

  _calculateOutput() {
    return _currentMode == GCWSwitchPosition.left
      ? encryptOneTimePad(_currentInput, _currentKey, keyOffset: _currentOffset)
      : decryptOneTimePad(_currentInput, _currentKey, keyOffset: _currentOffset);
  }
}