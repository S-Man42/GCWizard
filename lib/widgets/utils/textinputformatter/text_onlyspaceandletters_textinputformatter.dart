import 'package:flutter/services.dart';

class TextOnlySpaceAndLettersInputFormatter extends TextInputFormatter {

  @override TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length != newValue.text.replaceAll(RegExp(r'[^\sA-Za-z]'), '').length)
      return oldValue;

    return newValue;
  }
}