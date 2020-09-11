import 'package:gc_wizard/logic/tools/crypto_and_encodings/roman_numbers.dart';

// the same like roman_numbers.dart
final _romanToNumber = {'M': 1000, 'D': 500, 'C': 100, 'L': 50, 'X': 10, 'V': 5, 'I': 1};

int decodeChronogram(String input, bool withJU) {
  if (input == null)
    return null;

  String _sortedChars = '';

  input = input.toUpperCase();
  if (withJU)  {
    input = input.replaceAll(RegExp(r'[J]'), 'I');
    input = input.replaceAll(RegExp(r'[U]'), 'V');
  }

  // disregarded the Roman rule of subtraction and simply added the numerical values
  _romanToNumber.keys.forEach((romanChar) {
    input.split('').forEach((character) {
      if (character == romanChar)
        _sortedChars += character;
    });
  });

  return decodeRomanNumbers(_sortedChars);
}