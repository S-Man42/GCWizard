import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/hohoho.dart';

void main() {
  group("Hohoho.interpretHohoho:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'code' : null, 'expectedOutput' : ''},
      {'code' : '', 'expectedOutput' : ''},
      {'code' : 'ABC123;', 'expectedOutput' : ''},
      {'code' : '++', 'expectedOutput' : ''},

      // https://www.geocaching.com/geocache/GC9GFQM_hohoho
      {'code' : 'Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Ho! Hohoho! Ho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohohohohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohohohohohohohohohohohohohohohohohohohoho! Hohohohohoho! Hohohohohoho! Hoho! Ho! Ho! Hoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hoho! Ho! Ho! Hoho! Hohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohoho! Ho! Ho!',
        'expectedOutput' : '42710/05659'},
      // https://hohoho.jakobsenkl.pw/
      {'code' : 'Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Ho! Hohoho! Ho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohohohohohohohohohohohohohohohohohohohohohohohohohoho! Hohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Ho! Hohoho! Ho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hohohohohohohohohohohohohohohohohohohohohohohohohohohohohoho! Ho! Hohoho! Ho! Ho! Hohohohohohohohohohohohohohohohohohohohohohohohohohoho! Hohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Ho! Hohoho! Ho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hohohohohohohohohohohoho! Ho! Hohoho! Ho! Ho! Hohohohohohohohoho! Hohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hohohohohohohohohohohoho! Ho! Hohoho! Ho! Ho! Hohohohohohohohohohohoho! Hohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Ho! Hohoho! Ho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohoho! Ho! Ho!',
        'expectedOutput' : 'merry xmas'},

    ];

    _inputsToExpected.forEach((elem) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = interpretHohoho(elem['code'], STDIN: elem['input']).output;
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Hohoho.generateHohoho:", () {
    List<Map<String, dynamic>> _inputsToExpected = [

      {'expectedOutput' : 'Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohohohohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohohohohohohohohohohohohohohohohohohohoho! Hohohohohoho! Hohohohohoho! Hoho! Ho! Ho! Hoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hoho! Ho! Ho! Hoho! Hohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hoho!',
        'OutputText' : '42710/05659'},

      {'expectedOutput' : 'Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Hohohohohohohohohohohohoho! Ho! Hohohohohohoho! Hoho! Ho! Hoho! Hoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohohoho! Hoho! Ho! Ho! Ho! Ho! Hoho! Hohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Hohohohohohohohohohohohohohohohohohohohohohohohohohohoho! Ho! Hohohohohohoho! Hoho! Ho! Hohohohohohohohohohohohohohohohohohohohohohohohohoho! Hoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Hohohohohohohohohoho! Ho! Hohohohohohoho! Hoho! Ho! Hohohohohohohoho! Hoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Hohohohohohohohohohohohoho! Ho! Hohohohohohoho! Hoho! Ho! Hoho! Hoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hoho!',
        'OutputText' : 'merry xmas'},

    ];

    _inputsToExpected.forEach((elem) {
      test('OutputText: ${elem['OutputText']}}', () {
        var _actual = generateHohoho(elem['OutputText']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}