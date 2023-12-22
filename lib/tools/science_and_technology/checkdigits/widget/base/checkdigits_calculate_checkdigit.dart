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
    String output = checkDigitsCalculateNumber(widget.mode, checkDigitsNormalizeNumber(_currentInputNString));
    if (output.startsWith('check')) {
      output = i18n(context, output);
    }
    return GCWDefaultOutput(
      child: output,
    );
  }
}