import 'package:gc_wizard/tools/games/dartist_sudoku_solver/logic/sudoku.dart';

List<List<List<int>>> solveSudoku(List<List<int>> grid, int maxSolutions) {
  return solve(grid, maxSolutions: maxSolutions);
}
