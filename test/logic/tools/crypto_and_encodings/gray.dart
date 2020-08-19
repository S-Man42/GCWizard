import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gray.dart';

void main() {

  group("gray.encryptGray", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '99', 'mode': GrayMode.Decimal,'expectedOutput' : '82'},
      {'input' : '4', 'mode': GrayMode.Decimal,'expectedOutput' : '6'},
      {'input' : '1100011', 'mode': GrayMode.Binary,'expectedOutput' : '1010010'},
      {'input' : '100', 'mode': GrayMode.Binary,'expectedOutput' : '110'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encryptGray(elem['input'], mode: elem['mode']);
        if (elem['mode'] == GrayMode.Decimal)
          expect(_actual.output_gray_decimal, elem['expectedOutput']);
        else
          expect(_actual.output_gray_binary, elem['expectedOutput']);
      });
    });
  });

  group("gray.decryptGray:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'expectedOutput' : '99', 'mode': GrayMode.Decimal,'input' : '82'},
      {'expectedOutput' : '4', 'mode': GrayMode.Decimal,'input' : '6'},
      {'expectedOutput' : '1100011', 'mode': GrayMode.Binary,'input' : '1010010'},
      {'expectedOutput' : '100', 'mode': GrayMode.Binary,'input' : '110'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decryptGray(elem['input'], mode: elem['mode']);
        if (elem['mode'] == GrayMode.Decimal)
          expect(_actual.output_gray_decimal, elem['expectedOutput']);
        else
          expect(_actual.output_gray_binary, elem['expectedOutput']);
      });
    });
  }); // group


}