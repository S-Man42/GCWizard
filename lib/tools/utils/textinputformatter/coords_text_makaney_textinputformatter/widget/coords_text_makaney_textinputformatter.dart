import 'package:flutter/services.dart';

class CoordsTextMakaneyTextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  CoordsTextMakaneyTextInputFormatter() {
    _exp = new RegExp('^[\-\+abo2zptscjkwmgnxqfd984ery3h5l76ui]*\$');
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text.toLowerCase())) {
      return newValue;
    }

    return oldValue;
  }
}
