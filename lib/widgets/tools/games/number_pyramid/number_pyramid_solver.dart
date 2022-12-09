import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/number_pyramid_solver.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/tools/games/number_pyramid/number_pyramid_board.dart';

class NumberPyramidSolver extends StatefulWidget {
  @override
  NumberPyramidSolverState createState() => NumberPyramidSolverState();
}

class NumberPyramidSolverState extends State<NumberPyramidSolver> {
  List<List<Map<String, dynamic>>> _currentBoard;
  List<List<List<int>>> _currentSolutions;
  int _currentSolution = 0;

  final int _MAX_SOLUTIONS = 10;
  var _rowCount = 3;
  var _currentExpanded = true;

  @override
  void initState() {
    super.initState();

    _currentBoard = _generatePyramid();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWExpandableTextDivider(
            text: i18n(context, 'Row Count'),
            expanded: _currentExpanded,
            onChanged: (value) {
              setState(() {
                _currentExpanded = value;
              });
            },
            child: GCWIntegerSpinner(
              title: 'Row Count',
              value: _rowCount,
              min: 1,
              onChanged: (value) {
                setState(() {
                  _rowCount = value;
                  _currentBoard = _generatePyramid(useEntrys: true);
                });
              },
            ),
        ),
        Container(height: 10),
        Container(
          constraints: BoxConstraints(maxWidth: min(100.0 * _rowCount, MediaQuery.of(context).size.width)),
          child: NumberPyramidBoard(
            board: _currentBoard,
            onChanged: (newBoard) {
              setState(() {
                _currentBoard = newBoard;
                _currentSolutions = null;
              });
            },
          ),
        ),
        if (_currentSolutions != null && _currentSolutions.length > 1)
          Container(
            child: Row(
              children: [
                GCWIconButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: () {
                    setState(() {
                      _currentSolution = (_currentSolution - 1 + _currentSolutions.length) % _currentSolutions.length;
                      _showSolution();
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    align: Alignment.center,
                    text: '${_currentSolution + 1}/${_currentSolutions.length}' +
                        (_currentSolutions.length >= _MAX_SOLUTIONS ? ' *' : ''),
                  ),
                ),
                GCWIconButton(
                  icon: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _currentSolution = (_currentSolution + 1) % _currentSolutions.length;
                      _showSolution();
                    });
                  },
                ),
              ],
            ),
            margin: EdgeInsets.only(top: 5 * DOUBLE_DEFAULT_MARGIN),
          ),
        if (_currentSolutions != null && _currentSolutions.length >= _MAX_SOLUTIONS)
          Container(
            child: GCWText(text: '*) ' + i18n(context, 'sudokusolver_maximumsolutions')),
            padding: EdgeInsets.only(top: DOUBLE_DEFAULT_MARGIN),
          ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: GCWButton(
                  text: i18n(context, 'sudokusolver_solve'),
                  onPressed: () {
                    setState(() {
                      List<List<int>> solveableBoard = _currentBoard.map((column) {
                        return column
                            .map((row) =>
                                row != null && row['type'] == NumberPyramidFillType.USER_FILLED ? row['value'] as int : null) //0
                            .toList();
                      }).toList();

                      _currentSolutions = solvePyramid(solveableBoard, _MAX_SOLUTIONS);
                      if (_currentSolutions == null) {
                        showToast(i18n(context, 'sudokusolver_error'));
                      } else {
                        _currentSolution = 0;
                        _showSolution();
                      }
                    });
                  },
                ),
                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
              ),
            ),
            Expanded(
                child: Container(
              child: GCWButton(
                text: i18n(context, 'sudokusolver_clearcalculated'),
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < _rowCount; i++) {
                      for (int j = 0; j < i + 1; j++) {
                        if (_currentBoard[i][j] != null && _currentBoard[i][j]['type'] == NumberPyramidFillType.CALCULATED)
                          _currentBoard[i][j] = null;
                      }
                    }
                    _currentSolutions = null;
                  });
                },
              ),
              padding: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
            )),
            Expanded(
                child: Container(
              child: GCWButton(
                text: i18n(context, 'sudokusolver_clearall'),
                onPressed: () {
                  setState(() {
                    _currentBoard = _generatePyramid();

                    _currentSolutions = null;
                  });
                },
              ),
              padding: EdgeInsets.only(left: DEFAULT_MARGIN),
            ))
          ],
        )
      ],
    );
  }

  _showSolution() {
    for (int i = 0; i < _rowCount; i++) {
      for (int j = 0; j < i + 1; j++) {
        if (_currentBoard[i][j] != null && _currentBoard[i][j]['type'] == NumberPyramidFillType.USER_FILLED) continue;

        _currentBoard[i][j] = {'value': _currentSolutions[_currentSolution][i][j], 'type': NumberPyramidFillType.CALCULATED};
      }
    }
  }

  List<List<Map<String, dynamic>>> _generatePyramid({useEntrys : false}) {
    var pyramid =  List<List<Map<String, dynamic>>>.generate(
        _rowCount, (index) => List<Map<String, dynamic>>.generate(index+1, (index) => null));

    if (useEntrys && _currentBoard != null) {
      for (var layer=0; layer < min(_currentBoard.length, _rowCount); layer++) {
        for (var brick=0; brick < pyramid[layer].length; brick++) {
          if (_currentBoard[layer][brick] != null)
            pyramid[layer][brick]= _currentBoard[layer][brick];
        }
      }
    }

    return pyramid;
  }
}
