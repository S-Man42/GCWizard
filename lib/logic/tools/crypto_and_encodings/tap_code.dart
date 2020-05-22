import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';

enum TapCodeMode {JToI, CToK}
const TAPCODE_KEY = '12345';

_generateAlphabet(mode) {
  var alphabet = alphabet_AZString;

  switch (mode) {
    case TapCodeMode.JToI:
      return alphabet.replaceFirst('J', '');
    case TapCodeMode.CToK:
      alphabet = alphabet.replaceFirst('K', '');
      return alphabet.replaceFirst('C', 'K');
  }
}

String encryptTapCode(String input, {TapCodeMode mode: TapCodeMode.JToI}) {
  if (input == null || input.length == 0)
    return '';

  input = removeAccents(input.toUpperCase());
  input = input.replaceAll(RegExp(r'[^A-Z]'), '');

  switch (mode) {
    case TapCodeMode.JToI:
      input = input.replaceAll('I', 'J');
      break;
    case TapCodeMode.CToK:
      input = input.replaceAll('C', 'K');
      break;
  }

  return encryptPolybios(input, TAPCODE_KEY, mode: PolybiosMode.CUSTOM, alphabet: _generateAlphabet(mode)).output;
}

String decryptTapCode(String input, {mode: TapCodeMode.JToI}) {
  var output = decryptPolybios(input, TAPCODE_KEY, mode: PolybiosMode.CUSTOM, alphabet: _generateAlphabet(mode));
  if (output == null)
    return '';

  return output.output;
}