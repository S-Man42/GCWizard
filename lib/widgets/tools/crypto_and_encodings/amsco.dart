import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/amsco.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';

class Amsco extends StatefulWidget {
  @override
  AmscoState createState() => AmscoState();
}

class AmscoState extends State<Amsco> {
  var _inputController;
  var _keyController;

  String _currentInput = '';
  String _currentKey = '';

  var _currentMode = GCWSwitchPosition.right;
  var _currentOneCharStart = GCWSwitchPosition.left;

  var _maskFormatter = WrapperForMaskTextInputFormatter(mask: '#' * 9, filter: {"#": RegExp(r'[ 0-9]')});

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _keyController = TextEditingController(text: _currentKey);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _keyController.dispose();
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
        GCWTwoOptionsSwitch(
          title: i18n(context, 'amsco_mode'),
          leftValue: i18n(context, 'amsco_mode_left'),
          rightValue: i18n(context, 'amsco_mode_right'),
          value: _currentOneCharStart,
          onChanged: (value) {
            setState(() {
              _currentOneCharStart = value;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'common_key')),
        GCWTextField(
          hintText: i18n(context, 'amsco_key_hint'),
          inputFormatters: [_maskFormatter],
          controller: _keyController,
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var _currentOutput;
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptAmsco(_currentInput, _currentKey, _currentOneCharStart == GCWSwitchPosition.left);
    } else {
      _currentOutput = decryptAmsco(_currentInput, _currentKey, _currentOneCharStart == GCWSwitchPosition.left);
    }

    if (_currentOutput == null) {
      return GCWDefaultOutput();
    } else if (_currentOutput.errorCode != ErrorCode.OK) {
      switch (_currentOutput.errorCode) {
        case ErrorCode.Key:
          showToast(i18n(context, 'amsco_error_key'));
          break;
      }
      return GCWDefaultOutput();
    } else if (_currentOutput.output == '') {
      return GCWDefaultOutput();
    }
    ;

    return GCWMultipleOutput(
      children: [
        _currentOutput.output,
        GCWOutput(
          title: i18n(context, 'amsco_usedgrid'),
          child: GCWOutputText(
            text: _currentOutput.grid,
            isMonotype: true,
          ),
        )
      ],
    );
  }
}
