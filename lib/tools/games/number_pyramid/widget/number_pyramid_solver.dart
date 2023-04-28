import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_paste_button.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/gcw_integer_textinputformatter.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/games/number_pyramid/logic/number_pyramid_solver.dart';
import 'package:touchable/touchable.dart';

part 'package:gc_wizard/tools/games/number_pyramid/widget/number_pyramid_board.dart';


class NumberPyramidSolver extends StatefulWidget {
  const NumberPyramidSolver({Key? key}) : super(key: key);

  @override
  NumberPyramidSolverState createState() => NumberPyramidSolverState();
}

class NumberPyramidSolverState extends State<NumberPyramidSolver> {
  late NumberPyramid _currentBoard;
  int _currentSolution = 0;

  final int _MAX_SOLUTIONS = 10;
  var _rowCount = 3;
  var _currentExpanded = true;
  int? _currentValue;
  int? _boardX;
  int? _boardY;
  double _scale = 1;
  late TextEditingController _currentInputController;
  late GCWIntegerTextInputFormatter _integerInputFormatter;
  final _currentValueFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _currentInputController = TextEditingController();
    _integerInputFormatter = GCWIntegerTextInputFormatter(min: 0, max: 999999);

    _currentBoard = NumberPyramid(_rowCount);
    _showBoxValue(0, 0);
  }

  @override
  void dispose() {
    _currentInputController.dispose();
    _currentValueFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWExpandableTextDivider(
            text: i18n(context, 'common_row_count'),
            expanded: _currentExpanded,
            onChanged: (value) {
              setState(() {
                _currentExpanded = value;
              });
            },
            child: GCWIntegerSpinner(
              title: i18n(context, 'common_row_count'),
              value: _rowCount,
              min: 1,
              onChanged: (value) {
                setState(() {
                  _rowCount = value;
                  _currentBoard = NumberPyramid(_rowCount, pyramid: _currentBoard);
                });
              },
            ),
        ),
        Container(height: 10),
        GCWTextDivider(
          text: '',
          trailing: Row(children: <Widget>[
            GCWIconButton(
              size: IconButtonSize.SMALL,
              icon: Icons.zoom_in,
              onPressed: () {
                setState(() {
                  _scale += 0.1;
                });
              },
            ),
            GCWIconButton(
              size: IconButtonSize.SMALL,
              icon: Icons.zoom_out,
              onPressed: () {
                setState(() {
                  _scale = max(0.1, _scale - 0.1);
                });
              },
            ),
            Container(width: 5),
            GCWPasteButton(
              iconSize: IconButtonSize.SMALL,
              onSelected: _parseClipboard,
            ),
            GCWIconButton(
              size: IconButtonSize.SMALL,
              icon: Icons.content_copy,
              onPressed: () {
                var copyText = _currentBoard.toJson();
                insertIntoGCWClipboard(context, copyText);
              },
            )
          ])
        ),
        SingleChildScrollView(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(maxWidth: 100.0 * _rowCount * _scale),
                child: NumberPyramidBoard(
                  board: _currentBoard,
                  onChanged: (newBoard) {
                    setState(() {
                      _currentBoard = newBoard;
                      selectedBox = null;
                      _showBoxValue(null, null);
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
          keyboardType: const TextInputType.numberWithOptions(),
          autofocus: true,
          focusNode: _currentValueFocusNode,
          onChanged: (value) {
            setState(() {
              _currentValue = int.tryParse(value);
              var type = NumberPyramidFillType.USER_FILLED;
              if (_currentValue == null) type = NumberPyramidFillType.CALCULATED;
              if (_boardX != null && _boardY != null &&
                  _currentBoard.setValue(_boardX!, _boardY!, _currentValue, type)) {
                _currentBoard.removeCalculated();
              }
            });
          },
        ),
        if (_currentBoard.solutions != null && _currentBoard.solutions!.length > 1)
          Container(
            margin: const EdgeInsets.only(top: 5 * DOUBLE_DEFAULT_MARGIN),
            child: Row(
              children: [
                GCWIconButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: () {
                    setState(() {
                      _currentSolution = (_currentSolution - 1 + _currentBoard.solutions!.length) % _currentBoard.solutions!.length;
                      _showSolution();
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    align: Alignment.center,
                    text: '${_currentSolution + 1}/${_currentBoard.solutions!.length}' +
                        (_currentBoard.solutions!.length >= _MAX_SOLUTIONS ? ' *' : ''),
                  ),
                ),
                GCWIconButton(
                  icon: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _currentSolution = (_currentSolution + 1) % _currentBoard.solutions!.length;
                      _showSolution();
                    });
                  },
                ),
              ],
            ),
          ),
        if (_currentBoard.solutions != null && _currentBoard.solutions!.length >= _MAX_SOLUTIONS)
          Container(
            padding: const EdgeInsets.only(top: DOUBLE_DEFAULT_MARGIN),
            child: GCWText(text: '*) ' + i18n(context, 'sudokusolver_maximumsolutions')),
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
                      _currentBoard.solvePyramid(_MAX_SOLUTIONS);
                      if (_currentBoard.solutions == null) {
                        showToast(i18n(context, 'sudokusolver_error'));
                      } else {
                        _currentSolution = 0;
                        _showSolution();
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
                        _currentBoard = NumberPyramid(_rowCount);
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

  void _showBoxValue(int? x, int? y) {
    setState(() {
      _boardX = x;
      _boardY = y;
      if (x != null && y != null) {
        _currentValue = _currentBoard.getValue(x, y);
      } else {
        _currentValue = null;
      }
      _currentInputController.text = _currentValue == null ? '' : _currentValue.toString();

      if (x != null && y != null && _currentBoard.validPosition(x, y)) {
        _currentValueFocusNode.requestFocus();
      } else {
        _currentValueFocusNode.unfocus();
      }
    });
  }

  void _parseClipboard(String text) {
    setState(() {
      var pyramid = NumberPyramid.fromJson(text);
      if (pyramid == null) {
        _rowCount = 3;
        _currentBoard = NumberPyramid(_rowCount);
      } else {
        _rowCount = pyramid.rowCount;
        _currentBoard = pyramid;
      }
      selectedBox = null;
      _showBoxValue(null, null);
    });
  }
}
