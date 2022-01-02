import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/sudoku_solver.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/tools/games/game_of_life/game_of_life_board.dart';
import 'package:gc_wizard/widgets/tools/games/sudoku/sudoku_board.dart';
import 'package:prefs/prefs.dart';

class GameOfLife extends StatefulWidget {
  @override
  GameOfLifeState createState() => GameOfLifeState();
}

class GameOfLifeState extends State<GameOfLife> {
  List<List<bool>> _currentBoard;
  var _currentSize = 10;

  @override
  void initState() {
    super.initState();

    _generateBoard();
  }

  _generateBoard() {
    var _newBoard = List<List<bool>>.generate(_currentSize, (index) => List<bool>.generate(_currentSize, (index) => false));

    if (_currentBoard != null) {
      var limit = min(_currentSize, _currentBoard.length);

      for (int i = 0; i < limit; i++) {
        for (int j = 0; j < limit; j++) {
          _newBoard[i][j] = _currentBoard[i][j];
        }
      }
    }

    _currentBoard = List.from(_newBoard);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          min: 1,
          value: _currentSize,
          onChanged: (value) {
            setState(() {
              _currentSize = value;
              _generateBoard();
            });
          },
        ),
        Container(
          constraints: BoxConstraints(maxWidth: min(500, MediaQuery.of(context).size.height * 0.8)),
          child: GameOfLifeBoard(
            state: _currentBoard,
            size: _currentSize,
            onChanged: (newBoard) {
              setState(() {
                _currentBoard = newBoard;
              });
            },
          ),
        ),
      ],
    );
  }
}
