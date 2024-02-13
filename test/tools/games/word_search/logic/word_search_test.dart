import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/games/word_search/logic/word_search.dart';


void main() {
  group("wordSearch.searchHorizontal:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : 'uewhe\npotto\nojffj\njfjkh',
        'searchWords' : 'otto',
        'expectedOutput' : [[0, 0, 0, 0, 0], [0, 1, 1, 1, 1], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]],
      },
      {'input' : 'SSUNEZNALG\nSTNESIWBSÜ\nUTEBLOWEGT\nCCIERFGEII\nHÖHLENEREG\nEHENLFWENK\nHGNUREDNAW\nIAVOGELKSN\nTSSEIDARAP\nETUEHOWEFE\n',
        'searchWords' : 'Ast Vogel Höhlen Wander',
        'expectedOutput' : [[0, 0, 0, 0, 0], [0, 1, 1, 1, 1], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]],
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var searchDirection = SearchDirectionFlags.setFlag(0, SearchDirectionFlags.HORIZONTAL);
        var _actual = searchWordList(elem['input'] as String, elem['searchWords'] as String, searchDirection);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("wordSearch.searchHorizontalReverse:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : 'uewhe\npotto\nojffj\njfjkh',
        'searchWords' : 'otto',
        'expectedOutput' : [[0, 0, 0, 0, 0], [0, 1, 1, 1, 1], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]],
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var searchDirection = SearchDirectionFlags.setFlag(0, SearchDirectionFlags.HORIZONTAL) |
            SearchDirectionFlags.setFlag(0, SearchDirectionFlags.REVERSE);
        var _actual = searchWordList(elem['input'] as String, elem['searchWords'] as String, searchDirection);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("wordSearch.searchVertical:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : 'uewoe\npotto\nojftj\njfjoh',
        'searchWords' : 'otto',
        'expectedOutput' : [[0, 0, 0, 2, 0], [0, 0, 0, 2, 0], [0, 0, 0, 2, 0], [0, 0, 0, 2, 0]],
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var searchDirection = SearchDirectionFlags.setFlag(0, SearchDirectionFlags.VERTICAL);
        var _actual = searchWordList(elem['input'] as String, elem['searchWords'] as String, searchDirection);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("wordSearch.searchVerticalReverse:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : 'uewoe\npotto\nojftj\njfjoh',
        'searchWords' : 'otto',
        'expectedOutput' : [[0, 0, 0, 2, 0], [0, 0, 0, 2, 0], [0, 0, 0, 2, 0], [0, 0, 0, 2, 0]],
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var searchDirection = SearchDirectionFlags.setFlag(0, SearchDirectionFlags.VERTICAL) |
        SearchDirectionFlags.setFlag(0, SearchDirectionFlags.REVERSE);
        var _actual = searchWordList(elem['input'] as String, elem['searchWords'] as String, searchDirection);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("wordSearch.searchDiagonal:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : 'uewoe\npotto\nojftj\njfjoh',
        'searchWords' : 'otto',
        'expectedOutput' : [[0, 0, 0, 0, 0], [0, 1, 1, 1, 1], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]],
      },
      {'input' : 'SSUNEZNALG\nSTNESIWBSÜ\nUTEBLOWEGT\nCCIERFGEII\nHÖHLENEREG\nEHENLFWENK\nHGNUREDNAW\nIAVOGELKSN',
        'searchWords' : 'Ast Vogel Höhlen Wander utu ean hite',
        'expectedOutput' : [[0, 0, 0, 0, 0], [0, 1, 1, 1, 1], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]],
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var searchDirection = SearchDirectionFlags.setFlag(0, SearchDirectionFlags.DIAGONAL);
        var _actual = searchWordList(elem['input'] as String, elem['searchWords'] as String, searchDirection);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("wordSearch.searchDiagonalReverse:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : 'uewoe\npotto\nojftj\njfjoh',
        'searchWords' : 'otto',
        'expectedOutput' : [[0, 0, 0, 0, 0], [0, 1, 1, 1, 1], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]],
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var searchDirection = SearchDirectionFlags.setFlag(0, SearchDirectionFlags.DIAGONAL) |
        SearchDirectionFlags.setFlag(0, SearchDirectionFlags.REVERSE);
        var _actual = searchWordList(elem['input'] as String, elem['searchWords'] as String, searchDirection);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}