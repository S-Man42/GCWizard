import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/games/sudoku_solver.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/tools/games/sudoku/sudoku_board.dart';

class SudokuSolver extends StatefulWidget {
  @override
  SudokuSolverState createState() => SudokuSolverState();
}

class SudokuSolverState extends State<SudokuSolver> {
  List<List<Map<String, dynamic>>> _currentBoard;
  var _output = '';

  @override
  void initState() {
    super.initState();

    _currentBoard = List<List<Map<String, dynamic>>>.generate(9, (index) => List<Map<String, dynamic>>.generate(9, (index) => null));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SudokuBoard(
          board: _currentBoard,
          onChanged: (newBoard) {
            setState(() {
              _currentBoard = newBoard;
            });
          },
        ),
        Row(
          children: <Widget>[
            GCWButton(
              text: 'Solve',
              onPressed: () {
                setState(() {
                  List<List<int>> solveableBoard = _currentBoard.map((column) {
                    return column.map((row) => row != null && row['type'] == SudokuFillType.USER_FILLED ? row['value'] as int : 0).toList();
                  }).toList();

                  var solved = solveSudoku(solveableBoard);
                  if (solved == null) {
                    showToast('Couldnt be solved');
                  } else {
                    for (int i = 0; i < 9; i++) {
                      for (int j = 0; j < 9; j++) {
                        if (_currentBoard[i][j] != null && _currentBoard[i][j]['type'] == SudokuFillType.USER_FILLED)
                          continue;

                        _currentBoard[i][j] = {'value': solved[i][j], 'type': SudokuFillType.CALCULATED};
                      }
                    }
                  }
                });
              },
            ),
            GCWButton(
              text: 'Clear Calculated',
              onPressed: () {
                setState(() {
                  for (int i = 0; i < 9; i++) {
                    for (int j = 0; j < 9; j++) {
                      if (_currentBoard[i][j] != null && _currentBoard[i][j]['type'] == SudokuFillType.CALCULATED)
                        _currentBoard[i][j] = null;
                    }
                  }
                });
              },
            )
          ],
        )
      ],
    );
  }
}