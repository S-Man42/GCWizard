import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bacon.dart';

void main() {
  group("Bacon.encodeBacon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'AZ', 'expectedOutput' : 'AAAAABABBB'},
      {'input' : 'Az', 'expectedOutput' : 'AAAAABABBB'},
      {'input' : 'UV', 'expectedOutput' : 'BAABBBAABB'},
      {'input' : 'IJ', 'expectedOutput' : 'ABAAAABAAA'},
      {'input' : ' A_12Z%', 'expectedOutput' : 'AAAAABABBB'}
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBacon(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Bacon.decodeBacon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : 'AZ', 'input' : 'AAAAABABBB'},
      {'expectedOutput' : 'AZ', 'input' : 'AAAAABABBBA'},
      {'expectedOutput' : 'AZ', 'input' : 'AAAAABABBBAA'},
      {'expectedOutput' : 'AZ', 'input' : 'AAAAABABBBAAA'},
      {'expectedOutput' : 'AZ', 'input' : 'AAAAABABBBAAAA'},
      {'expectedOutput' : 'AZA', 'input' : 'AAAAABABBBAAAAA'},
      {'expectedOutput' : 'AZ', 'input' : 'zAAAaa BABBB2'},
      {'expectedOutput' : 'UU', 'input' : 'BAABBBAABB'},
      {'expectedOutput' : 'II', 'input' : 'ABAAAABAAA'},
      {'expectedOutput' : '', 'input' : 'BBBBB'},
      {'expectedOutput' : '', 'input' : 'BBBA'},
      {'expectedOutput' : '', 'input' : 'BBBBBbbbbbBBBA'},
      {'expectedOutput' : '', 'input' : 'BBBBB bbbbb BBBA'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBacon(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
