import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_painter_container.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/puzzle.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';
import 'package:touchable/touchable.dart';

part 'package:gc_wizard/tools/games/nonogram/widget/nonogram_board.dart';

class NonogramSolver extends StatefulWidget {
  const NonogramSolver({Key? key}) : super(key: key);

  @override
  NonogramSolverState createState() => NonogramSolverState();
}

class NonogramSolverState extends State<NonogramSolver> {
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  late PuzzleWidgetValues _decryptPuzzle;
  late PuzzleWidgetValues _encryptPuzzle;

  @override
  void initState() {
    super.initState();

    _decryptPuzzle = PuzzleWidgetValues();
    _encryptPuzzle = PuzzleWidgetValues(encryptVersion: true);
  }

  @override
  void dispose() {
    _decryptPuzzle.dispose();
    _encryptPuzzle.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          GCWTwoOptionsSwitch(
            value: _currentMode,
            onChanged: (value) {
              setState(() {
                _currentMode = value;
              });
            },
          ),
          _currentMode == GCWSwitchPosition.right
            ? _puzzleWidget(_decryptPuzzle)
            : _puzzleWidget(_encryptPuzzle)
        ]
    );
  }

  Widget _puzzleWidget(PuzzleWidgetValues puzzle) {
    return Column(
      children: <Widget>[
        _openFilButton(puzzle),
        _puzzleSize(puzzle),
        _rowHints(puzzle),
        _columnwHints(puzzle),

        Container(height: 10),
        GCWPainterContainer(
          scale: puzzle.scale,
          suppressTopSpace: true,
          suppressBottomSpace: true,
          onChanged: (value) {puzzle.scale = value;},
          child: NonogramBoard(
            board: puzzle.board,
            onChanged: (newBoard) {
              setState(() {
                puzzle.board = newBoard;
              });
            },
            onTapped: (rowX, column)
            {
              puzzle.encryptVersion
                ? setState(() {puzzle.onTapped(rowX, column);})
                : null;
            },
          ),
        ),
        _controlButtons(puzzle),
        _exportButtons(puzzle),
      ],
    );
  }

  Widget _openFilButton(PuzzleWidgetValues puzzle) {
    if (puzzle.encryptVersion) {
      var fileTypes = [FileType.TXT, FileType.JSON];
      fileTypes.addAll(SUPPORTED_IMAGE_TYPES);
      return GCWOpenFile(
        supportedFileTypes: fileTypes,
        onLoaded: (GCWFile? value) {
          if (value == null) {
            showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
            return;
          } else if (isImage(value.bytes)) {
            _decryptPuzzle.board.importImage(value.bytes);
          } else {
            _importJsonFile(value.bytes, puzzle);
          }
          setState(() {});
        },
      );


    } else {
      return GCWOpenFile(
        supportedFileTypes: const [FileType.TXT, FileType.JSON],
        onLoaded: (GCWFile? value) {
          if (value == null) {
            showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
            return;
          }
          _importJsonFile(value.bytes, puzzle);
          setState(() {});
        },
      );
    }
  }

  Widget _puzzleSize(PuzzleWidgetValues puzzle) {
    return GCWExpandableTextDivider(
        text: i18n(context, 'gameoflife_size'),
        expanded: puzzle.currentSizeExpanded,
        onChanged: (value) {
          setState(() {
            puzzle.currentSizeExpanded = value;
          });
        },
        child: _buildSizeSelection(puzzle)
    );
  }

  Widget _buildSizeSelection(PuzzleWidgetValues puzzle) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          title: i18n(context, 'common_row_count'),
          controller: puzzle.rowCountController,
          value: puzzle.rowCount,
          min: 1,
          onChanged: (value) {
            setState(() {
              puzzle.rowCount = value;
              puzzle.scale = min((maxScreenWidth(context) - 2 * DEFAULT_DESCRIPTION_MARGIN)/ (_fieldSize * puzzle.rowCount), 1.0);
              var tmpPuzzle = puzzle.board;
              puzzle.board = Puzzle.generate(puzzle.rowCount, puzzle.columnCount);
              puzzle.board.importHints(tmpPuzzle);
            });
          }
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_column_count'),
          controller: puzzle.columnCountController,
          value: puzzle.columnCount,
          min: 1,
          onChanged: (value) {
            setState(() {
              puzzle.columnCount = value;
              puzzle.scale = min((maxScreenWidth(context) - 2 * DEFAULT_DESCRIPTION_MARGIN)/ (_fieldSize * puzzle.rowCount), 1.0);
              var tmpPuzzle = puzzle.board;
              puzzle.board = Puzzle.generate(puzzle.rowCount, puzzle.columnCount);
              puzzle.board.importHints(tmpPuzzle);
            });
          }
        )
      ]
    );
  }

  Widget _rowHints(PuzzleWidgetValues puzzle) {
    if (puzzle.encryptVersion) return Container();
    return GCWExpandableTextDivider(
        text: i18n(context, 'grid_rows'),
        expanded: puzzle.currentRowHintsExpanded,
        onChanged: (value) {
          setState(() {
            puzzle.currentRowHintsExpanded = value;
          });
        },
        child: _buildRowHints(puzzle)
    );
  }

  Widget _buildRowHints(PuzzleWidgetValues puzzle) {
    var list = <Widget>[];

    for (var i = 0; i < puzzle.rowCount; i++ ) {
      var controller = puzzle.getRowController(i);
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
                  data = Puzzle.cleanHints(data, puzzle.board.width);
                  puzzle.board.rowHints[i] = data;
                  if (!listEquals(data, dataBackup)) {
                    showSnackBar(i18n(context, 'nonogramsolver_hinterror'), context);
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

  Widget _columnwHints(PuzzleWidgetValues puzzle) {
    if (puzzle.encryptVersion) return Container();
    return GCWExpandableTextDivider(
        text: i18n(context, 'grid_columns'),
        expanded: puzzle.currentColumnHintsExpanded,
        onChanged: (value) {
          setState(() {
            puzzle.currentColumnHintsExpanded = value;
          });
        },
        child: _buildColumnHints(puzzle)
    );
  }

  Widget _buildColumnHints(PuzzleWidgetValues puzzle) {
    var list = <Widget>[];

    for (var i = 0; i < puzzle.columnCount; i++ ) {
      var controller = puzzle.getColumnController(i);
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
                        data = Puzzle.cleanHints(data, puzzle.board.height);
                        puzzle.board.columnHints[i] = data;
                        if (!listEquals(data, dataBackup)) {
                          showSnackBar(i18n(context, 'nonogramsolver_hinterror'), context);
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

  Widget _controlButtons(PuzzleWidgetValues puzzle) {
    return Row(
      children: <Widget>[
        puzzle.encryptVersion
          ? Container()
          : Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
                  child: GCWButton(
                    text: i18n(context, 'sudokusolver_solve'),
                    onPressed: () {
                      setState(() {
                        puzzle.board.solve();
                        if (puzzle.board.state != PuzzleState.Solved) {
                          showSnackBar(i18n(context, 'sudokusolver_error'), context);
                        }
                      });
                    },
                  ),
                ),
        ),
        puzzle.encryptVersion
          ? Container()
          : Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                child: GCWButton(
                  text: i18n(context, 'sudokusolver_clearcalculated'),
                  onPressed: () {
                    setState(() {
                      puzzle.board.removeCalculated();
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
                    puzzle.board = Puzzle.generate(puzzle.rowCount, puzzle.columnCount);
                    puzzle.clearRowHints();
                    puzzle.clearColumnHints();
                  });
                },
              ),
            )
        )
      ],
    );
  }

  Widget _exportButtons(PuzzleWidgetValues puzzle) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
            child: GCWButton(
              text: i18n(context, 'common_exportfile_saveoutput'),
              onPressed: () {
                _renderedImage(puzzle.board, puzzle.encryptVersion).then((image) async {
                  image.toByteData(format: ui.ImageByteFormat.png).then((data) {
                    _exportFile(context, data?.buffer.asUint8List());
                  });
                });
              },
            ),
          ),
        ),
        Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
              child: GCWButton(
                text: i18n(context, 'common_exportfile_saveoutput') + ' JSON',
                onPressed: () {
                  setState(() {
                    _exportJsonFile(context, puzzle.board.toJson(encryptVersion: puzzle.encryptVersion));
                  });
                },
              ),
            )
        ),
      ],
    );
  }

  void _importJsonFile(Uint8List bytes, PuzzleWidgetValues puzzle) {
    puzzle.board = Puzzle.parseJson(convertBytesToString(bytes));
    if (puzzle.board.state == PuzzleState.InvalidHintData) {
      showSnackBar(i18n(context, 'nonogramsolver_hinterror'), context);
    } else if (puzzle.board.state != PuzzleState.Ok) {
      showSnackBar(i18n(context, 'nonogramsolver_dataerror'), context);
    }

    puzzle.setControllerData();
    if (puzzle.encryptVersion) {
      // puzzle.board.clearHints();
    }
  }

  Future<void> _exportFile(BuildContext context, Uint8List? data) async {
    if (data == null) return;
    await saveByteDataToFile(context, data, buildFileNameWithDate('img_', FileType.PNG)).then((value) {
      if (value) showExportedFileDialog(context, contentWidget: imageContent(context, data));
    });
  }

  Future<void> _exportJsonFile(BuildContext context, String? data) async {
    if (data == null) return;
    saveStringToFile(context, data, buildFileNameWithDate('nonogram_', FileType.JSON));
  }

  Future<ui.Image> _renderedImage(Puzzle puzzle, bool encryptVersion) async {
    const cellSize = 70.0;
    final recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    if (encryptVersion) {
      var clone = puzzle.calcHints();
      clone.removeCalculated();

      puzzle = clone;
    }

    final size = Size(
        (puzzle.columns.length + _maxColumnHintsCount(puzzle)) * cellSize,
        (puzzle.rows.length + _maxRowHintsCount(puzzle)) * cellSize);

    final painter = NonogramBoardPainter(context, puzzle, () => {},
        line_color: Colors.black, hint_line_color: Colors.grey, full_color: Colors.black,
        background_color: Colors.white, font_color: Colors.black);

    var paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = Colors.white;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    canvas.save();
    painter.paint(canvas, size);
    return recorder.endRecording().toImage(size.width.floor(), size.height.floor());
  }
}

class PuzzleWidgetValues {
  var rowCount = 10;
  var columnCount = 10;
  late Puzzle board;
  var currentSizeExpanded = false;
  var currentRowHintsExpanded = false;
  var currentColumnHintsExpanded = false;
  late TextEditingController rowCountController;
  late TextEditingController columnCountController;
  final rowController = <TextEditingController>[];
  final columnController = <TextEditingController>[];
  double scale = 1;
  bool encryptVersion = false;

  PuzzleWidgetValues({this.encryptVersion = false}) {
    board = Puzzle.generate(rowCount, columnCount);

    rowCountController = TextEditingController(text : rowCount.toString());
    columnCountController = TextEditingController(text : columnCount.toString());

    Puzzle.mapData(board);
  }

  void clearRowHints() {
    for (var controler in rowController) {controler.text = '';}
  }

  void clearColumnHints() {
    for (var controler in columnController) {controler.text = '';}
  }

  void onTapped(int row, int column) {
    if (row < board.rows.length && column < board.rows[row].length) {
      if (board.rows[row][column] == 1) {
        board.rows[row][column] = -1;
      } else {
        board.rows[row][column] = 1;
      }
    }
  }

  void setControllerData() {
    rowCount = board.height;
    columnCount = board.width;
    rowCountController.text = rowCount.toString();
    columnCountController.text = columnCount.toString();

    for (var i = 0; i < board.rowHints.length; i++) {
      var controller = getRowController(i);
      controller.text = board.rowHints[i].toString().replaceFirst('[', '').replaceFirst(']', '');
    }
    for (var i = board.rowHints.length; i < rowController.length; i++) {
      var controller = getRowController(i);
      controller.text = '';
    }

    for (var i = 0; i < board.columnHints.length; i++) {
      var controller = getColumnController(i);
      controller.text = board.columnHints[i].toString().replaceFirst('[', '').replaceFirst(']', '');
    }
    for (var i = board.columnHints.length; i < columnController.length; i++) {
      var controller = getColumnController(i);
      controller.text = '';
    }
  }

  TextEditingController getRowController(int index) {
    while (index >= rowController.length) {
      rowController.add(TextEditingController());
    }
    return rowController[index];
  }

  TextEditingController getColumnController(int index) {
    while (index >= columnController.length) {
      columnController.add(TextEditingController());
    }
    return columnController[index];
  }

  void dispose() {
    rowCountController.dispose();
    columnCountController.dispose();
    for (var controller in rowController) {controller.dispose();}
    for (var controller in columnController) {controller.dispose();}
  }
}



