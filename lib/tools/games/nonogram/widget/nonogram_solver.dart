import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_painter_container.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/gcw_integer_textinputformatter.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/puzzle.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/strategy.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:touchable/touchable.dart';

part 'package:gc_wizard/tools/games/nonogram/widget/nonogram_board.dart';

class NonogramSolver extends StatefulWidget {
  const NonogramSolver({Key? key}) : super(key: key);

  @override
  NonogramSolverState createState() => NonogramSolverState();
}

class NonogramSolverState extends State<NonogramSolver> {
  late Puzzle _currentBoard;
  var _currentSizeExpanded = true;
  var _currentRowHintsExpanded = false;
  var _currentColumnHintsExpanded = false;
  var _rowController = <TextEditingController>[];
  var _columnController = <TextEditingController>[];

  var _rowCount = 10;
  var _columnCount = 10;
  double _scale = 1;

  @override
  void initState() {
    super.initState();

    _currentBoard = Puzzle.generate(_rowCount, _columnCount);

    var columns = [[7,1,1,5,7],[1,1,3,1,1,1],[1,3,1,6,2,1,3,1],[1,3,1,1,2,1,1,3,1],[1,3,1,1,2,1,1,3,1],[1,1,1,1,1,1,1],[7,1,1,1,1,1,7],[2,1,2],[1,1,2,3,1,2,5],[3,2,2,2,3,3],[2,1,2,2,1,2,1,2],[1,2,3,3],[1,2,2,1,2,1,1,2,1,1],[1,3,2,1,1,1,1,1],[1,2,4,1,3,1,4],[2,1,1,3,1,1,1,1],[3,3,2,1,6,1],[1,3,1,1,2,2],[7,1,1,1,2],[1,1,2,1,4,1],[1,3,1,3,8,1],[1,3,1,1,1,2,1],[1,3,1,2,2,1,1,1],[1,1,1,1,1,6,1],[7,2,5,5]];
    var   rows = [[7,1,1,1,1,7],[1,1,1,1,1,2,1,1],[1,3,1,1,3,1,3,1],[1,3,1,3,3,1,3,1],[1,3,1,1,1,1,3,1],[1,1,2,6,1,1],[7,1,1,1,1,1,7],[3,3],[5,4,1,2,1,1,1,1],[2,1,2,1,2,1,1,1],[4,1,1,1,4,1,3],[4,1,1,1,2,1],[3,1,2,2,4,2,3],[1,1,1,1,1,1,1,1],[1,1,1,1,5,1,2,2],[1,1,1,1,1,2,1],[1,1,1,2,3,12],[1,1,1,1,2,2],[7,2,1,1,1,1,2],[1,1,2,1,1,1,1,1],[1,3,1,2,9,3],[1,3,1,1,1,3,2,2],[1,3,1,2,3,1,1],[1,1,4,3,1,1],[7,5,1,2]];
    _currentBoard = Puzzle(rows, columns);
    Puzzle.mapData(_currentBoard);
  }

  @override
  void dispose() {
    for (var controller in _rowController) {controller.dispose();}
    for (var controller in _columnController) {controller.dispose();}

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWOpenFile(
          onLoaded: (GCWFile? value) {
            if (value == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            _importJsonFile(value.bytes);

            setState(() {});
          },
        ),
        _puzzleSize(),
        _rowHints(),
        _columnwHints(),

        Container(height: 10),
        GCWPainterContainer(
          scale: _scale,
          onChanged: (value) {_scale = value;},
          child: NonogramBoard(
            board: _currentBoard,
            onChanged: (newBoard) {
              setState(() {
                _currentBoard = newBoard;
              });
            },
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
                child: GCWButton(
                  text: i18n(context, 'sudokusolver_solve'),
                  onPressed: () {
                    setState(() {
                      var strategy  = Strategy();
                      strategy.solve(_currentBoard);
                      if (!_currentBoard.isSolved) {
                        showToast(i18n(context, 'sudokusolver_error'));
                      } //else {
                      //   _showSolution();
                      // }
                    });
                  },
                ),
              ),
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                  child: GCWButton(
                    text: i18n(context, 'sudokusolver_clearcalculated'),
                    onPressed: () {
                      setState(() {
                        _currentBoard.removeCalculated();
                      });
                    },
                  ),
                )
            ),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
                  child: GCWButton(
                    text: i18n(context, 'sudokusolver_clearall'),
                    onPressed: () {
                      setState(() {
                        _currentBoard = Puzzle.generate(_rowCount, _columnCount);
                      });
                    },
                  ),
                ))
          ],
        )
      ],
    );
  }

  Widget _puzzleSize() {
    return GCWExpandableTextDivider(
        text: i18n(context, 'gameoflife_size'),
        expanded: _currentSizeExpanded,
        onChanged: (value) {
          setState(() {
            _currentSizeExpanded = value;
          });
        },
        child: _buildSizeSelection()
    );
  }

  Widget _buildSizeSelection() {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
            title: i18n(context, 'common_row_count'),
            value: _rowCount,
            min: 1,
            onChanged: (value) {
              setState(() {
                _rowCount = value;
                _scale = min((maxScreenWidth(context) - 2 * DEFAULT_DESCRIPTION_MARGIN)/ (20.0 * _rowCount), 1.0);
                var tmpPuzzle = _currentBoard;
                _currentBoard = Puzzle.generate(_rowCount, _columnCount);
                _currentBoard.importHints(tmpPuzzle);
              });
            }
        ),
        GCWIntegerSpinner(
            title: i18n(context, 'common_column_count'),
            value: _columnCount,
            min: 1,
            onChanged: (value) {
              setState(() {
                _columnCount = value;
                _scale = min((maxScreenWidth(context) - 2 * DEFAULT_DESCRIPTION_MARGIN)/ (20.0 * _rowCount), 1.0);
                var tmpPuzzle = _currentBoard;
                _currentBoard = Puzzle.generate(_rowCount, _columnCount);
                _currentBoard.importHints(tmpPuzzle);
              });
            }
        )
      ]
    );
  }

  Widget _rowHints() {
    return GCWExpandableTextDivider(
        text: i18n(context, 'grid_rows'),
        expanded: _currentRowHintsExpanded,
        onChanged: (value) {
          setState(() {
            _currentRowHintsExpanded = value;
          });
        },
        child: _buildRowHints()
    );
  }

  Widget _buildRowHints() {
    var list = <Widget>[];

    for (var i = 0; i < _rowCount; i++ ) {
      var controller = _getRowController(i);
      //controller.text = _currentBoard.rowHints[i].toString();
      var row =  Row(
        children: <Widget>[
          Expanded(
            child: GCWText(text: i18n(context, 'common_row') + ' ' + (i + 1).toString())
          ),
          Expanded(
            child: GCWTextField(
              controller: controller,
              onChanged: (text) {
                setState(() {
                  _currentBoard.rowHints[i] = textToIntList(text);
                });
              }
            )
          )
        ]
      );
      list.add(row);
    }

    return Column(
      children: list,
    );
  }

  Widget _columnwHints() {
    return GCWExpandableTextDivider(
        text: i18n(context, 'grid_columns'),
        expanded: _currentColumnHintsExpanded,
        onChanged: (value) {
          setState(() {
            _currentColumnHintsExpanded = value;
          });
        },
        child: _buildColumnHints()
    );
  }

  Widget _buildColumnHints() {
    var list = <Widget>[];

    for (var i = 0; i < _columnCount; i++ ) {
      var controller = _getColumnController(i);
      //controller.text = _currentBoard.columnHints[i].toString();
      var row =  Row(
          children: <Widget>[
            Expanded(
                child: GCWText(text: i18n(context, 'common_column') + ' ' + (i + 1).toString())
            ),
            Expanded(
                child: GCWTextField(
                    controller: controller,
                    onChanged: (text) {
                      setState(() {
                        _currentBoard.columnHints[i] = textToIntList(text);
                      });
                    }
                )
            )
          ]
      );
      list.add(row);
    }

    return Column(
      children: list,
    );
  }

  TextEditingController _getRowController(int index) {
    while (index >= _rowController.length) {
      _rowController.add(TextEditingController());
    }
    return _rowController[index];
  }

  TextEditingController _getColumnController(int index) {
    while (index >= _columnController.length) {
      _columnController.add(TextEditingController());
    }
    return _columnController[index];
  }

  void _importJsonFile(Uint8List bytes) {
    _currentBoard = Puzzle.parseJson(convertBytesToString(bytes));
    _setControllerData();
  }

  void _setControllerData() {
    for (var i = 0; i < _currentBoard.height; i++) {
      var controller = _getRowController(i);
      controller.text = _currentBoard.rowHints[i].toString().replaceFirst('[', '').replaceFirst(']', '');
    }
    for (var i = _currentBoard.height; i < _rowController.length; i++) {
      var controller = _getRowController(i);
      controller.text = '';
    }

    for (var i = 0; i < _currentBoard.width; i++) {
      var controller = _getColumnController(i);
      controller.text = _currentBoard.columnHints[i].toString().replaceFirst('[', '').replaceFirst(']', '');
    }
    for (var i = _currentBoard.width; i < _columnController.length; i++) {
      var controller = _getColumnController(i);
      controller.text = '';
    }
  }
}
