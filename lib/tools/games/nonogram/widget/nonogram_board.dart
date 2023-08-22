//part of 'package:gc_wizard/tools/games/nonogram/widget/nonogram_solver.dart';

import 'dart:math';

import 'package:gc_wizard/tools/games/nonogram/logic/puzzle.dart';
import 'package:gc_wizard/tools/games/number_pyramid/logic/number_pyramid_solver.dart';

Point<int>? _selectedBox;
Rect? _selectedBoxRect;
FocusNode? _valueFocusNode;


class NonogramBoard extends StatefulWidget {
  final NumberPyramidFillType type;
  final void Function(Puzzle) onChanged;
  final Puzzle board;

  const NonogramBoard({Key? key, required this.onChanged,
    required this.board, this.type = NumberPyramidFillType.CALCULATED})
      : super(key: key);

  @override
  NonogramBoardState createState() => NonogramBoardState();
}

class NonogramBoardState extends State<NonogramBoard> {
  int? _currentValue;
  late TextEditingController _currentInputController;
  late GCWIntegerTextInputFormatter _integerInputFormatter;
  final _currentValueFocusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//
//     _valueFocusNode = _currentValueFocusNode;
// //    _currentInputController = TextEditingController();
//     _integerInputFormatter = GCWIntegerTextInputFormatter(min: 0, max: 99999);
//   }

  @override
  void dispose() {
    _currentInputController.dispose();
    _currentValueFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child:
            Stack(children:<Widget>[
                AspectRatio(
                    aspectRatio: 1 / 0.5,
                    child: CanvasTouchDetector(
                      gesturesToOverride: const [GestureType.onTapDown],
                      builder: (context) {
                        return CustomPaint(
                          painter: NumberPyramidBoardPainter(context, widget.type, widget.board, _showInputTextBox, _setState)
                        );
                      },
                    )
                ),
              _editWidget()
          ])
      )
    ]);
  }

  Widget _editWidget() {
    const int hightOffset = 4;
    ThemeColors colors = themeColors();
    if (_selectedBoxRect != null && _selectedBox  != null) {
      if (widget.board.getFillType(_selectedBox!.x, _selectedBox!.y) == NumberPyramidFillType.USER_FILLED) {
        _currentValue = widget.board.getValue(_selectedBox!.x, _selectedBox!.y);
      } else {
        _currentValue = null;
      }
      _currentInputController.text = _currentValue?.toString() ?? '';
      _currentInputController.selection = TextSelection.collapsed(offset: _currentInputController.text.length);

      if (_selectedBoxRect!.height < 35) {
        var offset = (35 -_selectedBoxRect!.height) / 2;
        _selectedBoxRect = Rect.fromLTWH(
            _selectedBoxRect!.left - 2 * offset,
            _selectedBoxRect!.top - offset,
            _selectedBoxRect!.width + 4 * offset,
            _selectedBoxRect!.height + 2 * offset);
      }

      return Positioned(
          left: _selectedBoxRect!.left,
          top: _selectedBoxRect!.top - hightOffset,
          width: _selectedBoxRect!.width,
          height: _selectedBoxRect!.height + 2 * hightOffset,
          child: Container(
              color: colors.gridBackground(),
              child: GCWTextField(
                  controller: _currentInputController,
                  inputFormatters: [_integerInputFormatter],
                  keyboardType: const TextInputType.numberWithOptions(),
                  focusNode: _currentValueFocusNode,
                  style: TextStyle(
                    fontSize: _selectedBoxRect!.height * 0.5,
                    color: colors.secondary(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _currentValue = int.tryParse(value);
                      var type = NumberPyramidFillType.USER_FILLED;
                      if (_currentValue == null) type = NumberPyramidFillType.CALCULATED;
                      if (_selectedBox != null &&
                          widget.board.setValue(_selectedBox!.x, _selectedBox!.y, _currentValue, type)) {
                        widget.board.removeCalculated();
                      }
                    });
                  }
              )
          )
      );
    }
    return Container();
  }

  void _setState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  // void _showInputTextBox(Point<int>? showInputTextBox, Rect? selectedBoxRect) {
  //   setState(() {
  //     if (showInputTextBox != null) {
  //       _selectedBox = showInputTextBox;
  //       _selectedBoxRect = selectedBoxRect;
  //       _currentValueFocusNode.requestFocus();
  //     } else {
  //       _hideInputTextBox();
  //     }
  //   });
  // }
}

// void _hideInputTextBox() {
//   _selectedBox = null;
//   _selectedBoxRect = null;
//   if (_valueFocusNode != null) {
//     _valueFocusNode!.unfocus();
//   }
// }

class NumberPyramidBoardPainter extends CustomPainter {
  final BuildContext context;
  final void Function(Point<int>?, Rect?) showInputTextBox;
  final void Function() setState;
  final NumberPyramidFillType type;
  final Puzzle board;

  NumberPyramidBoardPainter(this.context, this.type, this.board, this.showInputTextBox, this.setState);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    ThemeColors colors = themeColors();

    var paint = Paint();
    var paintFull = Paint();
    var paintBackground = Paint();
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = colors.secondary();

    paintFull.style = PaintingStyle.fill;
    paintFull.color = colors.secondary();

    paintBackground.color = Colors.transparent;
    paintBackground.style = PaintingStyle.fill;

    const border = 10;
    double widthOuter = size.width - 8 * border;
    double heightOuter = size.height - 4 * border;
    double xOuter = 4 * border.toDouble();
    double yOuter = 2 * border.toDouble();
    double widthInner = widthOuter / max(board.width, board.height);
    double heightInner = widthInner;
    // var fontsize = heightInner * 0.8;
    // Rect rect = Rect.zero;

    rect = Rect.fromLTWH(0, 0, size.width, size.height);
    _touchCanvas.drawRect(rect, paintBackground,
        onTapDown: (tapDetail) {
          showInputTextBox(null, null);
        }
    );

    double xInner = xOuter + widthOuter;
    for (int y = 0; y < board.height; y++) {
      double yInner = yOuter + y * heightInner;
      _touchCanvas.drawLine(xOuter, yInner, xInner, yInner );
    }
    double yInner = yOuter + heightOuter;
    for (int x = 0; x < board.width; x++) {
      double xInner = xOuter + widthOuter;
      _touchCanvas.drawLine(xInner, yOuter, xInner, yInner );

      for (int y = 0; y < board.height; y++) {
        xInner = xOuter + x * widthInner;
        var rect = Rect.fromLTWH(xInner, yInner, widthInner, heightInner);

        var value = board.rows[y][x];
        if (value == 1) {
          rect = Rect.fromLTWH(rect.x + 2, rect.y + 2, rect.width - 4, rect.height - 4);
          _touchCanvas.drawRect(rect, paint);
        } else if (value == 0) {
          rect = Rect.fromLTWH(rect.x + 3, rect.y + 3, rect.width - 6, rect.height - 6);
          _touchCanvas.drawLine(rect.x, rect.y, rect.right, rect.bottom);
          _touchCanvas.drawLine(rect.right, rect.y, rect.x, rect.bottom);
        }
      }

    }
  }

  // TextPainter _buildTextPainter(String text, Color color, double fontsize) {
  //   TextSpan span = TextSpan(
  //       style: gcwTextStyle().copyWith(color: color, fontSize: fontsize),
  //       text: text);
  //   TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
  //   textPainter.layout();
  //
  //   return textPainter;
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
