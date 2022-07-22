import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/games/sudoku/sudoku_solver/widget/sudoku_solver.dart';

class SudokuSolverRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GAMES = [
    ToolCategory.GAMES
  ];

  @override
  String i18nPrefix = 'sudokusolver';

  @override
  List<String> searchKeys = [
    'games',
    'games_sudokusolver',
  ];

  @override
  Widget tool = SudokuSolver();
}