import 'package:flutter/services.dart';

class CoordsTextGeo3x3TextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  CoordsTextGeo3x3TextInputFormatter() {
    _exp = new RegExp('^([EeWw]|[EeWw][1-9]*)?\$');
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text.toLowerCase())) {
      return newValue;
    }

    return oldValue;
  }
}
