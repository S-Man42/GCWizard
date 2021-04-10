import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';

void main() {
  group("Vanity.encryptVanitySingleNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCXYZ', 'model': SIEMENS_ME45, 'expectedOutput' : '222999'},
      {'input' : 'AbcxyZ', 'model': SIEMENS_ME45, 'expectedOutput' : '222999'},
      {'input' : 'ABC123XYZ', 'model': SIEMENS_ME45, 'expectedOutput' : '222123999'},
      {'input' : 'ÄÖÜß', 'model': SIEMENS_ME45, 'expectedOutput' : '2687'},
      {'input' : '*%&/', 'model': SIEMENS_ME45, 'expectedOutput' : ''},
      {'input' : 'ABC*%&/', 'model': SIEMENS_ME45, 'expectedOutput' : '222'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, model: ${elem['model']}', () {
        var _actual = encodeVanitySingleNumbers(elem['input'], elem['model']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Vanity.encodeVanityMultipleNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCXYZ', 'model': SIEMENS_ME45, 'expectedOutput' : '2 22 222 99 999 9999'},
      {'input' : 'Abc xyZ', 'model': SIEMENS_ME45, 'expectedOutput' : '2 22 222 1 99 999 9999'},
      {'input' : 'ABC123XYZ', 'model': SIEMENS_ME45, 'expectedOutput' : '2 22 222 11 2222 3333 99 999 9999'},
      {'input' : 'ÄÖÜß', 'model': SIEMENS_ME45, 'expectedOutput' : '22222 66666 88888 777777'},
      {'input' : '*%&/', 'model': SIEMENS_ME45, 'expectedOutput' : ''},
      {'input' : 'ABC*%&/+', 'model': SIEMENS_ME45, 'expectedOutput' : '2 22 222 000000'},
      {'input' : '. ', 'model': SIEMENS_ME45, 'expectedOutput' : '0 1'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, model: ${elem['model']}', () {
        var _actual = encodeVanityMultipleNumbers(elem['input'], elem['model']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Vanity.decodeVanityMultipleNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : 'ABCXYZ', 'model': SIEMENS_ME45, 'input' : '2 22 222 99 999 9999'},
      {'expectedOutput' : 'ABCXYZ', 'model': SIEMENS_ME45, 'input' : '2 22 222 99 999 9999'},
      {'expectedOutput' : 'ABC123XYZ', 'model': SIEMENS_ME45, 'input' : '2 22 222 11 2222 3333 99 999 9999'},
      {'expectedOutput' : 'AOUS', 'model': SIEMENS_ME45, 'input' : '2 666 88 7777'},
      {'expectedOutput' : 'B<?>A+', 'model': SIEMENS_ME45, 'input' : '22 2222222222 2 000000'},
      {'expectedOutput' : '. ', 'model': SIEMENS_ME45, 'input' : '0 1'},

      {'expectedOutput' : 'BCX', 'model': SIEMENS_ME45, 'input' : '22 abc 222   99'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, model: ${elem['model']}', () {
        var _actual = decodeVanityMultipleNumbers(elem['input'], elem['model']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}