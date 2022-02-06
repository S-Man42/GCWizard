import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/base.dart';

void main() {

  group("Base58.encode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : '3429289555', 'expectedOutput' : '6e31iZ'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBase58(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Base58.decode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : '6e31iZ', 'expectedOutput' : '3429289555'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBase58(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Base91.encode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : 'This is an encoded string', 'expectedOutput' : 'nX,<:WRT%yV%!5:maref3+1RrUb64^M'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBase91(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Base91.decode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : 'nX,<:WRT%yV%!5:maref3+1RrUb64^M', 'expectedOutput' : 'This is an encoded string'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBase91(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Base122.encode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : 'gc wizard', 'expectedOutput' : '3Xd\x07;%ta9\x19'}, // 3Xd;%ta9
      {'input' : 'This is an encoded string', 'expectedOutput' : '*\x1A\x19\x01Rs\x10\x18-b\x03\x15ã7Y\fV!\x01ft9\x1A-f8'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBase122(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Base122.decode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},
      {'input' : '3Xd\x07;%ta9\x19', 'expectedOutput' : 'gc wizard'},
      {'input' : '*\x1A\x19\x01Rs\x10\x18-b\x03\x15ã7Y\fV!\x01ft9\x1A-f8', 'expectedOutput' : 'This is an encoded string'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBase122(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}