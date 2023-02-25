import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/games/sudoku/logic/dartist_sudoku_solver/logic/sudoku.dart';
import 'package:gc_wizard/tools/games/sudoku/logic/sudoku_solver.dart';

void main() {
  group("Sudoku.solve:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : [[4, 5, 0, 0, 0, 0, 0, 6, 0], [0, 0, 7, 9, 4, 0, 0, 0, 0], [0, 8, 0, 0, 0, 1, 0, 0, 7], [0, 0, 1, 0, 0, 0, 0, 0, 5], [0, 0, 8, 7, 0, 0, 4, 0, 0], [0, 6, 9, 4, 3, 0, 0, 0, 1], [0, 1, 0, 5, 6, 0, 0, 7, 2], [2, 0, 0, 1, 0, 0, 0, 0, 3], [0, 0, 0, 3, 0, 2, 0, 0, 0]],
        'expectedOutput' : [[[4, 5, 2, 8, 7, 3, 1, 6, 9], [1, 3, 7, 9, 4, 6, 5, 2, 8], [9, 8, 6, 2, 5, 1, 3, 4, 7], [3, 4, 1, 6, 2, 8, 7, 9, 5], [5, 2, 8, 7, 1, 9, 4, 3, 6], [7, 6, 9, 4, 3, 5, 2, 8, 1], [8, 1, 3, 5, 6, 4, 9, 7, 2], [2, 9, 4, 1, 8, 7, 6, 5, 3], [6, 7, 5, 3, 9, 2, 8, 1, 4]]]
      },
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {

        var _actual = SudokuBoard(board: elem['input'] as List<List<int>>);
        _actual.solveSudoku(10);
        expect(_actual.solutions, elem['expectedOutput']);
      });
    });
  });
}