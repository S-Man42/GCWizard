import 'package:flutter/services.dart';

class CoordsTextGeoHexTextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  CoordsTextGeoHexTextInputFormatter() {
    _exp = new RegExp('^([A-Za-z]|[A-Za-z]{2}[0-9]*)?\$');
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text.toLowerCase())) {
      return newValue;
    }

    return oldValue;
  }
}
