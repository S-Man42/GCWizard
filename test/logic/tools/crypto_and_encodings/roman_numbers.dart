import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/roman_numbers.dart';

void main() {
  group("RomanNumbers.encodeRomanNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : -1, 'expectedOutput' : ''},
      {'input' : 0, 'expectedOutput' : ''},

      {'input' : 1, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'I'},
      {'input' : 2, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'II'},
      {'input' : 3, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'III'},
      {'input' : 4, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'IV'},
      {'input' : 5, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'V'},
      {'input' : 6, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'VI'},
      {'input' : 7, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'VII'},
      {'input' : 8, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'VIII'},
      {'input' : 9, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'IX'},
      {'input' : 10, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'X'},
      {'input' : 11, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XI'},
      {'input' : 14, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XIV'},
      {'input' : 15, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XV'},
      {'input' : 19, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XIX'},
      {'input' : 20, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XX'},
      {'input' : 24, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XXIV'},
      {'input' : 25, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XXV'},
      {'input' : 49, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XLIX'},
      {'input' : 50, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'L'},
      {'input' : 88, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'LXXXVIII'},
      {'input' : 99, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'XCIX'},
      {'input' : 100, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'C'},
      {'input' : 400, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'CD'},
      {'input' : 444, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'CDXLIV'},
      {'input' : 500, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'D'},
      {'input' : 1000, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'M'},
      {'input' : 3888, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'MMMDCCCLXXXVIII'},
      {'input' : 3999, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'MMMCMXCIX'},
      {'input' : 5111, 'type': RomanNumberType.USE_SUBTRACTION_RULE, 'expectedOutput' : 'MMMMMCXI'},

      {'input' : 1, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'I'},
      {'input' : 2, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'II'},
      {'input' : 3, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'III'},
      {'input' : 4, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'IIII'},
      {'input' : 5, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'V'},
      {'input' : 6, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'VI'},
      {'input' : 7, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'VII'},
      {'input' : 8, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'VIII'},
      {'input' : 9, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'VIIII'},
      {'input' : 10, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'X'},
      {'input' : 11, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'XI'},
      {'input' : 14, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'XIIII'},
      {'input' : 15, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'XV'},
      {'input' : 19, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'XVIIII'},
      {'input' : 20, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'XX'},
      {'input' : 24, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'XXIIII'},
      {'input' : 25, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'XXV'},
      {'input' : 49, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'XXXXVIIII'},
      {'input' : 50, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'L'},
      {'input' : 88, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'LXXXVIII'},
      {'input' : 99, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'LXXXXVIIII'},
      {'input' : 100, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'C'},
      {'input' : 400, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'CCCC'},
      {'input' : 444, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'CCCCXXXXIIII'},
      {'input' : 500, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'D'},
      {'input' : 1000, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'M'},
      {'input' : 3888, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'MMMDCCCLXXXVIII'},
      {'input' : 3999, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'MMMDCCCCLXXXXVIIII'},
      {'input' : 5111, 'type': RomanNumberType.ONLY_ADDITION, 'expectedOutput' : 'MMMMMCXI'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, type: ${elem['type']}', () {
        var _actual = encodeRomanNumbers(elem['input'], type: elem['type']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("RomanNumbers.decodeRomanNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '', 'expectedOutput' : null},
      {'input' : 'Ab', 'expectedOutput' : null},
      {'input' : 'AbI', 'expectedOutput' : 1},
      {'input' : 'AbMI', 'expectedOutput' : 1001},

      {'expectedOutput' : 1, 'input' : 'I'},
      {'expectedOutput' : 2, 'input' : 'ii'},
      {'expectedOutput' : 3, 'input' : 'IiI'},
      {'expectedOutput' : 4, 'input' : 'IV'},
      {'expectedOutput' : 5, 'input' : 'V'},
      {'expectedOutput' : 6, 'input' : 'VI'},
      {'expectedOutput' : 7, 'input' : 'viI'},
      {'expectedOutput' : 8, 'input' : 'VIII'},
      {'expectedOutput' : 9, 'input' : 'IX'},
      {'expectedOutput' : 10, 'input' : 'X'},
      {'expectedOutput' : 11, 'input' : 'XI'},
      {'expectedOutput' : 14, 'input' : 'XIV'},
      {'expectedOutput' : 15, 'input' : 'XV'},
      {'expectedOutput' : 19, 'input' : 'XIX'},
      {'expectedOutput' : 20, 'input' : 'XX'},
      {'expectedOutput' : 24, 'input' : 'xxiv'},
      {'expectedOutput' : 25, 'input' : 'XXV'},
      {'expectedOutput' : 49, 'input' : 'XLIX'},
      {'expectedOutput' : 50, 'input' : 'L'},
      {'expectedOutput' : 88, 'input' : 'LXXXVIII'},
      {'expectedOutput' : 99, 'input' : 'XCIX'},
      {'expectedOutput' : 100, 'input' : 'C'},
      {'expectedOutput' : 400, 'input' : 'CD'},
      {'expectedOutput' : 444, 'input' : 'CDXLIV'},
      {'expectedOutput' : 500, 'input' : 'D'},
      {'expectedOutput' : 1000, 'input' : 'M'},
      {'expectedOutput' : 3888, 'input' : 'MMMDCCCLXXXVIII'},
      {'expectedOutput' : 3999, 'input' : 'MMMCMXCIX'},
      {'expectedOutput' : 5111, 'input' : 'MMMMMCXI'},

      {'expectedOutput' : 4, 'input' : 'iiii'},
      {'expectedOutput' : 9, 'input' : 'VIIII'},
      {'expectedOutput' : 14, 'input' : 'XIIII'},
      {'expectedOutput' : 19, 'input' : 'XVIIII'},
      {'expectedOutput' : 24, 'input' : 'XXIIII'},
      {'expectedOutput' : 49, 'input' : 'XXXXVIIII'},
      {'expectedOutput' : 99, 'input' : 'LXXXXVIIII'},
      {'expectedOutput' : 400, 'input' : 'CCCC'},
      {'expectedOutput' : 444, 'input' : 'CCCCXXxxiiII'},
      {'expectedOutput' : 3999, 'input' : 'MMMDCCCCLXXXXVIIII'},

      //wrong input -> simple addition
      {'expectedOutput' : 1001, 'input' : 'IM'},
      {'expectedOutput' : 511, 'input' : 'XDI'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeRomanNumbers(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}