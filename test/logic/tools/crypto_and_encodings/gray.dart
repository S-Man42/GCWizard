import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gray.dart';

void main() {

  group("gray.encodeOriginal", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'mode': GrayMode.Decimal, 'expectedOutput' : ''},
      {'input' : '', 'mode': GrayMode.Decimal,'expectedOutput' : ''},

      {'input' : '19 68', 'mode': GrayMode.Decimal,'expectedOutput' : '0001 1001 0110 1000'},
      {'input' : '2ab2', 'mode': GrayMode.Decimal,'expectedOutput' : '0010 0010'},
      {'input' : 'Haus', 'mode': GrayMode.Decimal,'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encryptGray(elem['input'], mode: elem['mode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeOriginal:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'mode': GrayMode.Decimal, 'expectedOutput' : ''},
      {'input' : '', 'mode': GrayMode.Decimal,'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'mode': GrayMode.Decimal,'input' : '0001 1001 0110 1000'},
      {'expectedOutput' : '22', 'mode': GrayMode.Decimal, 'input' : '0010 0010'},
      {'expectedOutput' : '', 'mode': GrayMode.Decimal,'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decryptGray(elem['input'], mode: elem['mode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


}