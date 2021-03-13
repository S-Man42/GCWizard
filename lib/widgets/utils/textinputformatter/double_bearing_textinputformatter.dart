import 'package:flutter/services.dart';

class DoubleBearingTextInputFormatter extends TextInputFormatter {
  DoubleBearingTextInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (['', '.', ',', '-'].contains(newValue.text)) return newValue;

    var _newDouble = double.tryParse(newValue.text.replaceFirst(',', '.'));
    if (_newDouble == null) return oldValue;

    return newValue;
  }
}
