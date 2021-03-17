import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/maya_numbers.dart';

void main() {
  group("MayaNumbers.encodeMayaNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : []},

      {'input' : 0, 'expectedOutput' : [[]]},
      {'input' : 1, 'expectedOutput' : [['d']]},
      {'input' : 5, 'expectedOutput' : [['c']]},
      {'input' : 19, 'expectedOutput' : [['a', 'b','c', 'd', 'e', 'f', 'g']]},

      {'input' : 20, 'expectedOutput' : [['d'], []]},
      {'input' : 39, 'expectedOutput' : [['d'], ['a', 'b','c', 'd', 'e', 'f', 'g']]},
      {'input' : 40, 'expectedOutput' : [['d', 'e'], []]},

      {'input' : 399, 'expectedOutput' : [['a', 'b','c', 'd', 'e', 'f', 'g'], ['a', 'b','c', 'd', 'e', 'f', 'g']]},
      {'input' : 400, 'expectedOutput' : [['d'], [], []]},
      {'input' : 401, 'expectedOutput' : [['d'], [], ['d']]},
      {'input' : 444, 'expectedOutput' : [['d'], ['d', 'e'], ['d', 'e', 'f', 'g']]},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeMayaNumbers(elem['input'], true);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("MayaNumbers.decodeMayaNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : {'displays': [[]], 'numbers': [0], 'vigesimal' : BigInt.from(0)}},
      {'input' : <String>[], 'expectedOutput' : {'displays': [[]], 'numbers': [0], 'vigesimal' : BigInt.from(0)}},

      {'input' : <String>[''], 'expectedOutput' : {'displays': [[]], 'numbers': [0], 'vigesimal' : BigInt.from(0)}},
      {'input' : <String>['d'], 'expectedOutput' : {'displays': [['d']], 'numbers': [1], 'vigesimal' : BigInt.from(1)}},
      {'input' : <String>['e'], 'expectedOutput' : {'displays': [['e']], 'numbers': [1], 'vigesimal' : BigInt.from(1)}},
      {'input' : <String>['f'], 'expectedOutput' : {'displays': [['f']], 'numbers': [1], 'vigesimal' : BigInt.from(1)}},
      {'input' : <String>['g'], 'expectedOutput' : {'displays': [['g']], 'numbers': [1], 'vigesimal' : BigInt.from(1)}},
      {'input' : <String>['de'], 'expectedOutput' : {'displays': [['d', 'e']], 'numbers': [2], 'vigesimal' : BigInt.from(2)}},
      {'input' : <String>['fg'], 'expectedOutput' : {'displays': [['f', 'g']], 'numbers': [2], 'vigesimal' : BigInt.from(2)}},
      {'input' : <String>['gd'], 'expectedOutput' : {'displays': [['g', 'd']], 'numbers': [2], 'vigesimal' : BigInt.from(2)}},
      {'input' : <String>['c'], 'expectedOutput' : {'displays': [['c']], 'numbers': [5], 'vigesimal' : BigInt.from(5)}},
      {'input' : <String>['b'], 'expectedOutput' : {'displays': [['b']], 'numbers': [5], 'vigesimal' : BigInt.from(5)}},
      {'input' : <String>['a'], 'expectedOutput' : {'displays': [['a']], 'numbers': [5], 'vigesimal' : BigInt.from(5)}},
      {'input' : <String>['cb'], 'expectedOutput' : {'displays': [['c', 'b']], 'numbers': [10], 'vigesimal' : BigInt.from(10)}},
      {'input' : <String>['ac'], 'expectedOutput' : {'displays': [['a', 'c']], 'numbers': [10], 'vigesimal' : BigInt.from(10)}},
      {'input' : <String>['adcg'], 'expectedOutput' : {'displays': [['a', 'd', 'c', 'g']], 'numbers': [12], 'vigesimal' : BigInt.from(12)}},
      {'input' : <String>['bcde'], 'expectedOutput' : {'displays': [['b', 'c', 'd', 'e']], 'numbers': [12], 'vigesimal' : BigInt.from(12)}},
      {'input' : <String>['abcdefg'], 'expectedOutput' : {'displays': [['a', 'b', 'c', 'd', 'e', 'f', 'g']], 'numbers': [19], 'vigesimal' : BigInt.from(19)}},

      {'input' : <String>['cdgfabe'], 'expectedOutput' : {'displays': [['c', 'd', 'g', 'f', 'a', 'b', 'e']], 'numbers': [19], 'vigesimal' : BigInt.from(19)}},

      {'input' : <String>['d', ''], 'expectedOutput' : {'displays': [['d'], []], 'numbers': [1, 0], 'vigesimal' : BigInt.from(20)}},
      {'input' : <String>['d', 'cdgfabe'], 'expectedOutput' : {'displays': [['d'], ['c', 'd', 'g', 'f', 'a', 'b', 'e']],'numbers': [1, 19], 'vigesimal' : BigInt.from(39)}},
      {'input' : <String>['ed', ''], 'expectedOutput' : {'displays': [['e', 'd'], []], 'numbers': [2, 0], 'vigesimal' :BigInt.from (40)}},

      {'input' : <String>['abcdefg', 'abcdefg'], 'expectedOutput' : {'displays': [['a', 'b', 'c', 'd', 'e', 'f', 'g'], ['a', 'b', 'c', 'd', 'e', 'f', 'g']], 'numbers': [19, 19], 'vigesimal' : BigInt.from(399)}},
      {'input' : <String>['d', '', ''], 'expectedOutput' : {'displays': [['d'], [], []], 'numbers': [1, 0, 0], 'vigesimal' : BigInt.from(400)}},
      {'input' : <String>['d', '', 'd'], 'expectedOutput' : {'displays': [['d'], [], ['d']], 'numbers': [1, 0, 1], 'vigesimal' : BigInt.from(401)}},
      {'input' : <String>['d', 'ed', 'dfeg'], 'expectedOutput' : {'displays': [['d'], ['e', 'd'], ['d', 'f', 'e', 'g']], 'numbers': [1, 2, 4], 'vigesimal' : BigInt.from(444)}},

      {'input' : <String>['d', 'z', 'dfzzeg'], 'expectedOutput' : {'displays': [['d'], [], ['d', 'f', 'e', 'g']], 'numbers': [1, 0, 4], 'vigesimal' : BigInt.from(404)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeMayaNumbers(elem['input'], true);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("MayaNumbersCalendar.encodeMayaNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : []},

      {'input' : 0, 'calculate' : false, 'expectedOutput' : [[]]},
      {'input' : 1, 'calculate' : false, 'expectedOutput' : [['d']]},
      {'input' : 5, 'calculate' : false, 'expectedOutput' : [['c']]},
      {'input' : 19, 'calculate' : false, 'expectedOutput' : [['a', 'b','c', 'd', 'e', 'f', 'g']]},

      {'input' : 20, 'calculate' : false, 'expectedOutput' : [['d'], []]},
      {'input' : 39, 'calculate' : false, 'expectedOutput' : [['d'], ['a', 'b','c', 'd', 'e', 'f', 'g']]},
      {'input' : 40, 'calculate' : false, 'expectedOutput' : [['d', 'e'], []]},

      {'input' : 399, 'calculate' : false, 'expectedOutput' : [ ['d'], ['d'], ['a', 'b','c', 'd', 'e', 'f', 'g']]},
      {'input' : 400, 'calculate' : false, 'expectedOutput' : [['d'], ['d', 'e'], []]},
      {'input' : 401, 'calculate' : false, 'expectedOutput' : [['d'], ['d', 'e'], ['d']]},
      {'input' : 444, 'calculate' : false, 'expectedOutput' : [['d'], ['d', 'e', 'f', 'g'], ['d', 'e', 'f', 'g']]},
      {'input' : 7200, 'calculate' : false, 'expectedOutput' : [['d'], [], [], []]},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, calculate: ${elem['calculate']}', () {
        var _actual = encodeMayaNumbers(elem['input'], elem['calculate']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("MayaNumbersCalendar.decodeMayaNumbers:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : {'displays': [[]], 'numbers': [0], 'vigesimal' : BigInt.from(0)}},
      {'input' : <String>[], 'calculate' : false, 'expectedOutput' : {'displays': [[]], 'numbers': [0], 'vigesimal' : BigInt.from(0)}},

      {'input' : <String>[''], 'calculate' : false, 'expectedOutput' : {'displays': [[]], 'numbers': [0], 'vigesimal' : BigInt.from(0)}},
      {'input' : <String>['d'], 'calculate' : false, 'expectedOutput' : {'displays': [['d']], 'numbers': [1], 'vigesimal' : BigInt.from(1)}},
      {'input' : <String>['e'], 'calculate' : false, 'expectedOutput' : {'displays': [['e']], 'numbers': [1], 'vigesimal' : BigInt.from(1)}},
      {'input' : <String>['f'], 'calculate' : false, 'expectedOutput' : {'displays': [['f']], 'numbers': [1], 'vigesimal' : BigInt.from(1)}},
      {'input' : <String>['g'], 'calculate' : false, 'expectedOutput' : {'displays': [['g']], 'numbers': [1], 'vigesimal' : BigInt.from(1)}},
      {'input' : <String>['de'], 'calculate' : false, 'expectedOutput' : {'displays': [['d', 'e']], 'numbers': [2], 'vigesimal' : BigInt.from(2)}},
      {'input' : <String>['fg'], 'calculate' : false, 'expectedOutput' : {'displays': [['f', 'g']], 'numbers': [2], 'vigesimal' : BigInt.from(2)}},
      {'input' : <String>['gd'], 'calculate' : false, 'expectedOutput' : {'displays': [['g', 'd']], 'numbers': [2], 'vigesimal' : BigInt.from(2)}},
      {'input' : <String>['c'], 'calculate' : false, 'expectedOutput' : {'displays': [['c']], 'numbers': [5], 'vigesimal' : BigInt.from(5)}},
      {'input' : <String>['b'], 'calculate' : false, 'expectedOutput' : {'displays': [['b']], 'numbers': [5], 'vigesimal' : BigInt.from(5)}},
      {'input' : <String>['a'], 'calculate' : false, 'expectedOutput' : {'displays': [['a']], 'numbers': [5], 'vigesimal' : BigInt.from(5)}},
      {'input' : <String>['cb'], 'calculate' : false, 'expectedOutput' : {'displays': [['c', 'b']], 'numbers': [10], 'vigesimal' : BigInt.from(10)}},
      {'input' : <String>['ac'], 'calculate' : false, 'expectedOutput' : {'displays': [['a', 'c']], 'numbers': [10], 'vigesimal' : BigInt.from(10)}},
      {'input' : <String>['adcg'], 'calculate' : false, 'expectedOutput' : {'displays': [['a', 'd', 'c', 'g']], 'numbers': [12], 'vigesimal' : BigInt.from(12)}},
      {'input' : <String>['bcde'], 'calculate' : false, 'expectedOutput' : {'displays': [['b', 'c', 'd', 'e']], 'numbers': [12], 'vigesimal' : BigInt.from(12)}},
      {'input' : <String>['abcdefg'], 'calculate' : false, 'expectedOutput' : {'displays': [['a', 'b', 'c', 'd', 'e', 'f', 'g']], 'numbers': [19], 'vigesimal' : BigInt.from(19)}},

      {'input' : <String>['cdgfabe'], 'calculate' : false, 'expectedOutput' : {'displays': [['c', 'd', 'g', 'f', 'a', 'b', 'e']], 'numbers': [19], 'vigesimal' : BigInt.from(19)}},

      {'input' : <String>['d', ''], 'calculate' : false, 'expectedOutput' : {'displays': [['d'], []], 'numbers': [1, 0], 'vigesimal' : BigInt.from(20)}},
      {'input' : <String>['d', 'cdgfabe'], 'calculate' : false, 'expectedOutput' : {'displays': [['d'], ['c', 'd', 'g', 'f', 'a', 'b', 'e']],'numbers': [1, 19], 'vigesimal' : BigInt.from(39)}},
      {'input' : <String>['ed', ''], 'calculate' : false, 'expectedOutput' : {'displays': [['e', 'd'], []], 'numbers': [2, 0], 'vigesimal' :BigInt.from (40)}},

      {'input' : <String>['abcdefg', 'abcdefg'], 'calculate' : false, 'expectedOutput' : {'displays': [['a', 'b', 'c', 'd', 'e', 'f', 'g'], ['a', 'b', 'c', 'd', 'e', 'f', 'g']], 'numbers': [19, 19], 'vigesimal' : BigInt.from(399)}},
      {'input' : <String>['d', '', ''],  'calculate' : false,'expectedOutput' : {'displays': [['d'], [], []], 'numbers': [1, 0, 0], 'vigesimal' : BigInt.from(360)}},
      {'input' : <String>['d', '', 'd'], 'calculate' : false, 'expectedOutput' : {'displays': [['d'], [], ['d']], 'numbers': [1, 0, 1], 'vigesimal' : BigInt.from(361)}},
      {'input' : <String>['d', 'ed', 'dfeg'], 'calculate' : false, 'expectedOutput' : {'displays': [['d'], ['e', 'd'], ['d', 'f', 'e', 'g']], 'numbers': [1, 2, 4], 'vigesimal' : BigInt.from(404)}},

      {'input' : <String>['d', 'z', 'dfzzeg'], 'calculate' : false, 'expectedOutput' : {'displays': [['d'], [], ['d', 'f', 'e', 'g']], 'numbers': [1, 0, 4], 'vigesimal' : BigInt.from(364)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, calculate: ${elem['calculate']}', () {
        var _actual = decodeMayaNumbers(elem['input'], elem['calculate']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}