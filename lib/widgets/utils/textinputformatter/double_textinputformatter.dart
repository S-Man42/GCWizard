import 'package:flutter/services.dart';

class DoubleTextInputFormatter extends TextInputFormatter {
  RegExp _exp;

  DoubleTextInputFormatter({bool allowNegativeValues: true, int decimalRange}) {
    var _decimalPart = '[.,][0-9]${decimalRange == null ? '*' : '{0,$decimalRange}'}';
    var _signedPart = allowNegativeValues ? '-?' : '';
    var _integerPart = '$_signedPart[0-9]*';

    _exp = new RegExp('^$_integerPart($_decimalPart)?\$');
  }

  @override TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(_exp.hasMatch(newValue.text)){
      return newValue;
    }

    return oldValue;
  }
}