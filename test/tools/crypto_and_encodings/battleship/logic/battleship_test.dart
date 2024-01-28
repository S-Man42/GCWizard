import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/battleship/logic/battleship.dart';

void main() {
  group("Battleship.encodeTextToNumbers:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'HALLO', 'expectedOutput' : 'B 1, F 1, J 1, N 1, T 1, AA 1, BA 1, CA 1, B 2, F 2, I 2, K 2, N 2, T 2, Z 2, DA 2, B 3, F 3, H 3, L 3, N 3, T 3, Z 3, DA 3, B 4, C 4, D 4, E 4, F 4, H 4, I 4, J 4, K 4, L 4, N 4, T 4, Z 4, DA 4, B 5, F 5, H 5, L 5, N 5, T 5, Z 5, DA 5, B 6, F 6, H 6, L 6, N 6, T 6, Z 6, DA 6, B 7, F 7, H 7, L 7, N 7, O 7, P 7, Q 7, R 7, T 7, U 7, V 7, W 7, X 7, AA 7, BA 7, CA 7'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBattleship(elem['input'] as String, true, true);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.encodeTextToExcel:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'hallo', 'expectedOutput' : ''},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBattleship(elem['input'] as String, true, false);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.encodeGraphicToNumbers:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'AZ', 'expectedOutput' : 'BBBBBABAAA'},
      {'input' : 'Az', 'expectedOutput' : 'BBBBBABAAA'},
      {'input' : 'UV', 'expectedOutput' : 'ABBAAABBAA'},
      {'input' : 'IJ', 'expectedOutput' : 'BABBBBABBB'},
      {'input' : ' A_12Z%', 'expectedOutput' : 'BBBBBABAAA'}
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBattleship(elem['input'] as String, false, true);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.encodeGraphicToExcel:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'AZ', 'expectedOutput' : '1111101000'},
      {'input' : 'Az', 'expectedOutput' : '1111101000'},
      {'input' : 'UV', 'expectedOutput' : '0110001100'},
      {'input' : 'IJ', 'expectedOutput' : '1011110111'},
      {'input' : ' A_12Z%', 'expectedOutput' : '1111101000'}
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = encodeBattleship(elem['input'] as String, false, false);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.decodeNumbers:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : 'AZ', 'input' : 'AAAAABABBB'},
      {'expectedOutput' : 'AZ', 'input' : 'AAAAABABBBA'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBattleship(elem['input'] as String, true);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Battleship.decodeExcel:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '', 'input' : ''},
      {'expectedOutput' : 'hallo', 'input' : ''},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decodeBattleship(elem['input'] as String, false);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

}
