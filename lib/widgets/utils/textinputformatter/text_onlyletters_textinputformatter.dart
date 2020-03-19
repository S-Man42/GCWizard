import 'package:flutter/services.dart';

class TextOnlyLettersInputFormatter extends TextInputFormatter {

  @override TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length != newValue.text.replaceAll(RegExp(r'[^A-Za-z]'), '').length)
      return oldValue;

    return newValue;
  }
}