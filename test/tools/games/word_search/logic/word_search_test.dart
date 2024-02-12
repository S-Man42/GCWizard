import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/games/letter_grid/logic/letter_grid.dart';


void main() {
  group("lettergrid.solve:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'inputGrid' : 'uewhe\npotto\nojffj\njfjkh',
        'searchWords' : 'otto',
        'expectedOutput' : [[15], [7, 8], [3, 4, 4], [1, 2, 2, 2]],
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {

        var _actual = searchWordList(elem['inputGrid'] as String, elem['searchWords'] as String);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}