import 'package:flutter/services.dart';

final RegExp VARIABLESTRING_VARIABLE = RegExp(r'^((\d+(\-(\d*|\d+#\d*))?),)*(\d*|(\d+\-(\d*|\d+#\d*)))$');

class VariableStringTextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  VariableStringTextInputFormatter() {
    _exp = VARIABLESTRING_VARIABLE;
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_exp.hasMatch(newValue.text.toLowerCase())) {
      return newValue;
    }

    return oldValue;
  }
}
