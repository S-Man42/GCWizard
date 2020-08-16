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
        var _actual = encodeBCD(elem['input'], BCDType.ORIGINAL);
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
        var _actual = decodeBCD(elem['input'], BCDType.ORIGINAL);
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
        var _actual = encodeBCD(elem['input'], BCDType.AIKEN);
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
        var _actual = decodeBCD(elem['input'], BCDType.AIKEN);
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
        var _actual = encodeBCD(elem['input'], BCDType.LIBAWCRAIG);
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
        var _actual = decodeBCD(elem['input'], BCDType.LIBAWCRAIG);
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
        var _actual = encodeBCD(elem['input'], BCDType.STIBITZ);
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
        var _actual = decodeBCD(elem['input'], BCDType.STIBITZ);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


  // Gray -------------------------------------------------------------------

  group("BCD.encodeGray", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '0001 1101 0101 1100'},
      {'input' : '2ab2', 'expectedOutput' : '0011 0011'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBCD(elem['input'], BCDType.GRAY);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeGray:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'input' : '0001 1101 0101 1100'},
      {'expectedOutput' : '22', 'input' : '0011 0011'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBCD(elem['input'], BCDType.GRAY);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


  // Glixon -------------------------------------------------------------------

  group("BCD.encodeGlixon", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '0001 1000 0101 1100'},
      {'input' : '2ab2', 'expectedOutput' : '0011 0011'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBCD(elem['input'], BCDType.GLIXON);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeGlixon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'input' : '0001 1000 0101 1100'},
      {'expectedOutput' : '22', 'input' : '0011 0011'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBCD(elem['input'], BCDType.GLIXON);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


  // O'Brien -------------------------------------------------------------------

  group("BCD.encodeOBrien", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '0011 1001 1110 1011'},
      {'input' : '2ab2', 'expectedOutput' : '0010 0010'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBCD(elem['input'], BCDType.OBRIEN);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeOBrien:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'input' : '0011 1001 1110 1011'},
      {'expectedOutput' : '22', 'input' : '0010 0010'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBCD(elem['input'], BCDType.OBRIEN);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


  // Petherick -------------------------------------------------------------------

  group("BCD.encodePetherick", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '0001 1101 1010 1001'},
      {'input' : '2ab2', 'expectedOutput' : '0011 0011'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBCD(elem['input'], BCDType.PETHERICK);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodePetherick:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'input' : '0001 1101 1010 1001'},
      {'expectedOutput' : '22', 'input' : '0011 0011'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBCD(elem['input'], BCDType.PETHERICK);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group


  // Tompkins -------------------------------------------------------------------

  group("BCD.encodeTompkins", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : '19 68', 'expectedOutput' : '0011 1010 1101 1011'},
      {'input' : '2ab2', 'expectedOutput' : '0111 0111'},
      {'input' : 'Haus', 'expectedOutput' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBCD(elem['input'], BCDType.TOMPKINS);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BCD.decodeTompkins:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '1968', 'input' : '0011 1010 1101 1011'},
      {'expectedOutput' : '22', 'input' : '0111 0111'},
      {'expectedOutput' : '', 'input' : 'Haus'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBCD(elem['input'], BCDType.TOMPKINS);
        expect(_actual, elem['expectedOutput']);
      });
    });
  }); // group

}