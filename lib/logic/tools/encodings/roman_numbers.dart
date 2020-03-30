import 'package:gc_wizard/logic/tools/crypto/substitution.dart';
import 'package:gc_wizard/utils/common_utils.dart';

enum RomanNumberType {
  ONLY_ADDITION,
  USE_SUBTRACTION_RULE //default
}

final _romanToNumber = {'M': 1000, 'D': 500, 'C': 100, 'L': 50, 'X': 10, 'V': 5, 'I': 1};
final _subtractionSubstitutions = {'DCCCC': 'CM', 'CCCC': 'CD', 'LXXXX': 'XC', 'XXXX': 'XL', 'VIIII': 'IX', 'IIII': 'IV'};

String encodeRomanNumbers(int number, {var type: RomanNumberType.USE_SUBTRACTION_RULE}) {
  if (number == null)
    return '';

  if (number < 1)
    return '';

  var out = '';
  var remaining = number;
  _romanToNumber.entries.forEach((value) {
    while (remaining >= value.value) {
      out += value.key;
      remaining -= value.value;
    }
  });

  if (type == RomanNumberType.USE_SUBTRACTION_RULE) {
    out = substitution(out, _subtractionSubstitutions);
  }

  return out;
}

int decodeRomanNumbers(String input) {
  if (input == null)
    return null;

  input = input.toUpperCase().replaceAll(RegExp(r'[^MDCLXVI]'), '');
  if (input.length == 0)
    return null;

  var roman = substitution(input, switchMapKeyValue(_subtractionSubstitutions));
  var out = 0;
  roman.split('').forEach((character) => out += _romanToNumber[character]);

  return out;
}