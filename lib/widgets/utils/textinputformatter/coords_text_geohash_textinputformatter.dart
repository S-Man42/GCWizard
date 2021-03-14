import 'package:flutter/services.dart';

class CoordsTextGeohashTextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  CoordsTextGeohashTextInputFormatter() {
    _exp = new RegExp('^[0-9bcdefghjkmnpqrstuvwxyz]*\$');
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text.toLowerCase())) {
      return newValue;
    }

    return oldValue;
  }
}
