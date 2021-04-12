import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/periodic_table.dart';

void main() {
  group("PeriodicTable.atomicNumbersToText:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'atomicNumbers' : null, 'expectedOutput' : ''},
      {'atomicNumbers' : <int>[], 'expectedOutput' : ''},

      {'atomicNumbers' : [1,2,3], 'expectedOutput' : 'HHeLi'},
      {'atomicNumbers' : [4,16,73], 'expectedOutput' : 'BeSTa'},
      {'atomicNumbers' : [4,16,-1], 'expectedOutput' : 'BeS<?>'},
    ];

    _inputsToExpected.forEach((elem) {
      test('atomicNumbers: ${elem['atomicNumbers']}', () {
        var _actual = atomicNumbersToText(elem['atomicNumbers']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}