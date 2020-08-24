import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// Wrapper for currently (2020/08) buggy external MaskTextInputFormatter
class WrapperForMaskTextInputFormatter extends TextInputFormatter {
  String mask;
  Map<String, RegExp> filter;

  MaskTextInputFormatter _formatter;
  WrapperForMaskTextInputFormatter({this.mask, this.filter}) {
    reinitialize();
  }

  String getMaskedText() {
    return _formatter.getMaskedText();
  }

  void reinitialize() {
    _formatter = MaskTextInputFormatter(
      mask: mask,
      filter: filter
    );
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return _formatter.formatEditUpdate(oldValue, newValue);
  }
}