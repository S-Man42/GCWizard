import 'dart:math';

import 'package:flutter/foundation.dart';
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
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/puzzle.dart';
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
  var _currentSizeExpanded = false;
  var _currentRowHintsExpanded = false;
  var _currentColumnHintsExpanded = false;
  late TextEditingController _rowCountController;
  late TextEditingController _columnCountController;
  final _rowController = <TextEditingController>[];
  final _columnController = <TextEditingController>[];

  var _rowCount = 10;
  var _columnCount = 10;
  double _scale = 1;

  @override
  void initState() {
    super.initState();

    _currentBoard = Puzzle.generate(_rowCount, _columnCount);

    _rowCountController = TextEditingController(text : _rowCount.toString());
    _columnCountController = TextEditingController(text : _columnCount.toString());

    Puzzle.mapData(_currentBoard);
  }

  @override
  void dispose() {
    _rowCountController.dispose();
    _columnCountController.dispose();
    for (var controller in _rowController) {controller.dispose();}
    for (var controller in _columnController) {controller.dispose();}

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWOpenFile(
          supportedFileTypes: const [FileType.TXT, FileType.JSON],
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
          suppressTopSpace: true,
          suppressBottomSpace: true,
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
                      _currentBoard.solve();
                      if (_currentBoard.state != PuzzleState.Solved) {
                        showToast(i18n(context, 'sudokusolver_error'));
                      }
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
              )
            )
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
          controller: _rowCountController,
          value: _rowCount,
          min: 1,
          onChanged: (value) {
            setState(() {
              _rowCount = value;
              _scale = min((maxScreenWidth(context) - 2 * DEFAULT_DESCRIPTION_MARGIN)/ (_fieldSize * _rowCount), 1.0);
              var tmpPuzzle = _currentBoard;
              _currentBoard = Puzzle.generate(_rowCount, _columnCount);
              _currentBoard.importHints(tmpPuzzle);
            });
          }
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_column_count'),
          controller: _columnCountController,
          value: _columnCount,
          min: 1,
          onChanged: (value) {
            setState(() {
              _columnCount = value;
              _scale = min((maxScreenWidth(context) - 2 * DEFAULT_DESCRIPTION_MARGIN)/ (_fieldSize * _rowCount), 1.0);
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
      var row =  Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: GCWText(text: i18n(context, 'common_row') + ' ' + (i + 1).toString())
          ),
          Expanded(
            flex: 3,
            child: GCWTextField(
              controller: controller,
              onChanged: (text) {
                setState(() {
                  var data = textToIntList(text, allowNegativeValues: true);
                  var dataBackup = data.sublist(0);
                  data = Puzzle.cleanHints(data, _currentBoard.width);
                  _currentBoard.rowHints[i] = data;
                  if (!listEquals(data, dataBackup)) {
                    showToast(i18n(context, 'nonogramsolver_hinterror'));
                  }
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
      var row =  Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: GCWText(text: i18n(context, 'common_column') + ' ' + (i + 1).toString()),
            ),
            Expanded(
                flex: 3,
                child: GCWTextField(
                    controller: controller,
                    onChanged: (text) {
                      setState(() {
                        var data = textToIntList(text, allowNegativeValues: true);
                        var dataBackup = data.sublist(0);
                        data = Puzzle.cleanHints(data, _currentBoard.height);
                        _currentBoard.columnHints[i] = data;
                        if (!listEquals(data, dataBackup)) {
                          showToast(i18n(context, 'nonogramsolver_hinterror'));
                        }
                      });
                    }
                ),
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
    if (_currentBoard.state == PuzzleState.InvalidHintData) {
      showToast(i18n(context, 'nonogramsolver_hinterror'));
    } else if (_currentBoard.state != PuzzleState.Ok) {
      showToast(i18n(context, 'nonogramsolver_dataerror'));
    }
    _setControllerData();
  }

  void _setControllerData() {
    _rowCount = _currentBoard.height;
    _columnCount = _currentBoard.width;
    _rowCountController.text = _rowCount.toString();
    _columnCountController.text = _columnCount.toString();

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
