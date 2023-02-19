import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';

void main() {
  group("Vanity.encryptVanitySingleNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCXYZ', 'expectedOutput' : '222999'},
      {'input' : 'AbcxyZ', 'expectedOutput' : '222999'},
      {'input' : 'ABC123XYZ', 'expectedOutput' : '222123999'},
      {'input' : 'ÄÖÜß', 'expectedOutput' : '2687'},
      {'input' : '*%&/', 'expectedOutput' : '*%&/'},
      {'input' : 'ABC*%&/', 'expectedOutput' : '222*%&/'},

      {'input' : ' ', 'numberForSpace': '1', 'expectedOutput' : '1'},
      {'input' : ' ', 'numberForSpace': '0', 'expectedOutput' : '0'},
      {'input' : ' ', 'numberForSpace': null, 'expectedOutput' : ' '},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, numberForSpace: ${elem['numberForSpace']}', () {
        var _actual = encryptVanitySingleNumbers(elem['input'], numberForSpace: elem['numberForSpace']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Vanity.encodeVanityMultipleNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCXYZ', 'expectedOutput' : '2 22 222 99 999 9999'},
      {'input' : 'AbcxyZ', 'expectedOutput' : '2 22 222 99 999 9999'},
      {'input' : 'ABC123XYZ', 'expectedOutput' : '2 22 222 1 2222 3333 99 999 9999'},
      {'input' : 'ÄÖÜß', 'expectedOutput' : '2 666 88 7777'},
      {'input' : '*%&/', 'expectedOutput' : '* % & /'},
      {'input' : 'ABC*%&/', 'expectedOutput' : '2 22 222 * % & /'},

      {'input' : ' ', 'numberForSpace': '1', 'expectedOutput' : '1'},
      {'input' : ' ', 'numberForSpace': '0', 'expectedOutput' : '0'},
      {'input' : ' ', 'numberForSpace': null, 'expectedOutput' : ' '},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, numberForSpace: ${elem['numberForSpace']}', () {
        var _actual = encodeVanityMultipleNumbers(elem['input'], numberForSpace: elem['numberForSpace']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Vanity.decodeVanityMultipleNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : 'ABCXYZ', 'input' : '2 22 222 99 999 9999'},
      {'expectedOutput' : 'ABCXYZ', 'input' : '2 22 222 99 999 9999'},
      {'expectedOutput' : 'ABC123XYZ', 'input' : '2 22 222 1 2222 3333 99 999 9999'},
      {'expectedOutput' : 'AOUS', 'input' : '2 666 88 7777'},
      {'expectedOutput' : '', 'input' : '*%&/'},
      {'expectedOutput' : 'ABC', 'input' : '2 22 222 * % & /'},
      {'expectedOutput' : 'B<?>A', 'input' : '22 222222 2'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeVanityMultipleNumbers(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}