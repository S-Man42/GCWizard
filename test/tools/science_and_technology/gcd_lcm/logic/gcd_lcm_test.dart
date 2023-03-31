import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/gcd_lcm/logic/gcd_lcm.dart';

void main() {
  group("gcd", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input_a' : 0, 'input_b' : 0, 'expectedOutput' : 0},
      {'input_a' : 1, 'input_b' : 0, 'expectedOutput' : 1},
      {'input_a' : 0, 'input_b' : 1, 'expectedOutput' : 1},
      {'input_a' : 36, 'input_b' : 24, 'expectedOutput' : 12},
      {'input_a' : 24, 'input_b' : 36, 'expectedOutput' : 12},
    ];

    for (var elem in _inputsToExpected) {
      test('input_a: ${elem['input_a']}, input_b: ${elem['input_b']}', () {
        var _actual = gcd(elem['input_a'] as int, elem['input_b'] as int);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("lcm", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input_a' : 0, 'input_b' : 0, 'expectedOutput' : 0},
      {'input_a' : 1, 'input_b' : 0, 'expectedOutput' : 0},
      {'input_a' : 0, 'input_b' : 1, 'expectedOutput' : 0},
      {'input_a' : 36, 'input_b' : 24, 'expectedOutput' : 72},
      {'input_a' : 24, 'input_b' : 36, 'expectedOutput' : 72},
    ];

    for (var elem in _inputsToExpected) {
      test('input_a: ${elem['input_a']}, input_b: ${elem['input_b']}', () {
        var _actual = lcm(elem['input_a'] as int, elem['input_b'] as int);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

}