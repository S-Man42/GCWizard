import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_painter_container.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/games/logical_solver/logic/logical_solver.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';
import 'package:touchable/touchable.dart';

part 'package:gc_wizard/tools/games/logical_solver/widget/logical_solver_board.dart';

class LogicalSolver extends StatefulWidget {
  const LogicalSolver({Key? key}) : super(key: key);

  @override
  LogicalSolverState createState() => LogicalSolverState();
}

class LogicalSolverState extends State<LogicalSolver> {
  late Logical _currentBoard;
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
        GCWOpenFile(
          supportedFileTypes: const [FileType.TXT, FileType.JSON],
          title: i18n(context, 'logicalsolver_load'),
          onLoaded: (GCWFile? value) {
            if (value == null) {
              showSnackBar(i18n(context, 'common_loadfile_exception_notloaded'), context);
              return;
            } else {
              setState(() {
                _currentBoard = _importJsonFile(value.bytes);
              });
            }
          },
        ),
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
                overflow: SpinnerOverflowType.SUPPRESS_OVERFLOW,
                min: minItemCount,
                max: maxCategoriesCount,
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
                overflow: SpinnerOverflowType.SUPPRESS_OVERFLOW,
                min: minItemCount,
                max: 99,
                onChanged: (value) {
                  setState(() {
                    _itemsCount = value;
                    _currentBoard = Logical(_categoriesCount, _itemsCount, logical: _currentBoard);
                  });
                },
              ),
            ]
          )
        ),
        GCWPainterContainer(
          scale: _scale,
          onChanged: (value) {
            _scale = value;
          },
          child: LogicalBoard(
            board: _currentBoard,
            onChanged: (newBoard) {
              setState(() {
                _currentBoard = newBoard;
              });
            },
            onTapped: (x, y) {
              setState(() {_onTapped(x, y);});
            },
            onLongTapped: (x, y) {
              setState(() {_onLongTapped(x, y);});
            },
          ),
        ),

        Row(
          children: <Widget>[
            Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                  child: GCWButton(
                    text: i18n(context, 'logicalsolver_clear_relations'),
                    onPressed: () {
                      setState(() {
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
        ),
        GCWButton(
          text: i18n(context, 'logicalsolver_save'),
          onPressed: () {
            setState(() {
              _exportJsonFile(context, _currentBoard.toJson());
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    var result = _currentBoard.getSolution();

    return GCWDefaultOutput(
      trailing: Row(
        children: <Widget>[
          GCWIconButton(
            iconColor: themeColors().mainFont(),
            size: IconButtonSize.SMALL,
            icon: Icons.content_copy,
            onPressed: () {
              var copyText = result.map((line) {
                return line.map((e) => e).join('\t');
              }).join('\n');
              insertIntoGCWClipboard(context, copyText);
            },
          ),
        ],
      ),
      child: GCWColumnedMultilineOutput(data: result, hasHeader: false,
          suppressCopyButtons: true),
    );
  }

  void _onTapped(int x, int y) {
    var validChange = false;
    if (_currentBoard.getFillType(x, y) == LogicPuzzleFillType.USER_FILLED) {
      validChange = _currentBoard.setValue(x, y, null, LogicPuzzleFillType.USER_FILLED);
    } else {
      validChange = _currentBoard.setValue(x, y, Logical.minusValue, LogicPuzzleFillType.USER_FILLED);
    }
    if (!validChange) {
      showSnackBar(i18n(context, 'logicalsolver_contradiction'), context);
    }
  }

  void _onLongTapped(int x, int y) {
    var validChange = false;
    if (_currentBoard.getFillType(x, y) == LogicPuzzleFillType.USER_FILLED) {
      validChange = _currentBoard.setValue(x, y, null, LogicPuzzleFillType.USER_FILLED);
    } else {
      validChange = _currentBoard.setValue(x, y, Logical.plusValue, LogicPuzzleFillType.USER_FILLED);
    }
    if (!validChange) {
      showSnackBar(i18n(context, 'logicalsolver_contradiction'), context);
    }
  }

  Logical _importJsonFile(Uint8List bytes) {
    var logical = Logical.parseJson(convertBytesToString(bytes));
    if (logical.state != LogicalState.Ok) {
      showSnackBar(i18n(context, 'logicalsolver_dataerror'), context);
    }
    return logical;
  }

  Future<void> _exportJsonFile(BuildContext context, String? data) async {
    if (data == null) return;
    saveStringToFile(context, data, buildFileNameWithDate('logical_', FileType.JSON));
  }
}
