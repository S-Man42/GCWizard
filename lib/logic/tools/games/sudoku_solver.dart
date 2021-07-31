import 'package:gc_wizard/logic/tools/games/dartist_sudoku_solver/sudoku.dart';

List<List<List<int>>> solveSudoku(List<List<int>> grid, int maxSolutions) {
  return solve(grid, maxSolutions: maxSolutions);
}
