
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/cipher_wheel.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/theme/theme.dart';

class CipherWheel extends StatefulWidget {
  const CipherWheel();

  @override
  CipherWheelState createState() => CipherWheelState();
}

class CipherWheelState extends State<CipherWheel> {
  var _controller;

  String _currentInput = '';
  int _currentKey = 1;
  int _currentLetterValue = 1;
  String _output = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: _currentInput
    );
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
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
              _calculateOutput();
            });
          },
        ),
        Row(
          children: [
            Expanded(
              child: GCWABCSpinner(
                value: _currentLetterValue,
                onChanged: (value) {
                  setState(() {
                    _currentLetterValue = value;
                    _calculateOutput();
                  });
                },
              )
            ),
            Container(
              child: GCWText(text: '='),
              padding: EdgeInsets.only(left: 2 * DEFAULT_MARGIN, right: 2 * DEFAULT_MARGIN),
            ),
            Expanded(
              child: GCWIntegerSpinner(
                value: _currentKey,
                min: 1,
                max: 26,
                onChanged: (value) {
                  setState(() {
                    _currentKey = value;
                    _calculateOutput();
                  });
                },
              ),
            )
          ],
        ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
              _calculateOutput();
            });
          },
        ),
        GCWDefaultOutput(
          child: _output
        )
      ],
    );
  }

  _calculateOutput() {
    var key = _currentKey - _currentLetterValue + 1;

    if (_currentMode == GCWSwitchPosition.right) {
      var input = _currentInput
        .split(RegExp('[^0-9]+'))
        .where((number) => number != null && number.length > 0)
        .map((number) => int.tryParse(number))
        .toList();
      _output = decryptCipherWheel(input, key);
    } else {
      _output = encryptCipherWheel(_currentInput, key).join(' ');
    }
  }
}