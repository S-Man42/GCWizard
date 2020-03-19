import 'package:flutter/services.dart';

class IntegerTextInputFormatter extends TextInputFormatter {
  bool allowNumberList;
  int min;
  int max;

  IntegerTextInputFormatter({this.allowNumberList: false, this.min, this.max});

  @override TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (allowNumberList) {
      var regex = (min == null || min < 0) ? RegExp(r'[^\-0-9]') : RegExp(r'[^0-9]');

      newValue.text.split(regex).forEach((value) {
        if (!_checkIntegerValue(newValue.text))
          return oldValue;
      });

      return newValue;

    } else {
      return _checkIntegerValue(newValue.text) ? newValue : oldValue;
    }
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