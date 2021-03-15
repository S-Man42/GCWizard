import 'package:flutter/services.dart';

class CoordsTextNaturalAreaCodeTextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  CoordsTextNaturalAreaCodeTextInputFormatter() {
    _exp = new RegExp('^[0-9BCDFGHJKLMNPQRSTVWXZ]*\$');
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text.toUpperCase())) {
      return newValue;
    }

    return oldValue;
  }
}
