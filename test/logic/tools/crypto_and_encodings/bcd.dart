import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bcd.dart';

void main() {

  // Original ---------------------------------------------------------------------

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

      {'expectedOutput' : '1968', 'input' : '0001 1001 0110 1000'},
      {'expectedOutput' : '22', 'input' : '0010 0010'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = BCDdecodeOriginal(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


  // Aiken ---------------------------------------------------------------------

  group("BCD.encodeAiken", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '0001 1111 1100 1110'},
      {'input' : '2ab2', 'expectedOutput' : '0010 0010'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = BCDencodeAiken(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeAiken:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'input' : '0001 1111 1100 1110'},
      {'expectedOutput' : '22', 'input' : '0010 0010'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = BCDdecodeAiken(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


  // Libaw-Craig ---------------------------------------------------------------

  group("BCD.encodeLibawCraig", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '00001 10000 11110 11000'},
      {'input' : '2ab2', 'expectedOutput' : '00011 00011'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = BCDencodeLibawCraig(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeLibawCraig:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'input' : '00001 10000 11110 11000'},
      {'expectedOutput' : '22', 'input' : '00011 00011'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = BCDdecodeLibawCraig(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


  // Stibitz -------------------------------------------------------------------

  group("BCD.encodeStibitz", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '0100 1100 1001 1011'},
      {'input' : '2ab2', 'expectedOutput' : '0101 0101'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = BCDencodeStibitz(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeStibitz:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'input' : '0100 1100 1001 1011'},
      {'expectedOutput' : '22', 'input' : '0101 0101'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = BCDdecodeStibitz(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group

}