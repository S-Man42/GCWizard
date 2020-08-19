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
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Gray extends StatefulWidget {
  @override
  GrayState createState() => GrayState();
}

class GrayState extends State<Gray> {
  var _inputDecimalController;
  var _inputBinaryController;

  String _currentInput = '';
  var _currentOutput = GrayOutput('', '', '', '');

  GCWSwitchPosition _currentInputMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentCodingMode = GCWSwitchPosition.left;

  var _decimalMaskFormatter = MaskTextInputFormatter(
      mask: '#' * 10000,
      filter: {"#": RegExp(r'[0-9\s]')}
  );

  var _binaryDigitsMaskFormatter = MaskTextInputFormatter(
      mask: '#' * 10000,
      filter: {"#": RegExp(r'[01\s]')}
  );


  @override
  void initState() {
    super.initState();
    _inputDecimalController = TextEditingController(text: _currentInput);
    _inputBinaryController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputBinaryController.dispose();
    _inputDecimalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[

        _currentInputMode == GCWSwitchPosition.left
            ? GCWTextField(
            controller: _inputDecimalController,
            inputFormatters: [_decimalMaskFormatter],
            onChanged: (text){
              setState(() {
                _currentInput = text;
              });
            }
        )
            : GCWTextField (
            controller: _inputBinaryController,
            inputFormatters: [_binaryDigitsMaskFormatter],
            onChanged: (text){
              setState(() {
                _currentInput = text;
              });
            }
        ),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'gray_mode'),
          leftValue: i18n(context, 'gray_mode_decimal'),
          rightValue: i18n(context, 'gray_mode_binary'),
          onChanged: (value) {
            setState(() {
              _currentInputMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentCodingMode = value;
            });
          },
        ),

        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
      if (_currentCodingMode == GCWSwitchPosition.left) {
      if (_currentInputMode == GCWSwitchPosition.left) {
         _currentOutput = encryptGray(_currentInput, mode: GrayMode.Decimal);
      } else {// input is binary
         _currentOutput = encryptGray(_currentInput, mode: GrayMode.Binary);
      }
    } else {
      if (_currentInputMode == GCWSwitchPosition.left) {
         _currentOutput = decryptGray(_currentInput, mode: GrayMode.Decimal);
      } else {
         _currentOutput = decryptGray(_currentInput, mode: GrayMode.Binary);
      }
    }

    if (_currentOutput == null )
      return GCWDefaultOutput(
        text: '' //TODO: Exception
      );

    return
      Column(
        children: <Widget>[
          GCWTextDivider(
            text: i18n(context, 'common_output')
        ),
          GCWOutputText(
            text: _currentOutput.output_gray_decimal
          ),
          GCWOutputText(
            text: _currentOutput.output_gray_binary
          ),
      ]
    );
  }
}