import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';

void main() {
  group("Vanity.encryptVanitySingleNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCXYZ', 'model': SIEMENS, 'expectedOutput' : '222999'},
      {'input' : 'AbcxyZ', 'model': SIEMENS, 'expectedOutput' : '222999'},
      {'input' : 'ABC123XYZ', 'model': SIEMENS, 'expectedOutput' : '222123999'},
      {'input' : 'ÄÖÜß', 'model': SIEMENS, 'expectedOutput' : '2687'},
      {'input' : '*%&/', 'model': SIEMENS, 'expectedOutput' : ''},
      {'input' : 'ABC*%&/', 'model': SIEMENS, 'expectedOutput' : '222'},

      {'input' : 'ABC01 .?\$&°', 'model': NOKIA, 'expectedOutput' : '222010117*'},
      {'input' : 'ABC01 .?\$&°', 'model': SAMSUNG, 'expectedOutput' : '22201011**'},
      {'input' : 'ABC01 .?\$&°', 'model': SIEMENS, 'expectedOutput' : '222011001'},
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

      {'input' : 'ABCXYZ', 'model': SIEMENS, 'expectedOutput' : '2 22 222 99 999 9999'},
      {'input' : 'Abc xyZ', 'model': SIEMENS, 'expectedOutput' : '2 22 222 1 99 999 9999'},
      {'input' : 'ABC123XYZ', 'model': SIEMENS, 'expectedOutput' : '2 22 222 11 2222 3333 99 999 9999'},
      {'input' : 'ÄÖÜß', 'model': SIEMENS, 'expectedOutput' : '22222 66666 88888 777777'},
      {'input' : '*%&/', 'model': SIEMENS, 'expectedOutput' : ''},
      {'input' : 'ABC*%&/+', 'model': SIEMENS, 'expectedOutput' : '2 22 222 000000'},
      {'input' : '. ', 'model': SIEMENS, 'expectedOutput' : '0 1'},

      {'input' : 'ABC01 .?\$&°', 'model': NOKIA, 'expectedOutput' : '2 22 222 00 1111111 0 1 111 7777777 ****************'},
      {'input' : 'ABC01 .?\$&°', 'model': SAMSUNG, 'expectedOutput' : '2 22 222 00 11111 0 1 111 **************************** ***********'},
      {'input' : 'ABC01 .?\$&°', 'model': SIEMENS, 'expectedOutput' : '2 22 222 00000 11 1 0 000 11111'},
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

      {'expectedOutput' : 'abcxyz', 'model': SIEMENS, 'input' : '2 22 222 99 999 9999'},
      {'expectedOutput' : 'abcxyz', 'model': SIEMENS, 'input' : '2 22 222 99 999 9999'},
      {'expectedOutput' : 'abc123xyz', 'model': SIEMENS, 'input' : '2 22 222 11 2222 3333 99 999 9999'},
      {'expectedOutput' : 'aous', 'model': SIEMENS, 'input' : '2 666 88 7777'},
      {'expectedOutput' : 'ba€a+', 'model': SIEMENS, 'input' : '22 2222222222 11111111111111111 2 000000'},
      {'expectedOutput' : '. ', 'model': SIEMENS, 'input' : '0 1'},

      {'expectedOutput' : 'bcx', 'model': SIEMENS, 'input' : '22 abc 222   99'},
      {'expectedOutput' : '<?>cx<?>', 'model': SIEMENS, 'input' : '2233 abc 222   99 97'},

      {'expectedOutput' : 'abc01 .?\$&', 'model': NOKIA, 'input' : '2 22 222 00 1111111 0 1 111 7777777 ****************'},
      {'expectedOutput' : 'abc01 .?\$&', 'model': SAMSUNG, 'input' : '2 22 222 00 11111 0 1 111 **************************** ***********'},
      {'expectedOutput' : 'abc01 .?\$', 'model': SIEMENS, 'input' : '2 22 222 00000 11 1 0 000 11111'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, model: ${elem['model']}', () {
        var _actual = decodeVanityMultipleNumbers(elem['input'], elem['model']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}