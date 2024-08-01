import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/games/logical_supporter/logic/logical_supporter.dart';

void main() {
  group("logical_supporter.setValues:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'categoriesCount': 4, 'itemsCount': 4, 'setValues': [[6, 6, 1], [8, 8, 1]],
        'expectedValidOutput' : true,
        'expectedOutput' : [[15], [7, 8], [3, 4, 4], [1, 2, 2, 2]],
      },
    ];

    for (var elem in _inputsToExpected) {
      test('categoriesCount: ${elem['categoriesCount']} itemsCount: ${elem['itemsCount']}  setValues: ${elem['setValues']}', () {

        var _actual = Logical(elem['categoriesCount'] as int, elem['itemsCount'] as int);
        var valid = true;
        print(_actual.toJson());
        for (var e in (elem['setValues'] as List<List<int>>)) {
          valid &= _actual.setValue(e[0], e[1], e[2], LogicalFillType.USER_FILLED);
        }
        print(_actual.toJson());
        //expect(valid, elem['expectedValidOutput']);

        expect(_actual.toJson(), elem['expectedOutput']);
      });
    }
  });
}