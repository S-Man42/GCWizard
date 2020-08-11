import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bcd.dart';

void main() {
  group("BCD.encodeOriginal", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '0001 1001 0110 1000'},
      {'input' : '2ab2', 'expectedOutput' : '0010 0010'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = BCDencodeOriginal(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeOriginal:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '19 68', 'input' : '0001 1001 0110 1000'},
      {'expectedOutput' : '2ab2', 'input' : '0010 0010'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeMorse(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}