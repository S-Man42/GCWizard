part of 'package:gc_wizard/tools/games/logical_solver/widget/logical_solver.dart';

const boxSize = 20.0;
const fontSize = boxSize * 0.7;
const blockMargin = boxSize/ 2;
const itemTextOffsetStart = 3;
const itemTextOffsetEnd = 10;

class LogicPuzzleBoard extends StatefulWidget {
  final void Function(Logical) onChanged;
  final Logical board;
  final void Function(int, int) onTapped;
  final void Function(int, int) onLongTapped;

  const LogicPuzzleBoard({Key? key, required this.onChanged,
    required this.board, required this.onTapped, required this.onLongTapped})
      : super(key: key);

  @override
  LogicPuzzleBoardState createState() => LogicPuzzleBoardState();
}

class LogicPuzzleBoardState extends State<LogicPuzzleBoard> {

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Expanded(
              child:
              Stack(children: <Widget>[
                AspectRatio(
                    aspectRatio: max(_maxRowItemsWidth(widget.board, fontSize) + widget.board.getLineLength(0) * boxSize, 1) / //ToDo FontSize
                        max(_maxColumnItemsWidth(widget.board, fontSize) + widget.board.getMaxLineLength() * boxSize, 1),
                    child: CanvasTouchDetector(
                      gesturesToOverride: const [GestureType.onTapUp, GestureType.onLongPressEnd],
                      builder: (context) {
                        return CustomPaint(
                            painter: LogicPuzzleBoardPainter(context, widget.board, _setState,
                                onTapped: widget.onTapped, onLongTapped: widget.onLongTapped)
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

class LogicPuzzleBoardPainter extends CustomPainter {
  final BuildContext context;
  final void Function() setState;
  final Logical board;
  Color line_color = themeColors().secondary();
  Color hint_line_color = themeColors().switchThumb1();
  Color full_color = themeColors().secondary();
  Color background_color = themeColors().gridBackground();
  Color font_color = themeColors().mainFont();
  final void Function(int, int) onTapped;
  final void Function(int, int) onLongTapped;

  LogicPuzzleBoardPainter(this.context, this.board, this.setState,
      {Color? line_color, Color?  hint_line_color, Color? full_color, Color? background_color, Color? font_color,
        required this.onTapped, required this.onLongTapped}) {
    this.line_color = line_color ?? this.line_color;
    this.hint_line_color = hint_line_color ?? this.hint_line_color;
    this.full_color = full_color ?? this.full_color;
    this.background_color = background_color ?? this.background_color;
    this.font_color = font_color ?? this.font_color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paintLine = Paint();
    var paintItemLine = Paint();
    var paintBackground = Paint();
    paintLine.strokeWidth = 1;
    paintLine.style = PaintingStyle.stroke;
    paintLine.color = line_color;

    paintItemLine.strokeWidth = 1;
    paintItemLine.style = PaintingStyle.stroke;
    paintItemLine.color = hint_line_color;

    paintBackground.style = PaintingStyle.fill;
    paintBackground.color = background_color;

    const border = 5;
    var maxRowItemsWidth = _maxRowItemsWidth(board, fontSize);
    var maxColumnItemsWidth = _maxColumnItemsWidth(board, fontSize);

    double widthOuter = size.width - 2 * border;
    double xOuter = 1 * border.toDouble();
    double yOuter = 1 * border.toDouble();
    double widthInner = boxSize; // (widthOuter - _lineOffset(maxRowHints + board.getColumnsCount(0))) / (maxRowHints + board.getRowsCount());
    double heightInner = widthInner;
    //var fontSize = heightInner * 0.7;
    var fieldBorderOn = widthInner / 10;

    var xInnerStart = xOuter + maxRowItemsWidth + blockMargin;
    var xInnerEnd = xInnerStart + board.getLineLength(0) * heightInner + _lineOffset(board.getLineLength(0));
    var yInnerStart = yOuter + maxColumnItemsWidth + blockMargin;
    var yInnerEnd = yInnerStart + board.getMaxLineLength() * heightInner + _lineOffset(board.getMaxLineLength());

    var rect = Rect.zero;

    // row item names
    for (int y = 0; y < board.getMaxLineLength(); y++) {
      var yInner = yInnerStart + y * heightInner + _lineOffset(y);
      rect = Rect.fromLTWH(xOuter, yInner, maxRowItemsWidth, heightInner);
      _touchCanvas.drawRect(rect, paintItemLine,
          onTapUp: (tapDetail) {onTapped(-1, y);}, onLongPressEnd: (tapDetail) {onLongTapped(-1, y);});
      _paintItemText(canvas, rect, board.logicalItems[board.blockIndex(y) + 1][board.blockLine(y)],
          fontSize, font_color);
    }

    // column item names
    canvas.save();
    canvas.rotate(-90 / 180 * pi);
    canvas.translate(-xInnerStart + blockMargin, yInnerStart);
    for (int x = 0; x < board.getLineLength(0) ; x++) {
      var blockIndex = board.blockIndex(x);
      //if (blockIndex == 1) continue;
      var xInner = x * widthInner + _lineOffset(x);
      rect = Rect.fromLTWH(0, xInner, maxRowItemsWidth, heightInner);
      if (x < board.itemsCount) {
        _touchCanvas.drawRect(rect, paintItemLine,
            onTapUp: (tapDetail) {onTapped(x, -1);}, onLongPressEnd: (tapDetail) {onLongTapped(x, -1);});
      }
      _paintItemText(canvas, rect,
          board.logicalItems[blockIndex < 1
              ? blockIndex
              : board.mapRowColumnBlockIndex(blockIndex)][board.blockLine(x)],
          fontSize, font_color);
    }
    canvas.restore();

    for (int y = 0; y < board.getMaxLineLength(); y++) {
      var yInner = yInnerStart + y * heightInner + _lineOffset(y);
      for (int x = 0; x < board.getLineLength(y); x++) {
        var xInner = xInnerStart + x * widthInner + _lineOffset(x);
        rect = Rect.fromLTWH(xInner, yInner, widthInner, heightInner);
        _touchCanvas.drawRect(rect, paintBackground,
            onTapUp: (tapDetail) {onTapped(x, y);}, onLongPressEnd: (tapDetail) {onLongTapped(x, y);});
        canvas.drawRect(rect, paintLine);
        var value = board.getValue(x, y);
        if (value != null) {
          _paintText(canvas, rect, value == Logical.plusValue ? '+' : '-',
              fontSize * 2, board.getFillType(x, y) == LogicPuzzleFillType.USER_FILLED ?  line_color : hint_line_color);
        }
      }
    }
  }

  double _lineOffset(int value) {
    return (value / board.itemsCount).floor() * blockMargin;
  }

  void _paintText(Canvas canvas, Rect rect, String text, double fontSize, Color color) {
    var textPainter = _buildTextPainter(text, color, fontSize);
    textPainter.paint(canvas, Offset(rect.topCenter.dx - textPainter.width * 0.5,
        rect.centerLeft.dy - textPainter.height * 0.5));
  }

  void _paintItemText(Canvas canvas, Rect rect, String text, double fontSize, Color color) {
    var textPainter = _buildTextPainter(text, color, fontSize);
    textPainter.paint(canvas, Offset(rect.left + itemTextOffsetStart,
        rect.centerLeft.dy - textPainter.height * 0.5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

double _maxRowItemsWidth(Logical board, double fontsize) {
  var maxWidth = 3 * boxSize - itemTextOffsetStart - itemTextOffsetEnd;
  for(var itemBlock = 0; itemBlock < board.logicalItems.length; itemBlock++) {
    if (itemBlock == 1) continue;
    maxWidth = max(maxWidth, _maxItemBlockWidth(board.logicalItems[itemBlock], fontsize));
  }
  return maxWidth + itemTextOffsetStart + itemTextOffsetEnd;
}

double _maxColumnItemsWidth(Logical board, double fontsize) {
  var maxWidth = 3 * boxSize - itemTextOffsetStart - itemTextOffsetEnd;
  for(var itemBlock = 1; itemBlock < board.logicalItems.length; itemBlock++) {
    maxWidth = max(maxWidth, _maxItemBlockWidth(board.logicalItems[itemBlock], fontsize));
  }
  return maxWidth + itemTextOffsetStart + itemTextOffsetEnd;
}

double _maxItemBlockWidth(List<String> itemBlock, double fontsize) {
  var maxWidth = 0.0;
  for(var item = 0; item < itemBlock.length; item++) {
    maxWidth = max(maxWidth, _buildTextPainter(itemBlock[item], Colors.black, fontsize).width);
  }
  return maxWidth;
}

TextPainter _buildTextPainter(String text, Color color, double fontsize) {
  TextSpan span = TextSpan(style: gcwTextStyle().copyWith(color: color, fontSize: fontsize), text: text);
  TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
  textPainter.layout();

  return textPainter;
}
