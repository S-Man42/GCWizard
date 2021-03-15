import 'package:flutter/services.dart';

class CoordsIntegerUTMLonZoneTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == '') return newValue;

    var _newInt = int.tryParse(newValue.text);
    if (_newInt == null) return oldValue;

    if (_newInt >= 1 && _newInt <= 60) return newValue;

    return oldValue;
  }
}
