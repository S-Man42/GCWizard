import 'package:gc_wizard/logic/tools/crypto_and_encodings/roman_numbers/roman_numbers.dart';

int decodeChronogram(String input, {bool JUToIV: false, YToII: false, WToVV: false}) {
  if (input == null || input.length == 0)
    return null;

  input = input.toUpperCase();
  if (JUToIV) {
    input = input.replaceAll('J', 'I');
    input = input.replaceAll('U', 'V');
  }
  if (YToII) {
    input = input.replaceAll('Y', 'II');
  }
  if (WToVV) {
    input = input.replaceAll('W', 'VV');
  }

  return decodeRomanNumbers(input, type: RomanNumberType.ONLY_ADDITION);
}