import 'package:flutter/services.dart';

class CoordsTextMaidenheadTextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  CoordsTextMaidenheadTextInputFormatter() {
    _exp = new RegExp('^([A-Za-z]{2}[0-9]{2})*([A-Za-z]?|[A-Za-z]{2}[0-9]{0,2})\$');
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}
