import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tapir/logic/tapir.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_onoff_switch/widget/gcw_onoff_switch.dart';
import 'package:gc_wizard/tools/common/gcw_twooptions_switch/widget/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/wrapper_for_masktextinputformatter/widget/wrapper_for_masktextinputformatter.dart';

class Tapir extends StatefulWidget {
  @override
  TapirState createState() => TapirState();
}

class TapirState extends State<Tapir> {
  var _inputController;
  var _otpController;

  var _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  var _currentOneTimePadMode = false;

  var _currentOneTimePad = '';

  var _maskFormatter =
      WrapperForMaskTextInputFormatter(mask: '##### ' * 100000 + '#####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();

    _inputController = TextEditingController(text: _currentInput);
    _otpController = TextEditingController(text: _currentOneTimePad);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'tapir_onetimepad'),
          value: _currentOneTimePadMode,
          onChanged: (value) {
            setState(() {
              _currentOneTimePadMode = value;
            });
          },
        ),
        _currentOneTimePadMode
            ? GCWTextField(
                inputFormatters: [_maskFormatter],
                hintText: '12345 67890 12...',
                onChanged: (value) {
                  setState(() {
                    _currentOneTimePad = value;
                  });
                },
              )
            : Container(),
        GCWDefaultOutput(child: _buildOutput()),
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encryptTapir(_currentInput, _currentOneTimePad);
    } else {
      return decryptTapir(_currentInput, _currentOneTimePad);
    }
  }
}
