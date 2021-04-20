import 'package:flutter/services.dart';

class CoordsDoubleDegreesLonTextInputFormatter extends TextInputFormatter {
  final allowNegativeValues;

  CoordsDoubleDegreesLonTextInputFormatter({this.allowNegativeValues: false});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!allowNegativeValues && newValue.text == '-') return oldValue;

    if (['', '-', '.', ','].contains(newValue.text)) return newValue;

    var _newDouble = double.tryParse(newValue.text.replaceFirst(',', '.'));
    if (_newDouble == null) return oldValue;

    if (!allowNegativeValues && _newDouble < 0) return oldValue;

    if (_newDouble >= -180 && _newDouble <= 180) return newValue;

    return oldValue;
  }
}
