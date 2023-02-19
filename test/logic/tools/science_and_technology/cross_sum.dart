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

  group("CrossSum.crossSumRangeIterated:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'rangeStart' : null, 'rangeEnd' : null, 'crossSumToFind' : null, 'type': CrossSumType.ITERATED, 'expectedOutput' : []},

      {'rangeStart' : 0, 'rangeEnd' : 100, 'crossSumToFind' : 1, 'type': CrossSumType.ITERATED, 'expectedOutput' : [1, 10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100]},
      {'rangeStart' : 0, 'rangeEnd' : -100, 'crossSumToFind' : -5, 'type': CrossSumType.ITERATED, 'expectedOutput' : [-95, -86, -77, -68, -59, -50, -41, -32, -23, -14, -5]},
      {'rangeStart' : -100, 'rangeEnd' : 100, 'crossSumToFind' : 5, 'type': CrossSumType.ITERATED, 'expectedOutput' : [5, 14, 23, 32, 41, 50, 59, 68, 77, 86, 95]},
      {'rangeStart' : 0, 'rangeEnd' : 100, 'crossSumToFind' : 10, 'type': CrossSumType.ITERATED, 'expectedOutput' : []},
    ];

    _inputsToExpected.forEach((elem) {
      test('rangeStart: ${elem['rangeStart']}, rangeEnd: ${elem['rangeEnd']}, crossSumToFind: ${elem['crossSumToFind']}, type: ${elem['type']}', () {
        var _actual = crossSumRange(elem['rangeStart'], elem['rangeEnd'], elem['crossSumToFind'], type: elem['type']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
