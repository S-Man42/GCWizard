import 'package:flutter/services.dart';

class CoordsTextVariableCoordinateTextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  CoordsTextVariableCoordinateTextInputFormatter() {
    _exp = new RegExp(r'^((\d+(\-(\d*|\d+#\d*))?),)*(\d*|(\d+\-(\d*|\d+#\d*)))$');
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text.toLowerCase())) {
      return newValue;
    }

    return oldValue;
  }
}
