import 'package:gc_wizard/tools/games/sudoku/logic/dartist_sudoku_solver/logic/sudoku.dart';

enum SudokuFillType { USER_FILLED, CALCULATED }

class SudokuBoard {
 late List<List<Map<String, Object?>?>> board;

 SudokuBoard() {
    board = List<List<Map<String, Object?>?>>.filled(9, List<Map<String, Object?>?>.filled(9, null));
  }

  void setValue (int i, int j, int? value, {SudokuFillType type = SudokuFillType.USER_FILLED}) {
    board[i][j] = {'value': value, 'type': type};
  }

 int? getValue (int i, int j) {
   board[i][j]?['value'];
 }

  SudokuFillType getFillType(int i, int j) {
   return (board[i][j] == null || board[i][j]!['type'] == SudokuFillType.CALCULATED)
       ? SudokuFillType.CALCULATED
       : SudokuFillType.USER_FILLED;
  }

 List<List<int>> solveableBoard() {
   return board.map((column) {
     return column
         .map((row) => row != null && row['type'] == SudokuFillType.USER_FILLED ? row['value'] as int : 0)
         .toList();
   }).toList();
 }
}

class SudokuSolution {
  List<List<int?>> _solution;

  SudokuSolution(List<List<int?>> this._solution);

  int? getValue (int i, int j) {
    return _solution[i][j];
  }
}

List<SudokuSolution>? solveSudoku(List<List<int>> grid, int maxSolutions) {
  var solutions = solve(grid, maxSolutions: maxSolutions);
  if (solutions == null) return null;

  return solutions.map((solution) => SudokuSolution(solution)).toList();
}
