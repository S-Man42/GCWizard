import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/utils/common_utils.dart';

void main() {
  group("CommonUtils.insertCharacter:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'index': 0, 'character' : 'A', 'expectedOutput' : null},
      {'input' : 'ABC', 'index': 0, 'character' : null, 'expectedOutput' : 'ABC'},

      {'input' : 'ABC', 'index': -1, 'character' : 'D', 'expectedOutput' : 'DABC'},
      {'input' : 'ABC', 'index': 0, 'character' : 'D', 'expectedOutput' : 'DABC'},
      {'input' : 'ABC', 'index': 1, 'character' : 'D', 'expectedOutput' : 'ADBC'},
      {'input' : 'ABC', 'index': 2, 'character' : 'D', 'expectedOutput' : 'ABDC'},
      {'input' : 'ABC', 'index': 3, 'character' : 'D', 'expectedOutput' : 'ABCD'},
      {'input' : 'ABC', 'index': 4, 'character' : 'D', 'expectedOutput' : 'ABCD'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, input: ${elem['index']}, input: ${elem['character']}', () {
        var _actual = insertCharacter(elem['input'], elem['index'], elem['character']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.insertSpaceEveryNthCharacter:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'n': 0, 'expectedOutput' : ''},
      {'input' : 'ABC', 'n': null, 'expectedOutput' : 'ABC'},
      {'input' : 'ABC', 'n': 0, 'expectedOutput' : 'ABC'},
      {'input' : 'ABC', 'n': 1, 'expectedOutput' : 'A B C'},
      {'input' : 'ABCDEF', 'n': 2, 'expectedOutput' : 'AB CD EF'},
      {'input' : 'ABCDEFGHIJ', 'n': 3, 'expectedOutput' : 'ABC DEF GHI J'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, n: ${elem['n']}', () {
        var _actual = insertSpaceEveryNthCharacter(elem['input'], elem['n']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.switchMapKeyValue:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'map' : null, 'expectedOutput': null},
      {'map' : {}, 'expectedOutput': {}},
      {'map' : <String, String>{}, 'expectedOutput': <String, String>{}},
      {'map' : <int, int>{}, 'expectedOutput': <int, int>{}},
      {'map' : <String, int>{}, 'expectedOutput': <int, String>{}},
      {'map' : <int, String>{}, 'expectedOutput': <String, int>{}},

      {'map' : {'A': 'B'}, 'expectedOutput': {'B': 'A'}},
      {'map' : {'A': 'B', 'C': 'D'}, 'expectedOutput': {'B': 'A', 'D': 'C'}},
      {'map' : {'A': 1}, 'expectedOutput': {1: 'A'}},
      {'map' : {'A': 1, 'C': 2}, 'expectedOutput': {1: 'A', 2: 'C'}},
      {'map' : {1: 'B'}, 'expectedOutput': {'B': 1}},
      {'map' : {1: 'B', 2: 'D'}, 'expectedOutput': {'B': 1, 'D': 2}},

      {'map' : {'A': null}, 'expectedOutput': {null: 'A'}},
      {'map' : {'A': 'A'}, 'expectedOutput': {'A': 'A'}},
      {'map' : {null: 'A'}, 'expectedOutput': {'A': null}},
      {'map' : {null: null}, 'expectedOutput': {null: null}},
      {'map' : {'A': 1, 'B': 1}, 'expectedOutput': {1: 'B'}},
      {'map' : {'A': 1, 'B': 1}, 'keepFirstOccurence': true, 'expectedOutput': {1: 'A'}},
      {'map' : {1: 'A', 1: 'B'}, 'expectedOutput': {'B': 1}}, //input map will be reduced to {1: 'B'}
    ];

    _inputsToExpected.forEach((elem) {
      test('map: ${elem['map']}, keepFirstOccurence: ${elem['keepFirstOccurence']}', () {
        var _actual;
        if (elem['keepFirstOccurence'] == null)
          _actual = switchMapKeyValue(elem['map']);
        else
          _actual = switchMapKeyValue(elem['map'], keepFirstOccurence: elem['keepFirstOccurence']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.digitsToAlpha:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'aValue': null, 'removeNonDigits' : null, 'expectedOutput' : null},
      {'input' : null, 'aValue': null, 'removeNonDigits' : true, 'expectedOutput' : null},
      {'input' : null, 'aValue': 0, 'removeNonDigits' : null, 'expectedOutput' : null},
      {'input' : '', 'aValue': null, 'removeNonDigits' : null, 'expectedOutput' : ''},

      {'input' : '', 'aValue': 0, 'removeNonDigits' : null, 'expectedOutput' : ''},
      {'input' : '', 'aValue': null, 'removeNonDigits' : false, 'expectedOutput' : ''},

      {'input' : null, 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : null},

      {'input' : '', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : ''},

      {'input' : '0', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'J'},

      {'input' : '0', 'aValue': 1, 'removeNonDigits' : true, 'expectedOutput' : 'B'},
      {'input' : '9', 'aValue': 1, 'removeNonDigits' : true, 'expectedOutput' : 'K'},

      {'input' : '0', 'aValue': 13, 'removeNonDigits' : true, 'expectedOutput' : 'N'},
      {'input' : '9', 'aValue': 13, 'removeNonDigits' : true, 'expectedOutput' : 'W'},

      {'input' : '0', 'aValue': 26, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': 26, 'removeNonDigits' : true, 'expectedOutput' : 'J'},
      {'input' : '0', 'aValue': 39, 'removeNonDigits' : true, 'expectedOutput' : 'N'},
      {'input' : '9', 'aValue': 39, 'removeNonDigits' : true, 'expectedOutput' : 'W'},
      {'input' : '0', 'aValue': 52, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': 52, 'removeNonDigits' : true, 'expectedOutput' : 'J'},

      {'input' : '0', 'aValue': -1, 'removeNonDigits' : true, 'expectedOutput' : 'Z'},
      {'input' : '9', 'aValue': -1, 'removeNonDigits' : true, 'expectedOutput' : 'I'},
      {'input' : '0', 'aValue': -13, 'removeNonDigits' : true, 'expectedOutput' : 'N'},
      {'input' : '9', 'aValue': -13, 'removeNonDigits' : true, 'expectedOutput' : 'W'},
      {'input' : '0', 'aValue': -26, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': -26, 'removeNonDigits' : true, 'expectedOutput' : 'J'},
      {'input' : '0', 'aValue': -39, 'removeNonDigits' : true, 'expectedOutput' : 'N'},
      {'input' : '9', 'aValue': -39, 'removeNonDigits' : true, 'expectedOutput' : 'W'},
      {'input' : '0', 'aValue': -52, 'removeNonDigits' : true, 'expectedOutput' : 'A'},
      {'input' : '9', 'aValue': -52, 'removeNonDigits' : true, 'expectedOutput' : 'J'},

      {'input' : '0123456789', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'ABCDEFGHIJ'},
      {'input' : '97531', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'JHFDB'},

      {'input' : '0123456789', 'aValue': 21, 'removeNonDigits' : true, 'expectedOutput' : 'VWXYZABCDE'},
      {'input' : '97531', 'aValue': 21, 'removeNonDigits' : true, 'expectedOutput' : 'ECAYW'},

      {'input' : '0123456789', 'aValue': -5, 'removeNonDigits' : true, 'expectedOutput' : 'VWXYZABCDE'},
      {'input' : '97531', 'aValue': -5, 'removeNonDigits' : true, 'expectedOutput' : 'ECAYW'},

      {'input' : ' 0 !"1§ 2% 3 4. 5 6b 7 s8 E9- ', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : 'ABCDEFGHIJ'},
      {'input' : '  !"§ %  .  b  s E- ', 'aValue': 0, 'removeNonDigits' : true, 'expectedOutput' : ''},

      {'input' : ' 0 !"1§ 2% 3 4. 5 6b 7 s8 E9- ', 'aValue': 0, 'removeNonDigits' : false, 'expectedOutput' : ' A !"B§ C% D E. F Gb H sI EJ- '},
      {'input' : '  !"§ %  .  b  s E- ', 'aValue': 0, 'removeNonDigits' : false, 'expectedOutput' : '  !"§ %  .  b  s E- '},

      {'input' : ' 0 !"1§ 2% 3 4. 5 6b 7 s8 E9- ', 'aValue': 13, 'removeNonDigits' : true, 'expectedOutput' : 'NOPQRSTUVW'},
      {'input' : '  !"§ %  .  b  s E- ', 'aValue': 13, 'removeNonDigits' : true, 'expectedOutput' : ''},

      {'input' : ' 0 !"1§ 2% 3 4. 5 6b 7 s8 E9- ', 'aValue': 13, 'removeNonDigits' : false, 'expectedOutput' : ' N !"O§ P% Q R. S Tb U sV EW- '},
      {'input' : '  !"§ %  .  b  s E- ', 'aValue': 13, 'removeNonDigits' : false, 'expectedOutput' : '  !"§ %  .  b  s E- '},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, aValue: ${elem['aValue']}, removeNonDigits: ${elem['removeNonDigits']}', () {
        var _actual = digitsToAlpha(elem['input'], aValue: elem['aValue'], removeNonDigits: elem['removeNonDigits']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.textToBinaryList:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text' : null, 'expectedOutput' : []},
      {'text' : '', 'expectedOutput' : []},
      {'text' : '234', 'expectedOutput' : []},
      {'text' : 'ASD', 'expectedOutput' : []},

      {'text' : '1', 'expectedOutput' : ['1']},
      {'text' : '01', 'expectedOutput' : ['01']},
      {'text' : '01 101', 'expectedOutput' : ['01', '101']},
      {'text' : '01 101 0', 'expectedOutput' : ['01', '101', '0']},

      {'text' : '1dasjk1123ssd12jd10ak', 'expectedOutput' : ['1', '11', '1', '10']},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = textToBinaryList(elem['text']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.modulo:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'value' : 0, 'modulator': 1, 'expectedOutput' : 0},
      {'value' : -1, 'modulator': 1, 'expectedOutput' : 0},
      {'value' : -2, 'modulator': 1, 'expectedOutput' : 0},
      {'value' : 1, 'modulator': 1, 'expectedOutput' : 0},
      {'value' : 2, 'modulator': 1, 'expectedOutput' : 0},

      {'value' : 0, 'modulator': 2, 'expectedOutput' : 0},
      {'value' : -1, 'modulator': 2, 'expectedOutput' : 1},
      {'value' : -2, 'modulator': 2, 'expectedOutput' : 0},
      {'value' : 1, 'modulator': 2, 'expectedOutput' : 1},
      {'value' : 2, 'modulator': 2, 'expectedOutput' : 0},

      {'value' : 0.0, 'modulator': 1, 'expectedOutput' : 0.0},
      {'value' : -1.0, 'modulator': 1, 'expectedOutput' : 0.0},
      {'value' : -2.0, 'modulator': 1, 'expectedOutput' : 0.0},
      {'value' : 1.0, 'modulator': 1, 'expectedOutput' : 0.0},
      {'value' : 2.0, 'modulator': 1, 'expectedOutput' : 0.0},

      {'value' : 0.0, 'modulator': 2, 'expectedOutput' : 0.0},
      {'value' : -1.0, 'modulator': 2, 'expectedOutput' : 1.0},
      {'value' : -2.0, 'modulator': 2, 'expectedOutput' : 0.0},
      {'value' : 1.0, 'modulator': 2, 'expectedOutput' : 1.0},
      {'value' : 2.0, 'modulator': 2, 'expectedOutput' : 0.0},

      {'value' : 0, 'modulator': 1.0, 'expectedOutput' : 0.0},
      {'value' : -1, 'modulator': 1.0, 'expectedOutput' : 0.0},
      {'value' : -2, 'modulator': 1.0, 'expectedOutput' : 0.0},
      {'value' : 1, 'modulator': 1.0, 'expectedOutput' : 0.0},
      {'value' : 2, 'modulator': 1.0, 'expectedOutput' : 0.0},

      {'value' : 0, 'modulator': 2.0, 'expectedOutput' : 0.0},
      {'value' : -1, 'modulator': 2.0, 'expectedOutput' : 1.0},
      {'value' : -2, 'modulator': 2.0, 'expectedOutput' : 0.0},
      {'value' : 1, 'modulator': 2.0, 'expectedOutput' : 1.0},
      {'value' : 2, 'modulator': 2.0, 'expectedOutput' : 0.0},

      {'value' : 0, 'modulator': 2.5, 'expectedOutput' : 0.0},
      {'value' : -1, 'modulator': 2.5, 'expectedOutput' : 1.5},
      {'value' : -2, 'modulator': 2.5, 'expectedOutput' : 0.5},
      {'value' : 1, 'modulator': 2.5, 'expectedOutput' : 1.0},
      {'value' : 2, 'modulator': 2.5, 'expectedOutput' : 2.0},
      {'value' : 2.5, 'modulator': 2.5, 'expectedOutput' : 0.0},
      {'value' : 2.6, 'modulator': 2.5, 'expectedOutput' : 0.10000000000000009},
    ];

    _inputsToExpected.forEach((elem) {
      test('value: ${elem['value']}, modulator:  ${elem['modulator']}', () {
        var _actual = modulo(elem['value'], elem['modulator']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.doubleEquals:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'a' : null, 'b': null, 'tolerance': 1e-10, 'expectedOutput' : true},
      {'a' : null, 'b': 1.0, 'tolerance': 1e-10, 'expectedOutput' : false},
      {'a' : 1.0, 'b': null, 'tolerance': 1e-10, 'expectedOutput' : false},

      {'a' : 1.0, 'b': 1.0, 'tolerance': 1e-10, 'expectedOutput' : true},
      {'a' : 1.123, 'b': 1.123, 'tolerance': 1e-10, 'expectedOutput' : true},
      {'a' : 52.1231554889286231, 'b': 52.1231554889286231, 'tolerance': 1e-10, 'expectedOutput' : true},
      {'a' : 52.123, 'b': 52.132, 'tolerance': 1e-2, 'expectedOutput' : true},
      {'a' : 52.123, 'b': 52.133, 'tolerance': 1e-2, 'expectedOutput' : false},
    ];

    _inputsToExpected.forEach((elem) {
      test('a: ${elem['a']}, b: ${elem['b']}, tolerance: ${elem['tolerance']}', () {
        var _actual = doubleEquals(elem['a'], elem['b'], tolerance: elem['tolerance']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("CommonUtils.isUpperCase:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'letter' : null, 'expectedOutput' : false},
      {'letter' : '', 'expectedOutput' : false},

      {'letter' : 'A', 'expectedOutput' : true},
      {'letter' : 'AA', 'expectedOutput' : true},

      {'letter' : 'AAa', 'expectedOutput' : false},
      {'letter' : 'a', 'expectedOutput' : false},
      {'letter' : 'aA', 'expectedOutput' : false},
    ];

    _inputsToExpected.forEach((elem) {
      test('letter: ${elem['letter']}', () {
        var _actual = isUpperCase(elem['letter']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}