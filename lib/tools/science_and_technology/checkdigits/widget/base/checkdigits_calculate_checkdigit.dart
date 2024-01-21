import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

class CheckDigitsCalculateCheckDigit extends StatefulWidget {
  final CheckDigitsMode mode;
  const CheckDigitsCalculateCheckDigit({Key? key, required this.mode, }) : super(key: key);

  @override
  CheckDigitsCalculateCheckDigitState createState() => CheckDigitsCalculateCheckDigitState();
}

class CheckDigitsCalculateCheckDigitState extends State<CheckDigitsCalculateCheckDigit> {
  String _currentInputNString = '';
  late TextEditingController currentInputController;

  @override
  void initState() {
    super.initState();
    currentInputController = TextEditingController(text: _currentInputNString);
  }

  @override
  void dispose() {
    currentInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField( // CheckDigitsMode.ISBN, CheckDigitsMode.IBAN, CheckDigitsMode.EURO, CheckDigitsMode.DEPERSID
          controller: currentInputController,
          inputFormatters: [INPUTFORMATTERS[widget.mode]!],
          hintText: INPUTFORMATTERS_HINT[widget.mode]!,
          onChanged: (text) {
            setState(() {
              _currentInputNString = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    String output = checkDigitsCalculateCheckDigitAndNumber(widget.mode, checkDigitsNormalizeNumber(_currentInputNString));
    if (output.startsWith('check')) {
      output = i18n(context, output);
    }
    return GCWDefaultOutput(
      child: _formatOutput(output, widget.mode),
    );
  }

  String _formatOutput(String output, CheckDigitsMode mode){
    switch (mode) {
      case CheckDigitsMode.EAN_GTIN:
      case CheckDigitsMode.DETAXID:
      case CheckDigitsMode.EURO:
      case CheckDigitsMode.IMEI:
      case CheckDigitsMode.ISBN:
      case CheckDigitsMode.UIC:
        return output;
      case CheckDigitsMode.IBAN:
      case CheckDigitsMode.CREDITCARD:
        return _formatOutput_IBAN_Creditcard(output);
      default:
        return '';
    }
  }

  String _formatOutput_IBAN_Creditcard(String output){
    String result = '';
    for (int i = 0; i < output.length; i++) {
      result = result + output[i];
      if ((i + 1) % 4 == 0) {
        result = result + ' ';
      }
    }
    return result;
  }

}