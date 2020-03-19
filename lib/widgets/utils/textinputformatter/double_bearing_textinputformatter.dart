import 'package:flutter/services.dart';

class DoubleBearingTextInputFormatter extends TextInputFormatter {

  DoubleBearingTextInputFormatter();

  @override TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (['', '.', ','].contains(newValue.text))
      return newValue;

    var _newDouble = double.tryParse(newValue.text.replaceFirst(',', '.'));
    if (_newDouble == null)
      return oldValue;

    if (_newDouble >= 0 && _newDouble <= 360)
      return newValue;

    return oldValue;
  }
}