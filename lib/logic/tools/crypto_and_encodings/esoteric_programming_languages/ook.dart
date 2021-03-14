import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_derivat.dart';

final ook = BrainfkDerivat(
    pointerShiftLeftInstruction: '.?',
    pointerShiftRightInstruction: '?.',
    decreaseValueInstruction: '!!',
    increaseValueInstruction: '..',
    startLoopInstruction: '!?',
    endLoopInstruction: '?!',
    inputInstruction: '.!',
    outputInstruction: '!.');

String interpretOok(String code, {String input}) {
  if (code == null || code.length == 0) return '';

  code = code.replaceAll(RegExp(r'[^\.!\?]'), '');
  return ook.interpretBrainfkDerivat(code, input: input);
}

String generateOok(String text) {
  if (text == null || text.length == 0) return '';

  var code = ook.generateBrainfkDerivat(text);
  return 'Ook' + code.split('').join(' Ook');
}
