import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/number_pyramid_solver.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/tools/games/number_pyramid/number_pyramid_board.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_textinputformatter.dart';

class NumberPyramidSolver extends StatefulWidget {
  @override
  NumberPyramidSolverState createState() => NumberPyramidSolverState();
}

class NumberPyramidSolverState extends State<NumberPyramidSolver> {
  NumberPyramid _currentBoard;
  List<List<List<int>>> _currentSolutions;
  int _currentSolution = 0;

  final int _MAX_SOLUTIONS = 10;
  var _rowCount = 3;
  var _currentExpanded = true;
  int _currentValue;
  int _boardX;
  int _boardY;
  TextEditingController _currentInputController;
  IntegerTextInputFormatter _integerInputFormatter;


  @override
  void initState() {
    super.initState();
    _currentInputController = TextEditingController();
    _integerInputFormatter = IntegerTextInputFormatter(min: 0, max: 999999);

    _currentBoard = NumberPyramid(_rowCount);
  }

  @override
  void dispose() {
    _currentInputController.dispose();

    super.dispose();
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
                  _currentBoard = NumberPyramid(_rowCount, oldPyramid: _currentBoard);
                });
              },
            ),
        ),
        Container(height: 10),
        SingleChildScrollView(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(maxWidth: 100.0 * _rowCount), //min(100.0 * _rowCount, MediaQuery.of(context).size.width)),
                child: NumberPyramidBoard(
                  board: _currentBoard,
                  onChanged: (newBoard) {
                    setState(() {
                      _currentBoard = newBoard;
                      _currentSolutions = null;
                    });
                  },
                  showBoxValue: _showBoxValue,
                ),
              ),
            ),
        ),
        Container(height: 10),
        GCWTextField(
          title: i18n(context, 'common_value'),
          controller: _currentInputController,
          inputFormatters: [_integerInputFormatter],
          // min: 0,
          // max: 99999,
          // value: _currentValue,
          onChanged: (value) {
            setState(() {
              _currentValue = int.tryParse(value);
              if (_currentBoard.setValue(_boardX, _boardY, value, NumberPyramidFillType.USER_FILLED))
                _currentBoard.removeCalculated();
            });
          },
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
                      var solveableBoard = _currentBoard.solveableBoard();

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
                        _currentBoard.removeCalculated();

                        _currentSolutions = null;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                )
            ),
            Expanded(
                child: Container(
                  child: GCWButton(
                    text: i18n(context, 'sudokusolver_clearall'),
                    onPressed: () {
                      setState(() {
                        _currentBoard = NumberPyramid(_rowCount);

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
    for (int y = 0; y < _rowCount; y++) {
      for (int x = 0; x < _currentBoard.getColumnsCount(y); x++) {
        if (_currentBoard.getType(x, y) == NumberPyramidFillType.USER_FILLED) continue;

        _currentBoard.setValue(x, y,  _currentSolutions[_currentSolution][y][x], NumberPyramidFillType.CALCULATED);
      }
    }
  }

  void _showBoxValue(int x, int y) {
    setState(() {
      _boardX = x;
      _boardY = y;
      _currentValue = _currentBoard.getValue(x, y) ?? 0;
    });
  }
}
