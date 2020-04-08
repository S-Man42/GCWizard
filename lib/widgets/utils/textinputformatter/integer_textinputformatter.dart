import 'package:flutter/services.dart';

class IntegerTextInputFormatter extends TextInputFormatter {
  int min;
  int max;

  IntegerTextInputFormatter({this.min, this.max});

  @override TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
     return _checkIntegerValue(newValue.text) ? newValue : oldValue;
  }

  bool _checkIntegerValue(String value) {
    if (min != null && min >= 0 && value == '-')
      return false;

    if (value == '' || value == '-')
      return true;

    var _newInt = int.tryParse(value);
    if (_newInt == null)
      return false;

    if (min != null && _newInt < min)
      return false;

    if (max != null && _newInt > max)
      return false;

    return true;
  }
}