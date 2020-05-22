import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/atbash.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rail_fence.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/text_onlyletters_textinputformatter.dart';

class RailFence extends StatefulWidget {
  @override
  RailFenceState createState() => RailFenceState();
}

class RailFenceState extends State<RailFence> {
  String _currentInput = '';
  var _currentKey = 2;
  String _currentPassword = '';
  var _currentOffset = 0;

  var _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWIntegerSpinner(
          title: 'Key',
          value: _currentKey,
          min: 2,
          max: _currentInput.length,
          onChanged: (value) {
            setState(() {
              _currentKey = value;
            });
          },
        ),
        Row(
          children: [
            Expanded(
              child: GCWText(text: 'Optional Password'),
              flex: 1
            ),
            Expanded(
              child: GCWTextField(
                maxLength: _currentKey,
                inputFormatters: [TextOnlyLettersInputFormatter()],
                onChanged: (text) {
                  setState(() {
                    _currentPassword = text;
                  });
                },
              ),
              flex: 3
            )
          ],
        ),
        GCWIntegerSpinner(
          title: 'Offset',
          min: 0,
          max: _currentInput.length,
          value: _currentOffset,
          onChanged: (value) {
            setState(() {
              _currentOffset = value;
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
      ? encryptRailFence(_currentInput, _currentKey, offset: _currentOffset, password: _currentPassword)
      : decryptRailFence(_currentInput, _currentKey, offset: _currentOffset, password: _currentPassword);
  }
}