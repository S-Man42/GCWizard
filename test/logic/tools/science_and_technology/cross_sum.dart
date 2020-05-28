import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/cross_sum.dart';

void main() {
  group("CrossSum.crossSumRange:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'rangeStart' : null, 'rangeEnd' : null, 'crossSumToFind' : null, 'expectedOutput' : []},

      {'rangeStart' : 0, 'rangeEnd' : 100, 'crossSumToFind' : 15, 'expectedOutput' : [69, 78, 87, 96]},
      {'rangeStart' : 0, 'rangeEnd' : -100, 'crossSumToFind' : -15, 'expectedOutput' : [-96, -87, -78, -69]},
      {'rangeStart' : -100, 'rangeEnd' : 100, 'crossSumToFind' : 15, 'expectedOutput' : [69, 78, 87, 96]},
      {'rangeStart' : 0, 'rangeEnd' : 100, 'crossSumToFind' : 50, 'expectedOutput' : []},
    ];

    _inputsToExpected.forEach((elem) {
      test('rangeStart: ${elem['rangeStart']}, rangeEnd: ${elem['rangeEnd']}, crossSumToFind: ${elem['crossSumToFind']},', () {
        var _actual = crossSumRange(elem['rangeStart'], elem['rangeEnd'], elem['crossSumToFind']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
