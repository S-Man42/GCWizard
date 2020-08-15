import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/tools/games/sudoku/base/sudoku_board.dart';

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
        GCWButton(
          text: 'Solve',
          onPressed: () {
            setState(() {
              _output = 'Solved';
            });
          },
        ),
        GCWDefaultOutput(
          text: _output
        )
      ],
    );
  }
}