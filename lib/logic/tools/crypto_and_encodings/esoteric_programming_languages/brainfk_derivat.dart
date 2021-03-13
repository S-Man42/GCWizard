import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/utils/common_utils.dart';

class BrainfkDerivat {
  Map<String, String> substitutions;

  BrainfkDerivat(
      {pointerShiftLeftInstruction,
      pointerShiftRightInstruction,
      decreaseValueInstruction,
      increaseValueInstruction,
      startLoopInstruction,
      endLoopInstruction,
      inputInstruction,
      outputInstruction}) {
    substitutions = {
      pointerShiftLeftInstruction: '<',
      pointerShiftRightInstruction: '>',
      decreaseValueInstruction: '-',
      increaseValueInstruction: '+',
      startLoopInstruction: '[',
      endLoopInstruction: ']',
      inputInstruction: ',',
      outputInstruction: '.'
    };
  }

  String interpretBrainfkDerivat(String code, {String input}) {
    if (code == null || code.length == 0) return '';

    var brainfk = '';
    while (code.length > 0) {
      var chunk = '';
      var i = 0;
      while (substitutions[chunk] == null && i < code.length) {
        i++;
        chunk = code.substring(0, min(i, code.length));
      }

      try {
        brainfk += substitutions[chunk];
      } catch (e) {} //if there is no fitting substitution, ignore it.

      code = code.substring(min(i, code.length));
    }

    return interpretBrainfk(brainfk, input: input);
  }

  String generateBrainfkDerivat(String text) {
    if (text == null || text.length == 0) return '';

    var brainfk = generateBrainfk(text);
    return substitution(brainfk, switchMapKeyValue(substitutions));
  }
}
