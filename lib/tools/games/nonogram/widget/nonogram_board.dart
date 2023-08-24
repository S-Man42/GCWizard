part of 'package:gc_wizard/tools/games/nonogram/widget/nonogram_solver.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Expanded(
              child:
              Stack(children: <Widget>[
                AspectRatio(
                    aspectRatio: max(_fullColumnCount(widget.board), 1) / max(_fullRowCount(widget.board), 1),
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
}

class NonogramBoardPainter extends CustomPainter {
  final BuildContext context;
  final void Function() setState;
  final Puzzle board;

  NonogramBoardPainter(this.context, this.board, this.setState);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = Paint();
    var paintGray = Paint();
    var paintFull = Paint();
    var paintBackground = Paint();
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = themeColors().secondary();

    paintGray.strokeWidth = 1;
    paintGray.style = PaintingStyle.stroke;
    paintGray.color = themeColors().switchThumb1();

    paintFull.style = PaintingStyle.fill;
    paintFull.color = themeColors().secondary();

    paintBackground.style = PaintingStyle.fill;
    paintBackground.color = themeColors().gridBackground();

    const border = 5;
    var maxRowHints = _fullRowCount(board) - board.height;
    var maxColumnHints = _fullColumnCount(board) - board.width;

    double widthOuter = size.width - 2 * border;
    //double heightOuter = size.height - 2 * border;
    double xOuter = 1 * border.toDouble();
    double yOuter = 1 * border.toDouble();
    double widthInner = (widthOuter - _lineOffset(board.width + maxRowHints))
        / (maxRowHints + board.width);
    double heightInner = widthInner;
    var fontsize = heightInner * 0.8;

    var xInnerStart = xOuter + (maxRowHints * widthInner);
    var xInnerEnd = xInnerStart + (board.width * widthInner) + _lineOffset(board.width);
    var yInnerStart = yOuter + (maxColumnHints * heightInner);
    var yInnerEnd = yInnerStart + (board.height * heightInner) + _lineOffset(board.height);

    var rect = Rect.fromLTRB(xInnerStart, xInnerEnd, xInnerEnd, yInnerEnd);
    _touchCanvas.drawRect(rect, paintBackground);

    for (int y = 0; y <= board.height; y++) {
      var yInner = yInnerStart + y * heightInner + _lineOffset(y);
      if (y < board.height) {
        // row hints
        for (int i = board.rowHints[y].length - 1; i >= 0; i--) {
          rect = Rect.fromLTWH(xInnerStart - widthInner - i * widthInner, yInner, widthInner, heightInner);
          _touchCanvas.drawRect(rect, paintGray);
          _paintText(canvas, rect, board.rowHints[y][i].toString(), fontsize);
        }
        if ((y % 5) == 0) {
          var xOffset = board.rowHints[y].length * widthInner;
          _touchCanvas.drawLine(
              Offset(xInnerStart - xOffset, yInner-1),
              Offset(xInnerStart, yInner-1), paintGray);
        }
      }

      // horizontal lines
      _touchCanvas.drawLine(
          Offset(xInnerStart, yInner),
          Offset(xInnerEnd, yInner), paint);

      if ((y % 5) == 0) {
        yInner -= 1;
        _touchCanvas.drawLine(
            Offset(xInnerStart, yInner),
            Offset(xInnerEnd, yInner), paint);
      }
    }

    for (int x = 0; x <= board.width; x++) {
      var xInner = xInnerStart + x * widthInner + _lineOffset(x);
      if (x < board.width) {
        // column hints
        for (int i = board.columnHints[x].length - 1; i >= 0; i--) {
          rect = Rect.fromLTWH(xInner, yInnerStart - heightInner - i * heightInner, widthInner, heightInner);
          _touchCanvas.drawRect(rect, paintGray);
          _paintText(canvas, rect, board.columnHints[x][i].toString(), fontsize);
        }

        if ((x % 5) == 0) {
          var yOffset = board.columnHints[x].length * heightInner;
          _touchCanvas.drawLine(
              Offset(xInner-1, yInnerStart - yOffset),
              Offset(xInner-1, yInnerStart), paintGray);
        }
      }

      // vertical lines
      _touchCanvas.drawLine(
          Offset(xInner, yInnerStart),
          Offset(xInner, yInnerEnd), paint);

      if ((x % 5) == 0) {
        xInner -= 1;
        _touchCanvas.drawLine(
            Offset(xInner, yInnerStart),
            Offset(xInner, yInnerEnd), paint);
      }

      // fields
      if (x < board.width) {
        xInner = xInnerStart + x * widthInner + _lineOffset(x);
        for (int y = 0; y < board.height; y++) {
          var rect = Rect.fromLTWH(xInner, yInnerStart + y * widthInner + _lineOffset(y), widthInner, heightInner);

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

  static int _lineOffset(int value) {
    return (value / 5).floor();
  }

  void _paintText(Canvas canvas, Rect rect, String text, double fontsize) {
    var textPainter = _buildTextPainter(text, themeColors().mainFont(), fontsize);
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
  return board.rowHints.reduce((value, hints) => (hints.length > value.length ? hints :value)).length + board.height;
}

int _fullColumnCount(Puzzle board) {
  return board.columnHints.reduce((value, hints) => (hints.length > value.length ? hints :value)).length + board.width;
}
