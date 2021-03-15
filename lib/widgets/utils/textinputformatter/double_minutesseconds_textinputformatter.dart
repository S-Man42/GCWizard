import 'package:flutter/services.dart';

class DoubleMinutesSecondsTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (['', '-', '.', ','].contains(newValue.text)) return newValue;

    var _newDouble = double.tryParse(newValue.text.replaceFirst(',', '.'));
    if (_newDouble == null) return oldValue;

    if (_newDouble >= 0 && _newDouble < 60) return newValue;

    return oldValue;
  }
}
