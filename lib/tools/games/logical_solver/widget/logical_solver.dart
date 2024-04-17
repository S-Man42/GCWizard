import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_painter_container.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/games/logical_solver/logic/logical_solver.dart';
import 'package:touchable/touchable.dart';

part 'package:gc_wizard/tools/games/logical_solver/widget/logical_solver_board.dart';

class LogicalSolver extends StatefulWidget {
  const LogicalSolver({Key? key}) : super(key: key);

  @override
  LogicalSolverState createState() => LogicalSolverState();
}

class LogicalSolverState extends State<LogicalSolver> {
  late Logical _currentBoard;
  int _currentSolution = 0;

  final int _MAX_SOLUTIONS = 10;
  var _categoriesCount = 4;
  var _itemsCount = 5;
  var _currentExpanded = true;
  double _scale = 1;

  @override
  void initState() {
    super.initState();

    _currentBoard = Logical(_categoriesCount, _itemsCount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWExpandableTextDivider(
            text: i18n(context, 'common_options'),
            expanded: _currentExpanded,
            onChanged: (value) {
              setState(() {
                _currentExpanded = value;
              });
            },
            child: Column(
              children: <Widget>[
                  GCWIntegerSpinner(
                    title: i18n(context, 'logicalsolver_categories'),
                    value: _categoriesCount,
                    min: 2,
                    onChanged: (value) {
                      setState(() {
                        _categoriesCount = value;
                        _currentBoard = Logical(_categoriesCount, _itemsCount, logical: _currentBoard);
                      });
                    },
                  ),
                  GCWIntegerSpinner(
                    title: i18n(context, 'logicalsolver_items'),
                    value: _itemsCount,
                    min: 2,
                    onChanged: (value) {
                      setState(() {
                        _itemsCount = value;
                        _currentBoard = Logical(_categoriesCount, _itemsCount, logical: _currentBoard);
                      });
                    },
              ),
            ])
        ),
        Container(height: 10),
        GCWPainterContainer(
          scale: _scale,
          onChanged: (value) {
            _scale = value;
          },
          child: LogicPuzzleBoard(
            board: _currentBoard,
            onChanged: (newBoard) {
              setState(() {
                _currentBoard = newBoard;
                //_hideInputTextBox();
              });
            },
            onTapped: (x, y) {
                  setState(() {onTapped(x, y);});
            },
            onLongTapped: (x, y) {
              setState(() {onLongTapped(x, y);});
            },
          ),
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
                child: GCWButton(
                  text: i18n(context, 'logicalsolver_save_state'),
                  onPressed: () {
                    setState(() {
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
                child: GCWButton(
                  text: i18n(context, 'logicalsolver_restore_state'),
                  onPressed: () {
                    setState(() {
                    });
                  },
                ),
              ),
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                  child: GCWButton(
                    text: i18n(context, 'logicalsolver_clear_relations'),
                    onPressed: () {
                      setState(() {
                        //_unselectBoardBox();
                        _currentBoard.removeRelations();
                      });
                    },
                  ),
                )
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
                  child: GCWButton(
                    text: i18n(context, 'logicalsolver_clear_items'),
                    onPressed: () {
                      setState(() {
                        //_unselectBoardBox();
                        _currentBoard.removeItems();
                      });
                    },
                  ),
            ))
          ],
        )
      ],
    );
  }

  void _showSolution() {
    _currentBoard.mergeSolution(_currentSolution);
  }

  void onTapped(int x, int y) {
    if (_currentBoard.validPosition(x, y)) {
      var validChange = false;
      if (_currentBoard.getFillType(x, y) == LogicPuzzleFillType.USER_FILLED) {
        validChange = _currentBoard.setValue(x, y, null, LogicPuzzleFillType.USER_FILLED);
      } else {
        validChange = _currentBoard.setValue(x, y, Logical.minusValue, LogicPuzzleFillType.USER_FILLED);
      }
      if (!validChange) {
        showSnackBar(i18n(context, 'logicalsolver_contradiction'), context);
      }
    } else {
      _editItemName(x, y);
    }
  }

  void onLongTapped(int x, int y) {
    if (_currentBoard.validPosition(x, y)) {
      var validChange = false;
      if (_currentBoard.getFillType(x, y) == LogicPuzzleFillType.USER_FILLED) {
        validChange = _currentBoard.setValue(x, y, null, LogicPuzzleFillType.USER_FILLED);
      } else {
        validChange = _currentBoard.setValue(x, y, Logical.plusValue, LogicPuzzleFillType.USER_FILLED);
      }
      if (!validChange) {
        showSnackBar(i18n(context, 'logicalsolver_contradiction'), context);
      }
    } else {
      _editItemName(x, y);
    }
  }

  void _editItemName(int x, int y) {
    if (x == -1 &&  _currentBoard.validPosition(0, y)) {

    } else if (y == -1 &&  _currentBoard.validPosition(x, -1)) {

    }
  }
}
