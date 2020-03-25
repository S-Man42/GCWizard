import 'package:flutter/services.dart';
import 'package:gc_wizard/utils/common_utils.dart';

class IntegerTextInputFormatter extends TextInputFormatter {
  bool allowNegativeValues;
  bool allowNumberList;

  IntegerTextInputFormatter({this.allowNegativeValues: false, this.allowNumberList: false});

  @override TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    
      final String newText = newValue.text ?? '';
      final oldSelectionIndex = oldValue.selection.end ?? 0;
      final newSelectionIndex = newValue.selection.end ?? 0;

      String adaptedText = sanitizeIntegerString(newText, allowNegativeValues, allowNumberList);

      int adaptedSelectionIndex;
      
      if (newSelectionIndex > adaptedText.length) {
        adaptedSelectionIndex = adaptedText.length;
      } else {
        if (newSelectionIndex > oldSelectionIndex) {
          if (adaptedText.length < newText.length ) {
            adaptedSelectionIndex = oldSelectionIndex;
          } else {
            adaptedSelectionIndex = newSelectionIndex;
          }
        } else {
          adaptedSelectionIndex = newSelectionIndex;
        }
      }
      
      return newValue.copyWith(text: adaptedText, selection: TextSelection.fromPosition(TextPosition(offset: adaptedSelectionIndex)));
  }
}