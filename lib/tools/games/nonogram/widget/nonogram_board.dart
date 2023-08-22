part of 'package:gc_wizard/tools/games/nonogram/widget/nonogram_solver.dart';

Point<int>? _selectedBox;
Rect? _selectedBoxRect;
FocusNode? _valueFocusNode;


class NonogramBoard extends StatefulWidget {
  final void Function(Puzzle) onChanged;
  final Puzzle board;

  const NonogramBoard({Key? key, required this.onChanged,
    required this.board})
      : super(key: key);

  @override
  NonogramBoardState createState() => NonogramBoardState();
}

class NonogramBoardState extends State<NonogramBoard> {
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
    // _currentInputController.dispose();
    // _currentValueFocusNode.dispose();

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
                    aspectRatio: _fullColumnCount(widget.board) / _fullRowCount(widget.board),
                    child: CanvasTouchDetector(
                      gesturesToOverride: const [GestureType.onTapDown],
                      builder: (context) {
                        return CustomPaint(
                          painter: NonogramBoardPainter(context, widget.board, _setState)
                        );
                      },
                    )
                ),
          ])
      )
    ]);
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

class NonogramBoardPainter extends CustomPainter {
  final BuildContext context;
  final void Function() setState;
  final Puzzle board;

  NonogramBoardPainter(this.context, this.board, this.setState);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    ThemeColors colors = themeColors();

    var paint = Paint();
    var paintGray = Paint();
    var paintFull = Paint();
    var paintBackground = Paint();
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = colors.secondary();

    paintGray.strokeWidth = 1;
    paintGray.style = PaintingStyle.stroke;
    paintGray.color = Colors.black; //switchThumb1

    paintFull.style = PaintingStyle.fill;
    paintFull.color = colors.secondary();

    paintBackground.color = Colors.transparent;
    paintBackground.style = PaintingStyle.fill;

    const border = 5;
    var maxRowHints = _fullRowCount(board) - board.height;
    var maxColumnHints = _fullColumnCount(board) - board.width;

    double widthOuter = size.width - 2 * border;
    double heightOuter = size.height - 2 * border;
    double xOuter = 1 * border.toDouble();
    double yOuter = 1 * border.toDouble();
    double widthInner = widthOuter / max(maxRowHints + board.height, maxColumnHints + board.width);
    double heightInner = widthInner;
    var fontsize = heightInner * 0.8;
    // Rect rect = Rect.zero;

    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    _touchCanvas.drawRect(rect, paintBackground);

    var xInnerStart = xOuter + (maxRowHints * widthInner);
    var xInnerEnd = xInnerStart + (board.width * widthInner);
    var yInnerStart = yOuter + (maxColumnHints * heightInner);
    var yInnerEnd = yInnerStart + (board.height * heightInner);

    for (int y = 0; y <= board.height; y++) {
      var yInner = yInnerStart + y * heightInner;
      if (y < board.height) {
        for (int i = board.rowHints[y].length - 1; i >= 0; i--) {
          rect = Rect.fromLTWH(xInnerStart - widthInner - i * widthInner, yInner, widthInner, heightInner);
          _touchCanvas.drawRect(rect, paintGray);
          _paintText(canvas, rect, board.rowHints[y][i].toString(), colors, fontsize);
        }
      }


      _touchCanvas.drawLine(
          Offset(xInnerStart, yInner),
          Offset(xInnerEnd, yInner), paint);
    }

    for (int x = 0; x <= board.width; x++) {
      var xInner = xInnerStart + x * widthInner;
      if (x < board.width) {
        for (int i = board.columnHints[x].length - 1; i >= 0; i--) {
          rect = Rect.fromLTWH(xInner, yInnerStart- heightInner - i * heightInner, widthInner, heightInner);
          _touchCanvas.drawRect(rect, paintGray);
          _paintText(canvas, rect, board.columnHints[x][i].toString(), colors, fontsize);
        }
      }

      _touchCanvas.drawLine(
          Offset(xInner, yInnerStart),
          Offset(xInner, yInnerEnd), paint);

      if (x < board.width) {
        xInner = xInnerStart + x * widthInner;
        for (int y = 0; y < board.height; y++) {
          var rect = Rect.fromLTWH(xInner, yInnerStart + y * widthInner, widthInner, heightInner);


          var value = board.rows[y][x];
          if (value == 1) {
            rect = Rect.fromLTWH(rect.left + 2, rect.top + 2, rect.width - 4, rect.height - 4);
            _touchCanvas.drawRect(rect, paintFull);
          } else if (value == 0) {
            rect = Rect.fromLTWH(rect.left + 3, rect.top + 3, rect.width - 6, rect.height - 6);
            _touchCanvas.drawLine(
                Offset(rect.left, rect.top),
                Offset(rect.right, rect.bottom), paintGray);
            _touchCanvas.drawLine(
                Offset(rect.right, rect.top),
                Offset(rect.left, rect.bottom), paintGray);
          }
        }
      }
    }
  }


  void _paintText(Canvas canvas, Rect rect, String text, ThemeColors colors, double fontsize) {
    var textPainter = _buildTextPainter(text, colors.mainFont(), fontsize);
    textPainter.paint(canvas, Offset(rect.topCenter.dx - textPainter.width * 0.5,
                                     rect.centerLeft.dy - textPainter.height * 0.5));
}

  TextPainter _buildTextPainter(String text, Color color, double fontsize) {
    TextSpan span = TextSpan(
        style: gcwTextStyle().copyWith(color: color, fontSize: fontsize),
        text: text);
    TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
    textPainter.layout();

    return textPainter;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

int _fullRowCount(Puzzle board) {
  return board.rowHints.reduce((value, hints) => (hints.length > value.length ? hints :value)).length + board.height + 4;
}

int _fullColumnCount(Puzzle board) {
  return board.columnHints.reduce((value, hints) => (hints.length > value.length ? hints :value)).length + board.width + 3;
}
