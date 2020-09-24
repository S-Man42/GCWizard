import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/enclosed_areas.dart';

void main() {
  group("EnclosedAreas.with4:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCDEFGHIJKLMOPQRSTUVWXYZÄÖÜß', 'expectedOutput' : '10'},
      {'input' : 'abcdefghijklmopqrstuvwxyzäöüß', 'expectedOutput' : '8'},
      {'input' : '0123456789', 'expectedOutput' : '6'},
      {'input' : 'ABCDEFGHIJKLMOPQRSTUVWXYZÄÖÜß 0123456789', 'expectedOutput' : '10 6'},
      {'input' : '._*&%><', 'expectedOutput' : '4'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeEnclosedAreas(elem['input'], true);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("EnclosedAreas.without4:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCDEFGHIJKLMOPQRSTUVWXYZÄÖÜß', 'expectedOutput' : '10'},
      {'input' : 'abcdefghijklmopqrstuvwxyzäöüß', 'expectedOutput' : '8'},
      {'input' : '0123456789', 'expectedOutput' : '5'},
      {'input' : 'ABCDEFGHIJKLMOPQRSTUVWXYZÄÖÜß 0123456789', 'expectedOutput' : '10 5'},
      {'input' : '._*&%><', 'expectedOutput' : '4'},
   ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeEnclosedAreas(elem['input'], false);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
