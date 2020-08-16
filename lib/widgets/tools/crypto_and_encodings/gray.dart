import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gray.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_encrypt_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Gray extends StatefulWidget {
  @override
  GrayState createState() => GrayState();
}

class GrayState extends State<Gray> {
  var _inputController;
  var _currentOutput = GrayOutput('', '', '', '');

  String _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;         /// switches between 5x5 or 6x6 square

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
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
          title: i18n(context, 'gray_mode'),
          leftValue: i18n(context, 'gray_mode_decimal'),
          rightValue: i18n(context, 'gray_mode_binary'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),

        GCWEncryptButtonBar(
          onPressedEncode: () {
            if (_currentInput == null || _currentInput.length == 0) {
              showToast(i18n(context, 'Gray_error_no_encrypt_input'));
            } else {
              if (_currentMode == GCWSwitchPosition.left) {
                setState(() {
                  _currentOutput = encryptGray(_currentInput, mode: GrayMode.Decimal);
                });
              } else {
                setState(() {
                  _currentOutput = encryptGray(_currentInput);
                });
              }
            }
          },
          onPressedDecode: () {
            if (_currentInput == null || _currentInput.length == 0) {
              showToast(i18n(context, 'Gray_error_no_output'));
            } else {
              setState(() {
                _currentOutput = decryptGray(_currentInput, mode: GrayMode.Decimal);
              });
            }
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentOutput.state == null || _currentOutput.state == '')
      return Container();

    if (_currentOutput.state == 'ERROR') {
      showToast(i18n(context, _currentOutput.output_plain_binary));
      return GCWDefaultOutput(
          text: '' //TODO: Exception
      );
    }

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWOutputText(
              text: _currentOutput.output_plain_binary + '\n'
                  + _currentOutput.output_gray_decimal + '\n'
                  + _currentOutput.output_gray_binary
          ),
        ],
      ),
    );
  }
}