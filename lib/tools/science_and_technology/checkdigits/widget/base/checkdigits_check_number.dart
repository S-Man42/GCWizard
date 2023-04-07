import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

import 'package:gc_wizard/tools/science_and_technology/check_digits/base/check_digits.dart';

class CheckDigitsCalculateCheckDigit extends StatefulWidget {
  final CheckDigitsMode mode;
  final int maxIndex;
  const CheckDigitsCalculateCheckDigit({required Key key, this.mode, required this.maxIndex}) : super(key: key);

  @override
  CheckDigitsCalculateCheckDigitState createState() => CheckDigitsCalculateCheckDigitState();
}

class CheckDigitsCalculateCheckDigitState extends State<CheckDigitsCalculateCheckDigit> {
  String _currentInputNString = '';
  int _currentInputNInt= 0;
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
        (widget.mode == CheckDigitsMode.EAN || widget.mode == CheckDigitsMode.DETAXID || widget.mode == CheckDigitsMode.IMEI)
            ? GCWIntegerSpinner(
          min: 0,
          max: maxInt[widget.mode] ~/ 10,
          value: _currentInputNInt,
          onChanged: (value) {
            setState(() {
              _currentInputNInt = value;
              _currentInputNString = _currentInputNInt.toString();
            });
          },
        )
            : GCWTextField( // CheckDigitsMode.ISBN, CheckDigitsMode.IBAN, CheckDigitsMode.EURO, CheckDigitsMode.DEPERSID
          controller: currentInputController,
          inputFormatters: [INPUTFORMATTERS[widget.mode]],
          hintText: INPUTFORMATTERS_HINT[widget.mode],
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
    String output = checkDigitsCalculateNumber(widget.mode, _currentInputNString);
    if (output.startsWith('check')) {
      output = i18n(context, output);
    }
    return GCWDefaultOutput(
      child: output,
    );
  }
}