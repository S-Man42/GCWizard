part of 'package:gc_wizard/tools/games/logical_solver/widget/logical_solver.dart';

const boxSize = 20.0;
const fontSize = boxSize * 0.7;
const blockMargin = boxSize/ 2;
const itemTextOffsetStart = 3;
const itemTextOffsetEnd = 10;
Point<int>? _selectedBox;
Rect? _selectedBoxRect;
FocusNode? _valueFocusNode;

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
  late TextEditingController _currentInputController;
  final _currentValueFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _valueFocusNode = _currentValueFocusNode;
    _currentInputController = TextEditingController();
  }

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
                      gesturesToOverride: const [GestureType.onTapDown, GestureType.onTapUp, GestureType.onLongPressEnd], //ToDo onTapDown neccesery , GestureType.onTapDown
                      builder: (context) {
                        return CustomPaint(
                            painter: LogicPuzzleBoardPainter(context, widget.board, _showInputTextBox, _setState,
                                onTapped: widget.onTapped, onLongTapped: widget.onLongTapped)
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
    if (_selectedBoxRect != null && _selectedBox != null) {
      if (_selectedBox!.x < 0) {
        _currentInputController.text = widget.board.logicalItems[
            widget.board.blockIndex(_selectedBox!.y)][widget.board.blockLine(_selectedBox!.y)];
      } else if (_selectedBox!.y < 0) {
        _currentInputController.text = widget.board.logicalItems[
            widget.board.blockIndex(_selectedBox!.x)][widget.board.blockLine(_selectedBox!.x)];
      }
      _currentInputController.selection = TextSelection.collapsed(offset: _currentInputController.text.length);

      if (_selectedBoxRect!.height < 35) {
        var offset = (35 - _selectedBoxRect!.height) / 2;
        _selectedBoxRect = Rect.fromLTWH(_selectedBoxRect!.left - 2 * offset, _selectedBoxRect!.top - offset,
            _selectedBoxRect!.width + 4 * offset, _selectedBoxRect!.height + 2 * offset);
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
                  focusNode: _currentValueFocusNode,
                  style: TextStyle(
                    fontSize: _selectedBoxRect!.height * 0.5,
                    color: themeColors().mainFont(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (_selectedBox!.x < 0) {
                        widget.board.logicalItems[widget.board.blockIndex(_selectedBox!.y)]
                            [widget.board.blockLine(_selectedBox!.y)] = _currentInputController.text;
                      } else if (_selectedBox!.y < 0) {
                        widget.board.logicalItems[widget.board.blockIndex(_selectedBox!.x)]
                            [widget.board.blockLine(_selectedBox!.x)] = _currentInputController.text;
                      }
                    });
                  })));
    }
    return Container();
  }

  void _setState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void _showInputTextBox(Point<int>? showInputTextBox, Rect? selectedBoxRect) {
    setState(() {
      if (showInputTextBox != null) {
        _selectedBox = showInputTextBox;
        _selectedBoxRect = selectedBoxRect;
        _currentValueFocusNode.requestFocus();
      } else {
        _hideInputTextBox();
      }
    });
  }
}

void _hideInputTextBox() {
  _selectedBox = null;
  _selectedBoxRect = null;
  if (_valueFocusNode != null) {
    _valueFocusNode!.unfocus();
  }
}

class LogicPuzzleBoardPainter extends CustomPainter {
  final BuildContext context;
  final void Function(Point<int>?, Rect?) showInputTextBox;
  final void Function() setState;
  final Logical board;
  Color line_color = themeColors().secondary();
  Color hint_line_color = themeColors().switchThumb1();
  Color full_color = themeColors().secondary();
  Color background_color = themeColors().gridBackground();
  Color font_color = themeColors().mainFont();
  final void Function(int, int) onTapped;
  final void Function(int, int) onLongTapped;

  LogicPuzzleBoardPainter(this.context, this.board, this.showInputTextBox, this.setState,
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
    var paintTransparent= Paint();
    paintLine.strokeWidth = 1;
    paintLine.style = PaintingStyle.stroke;
    paintLine.color = line_color;

    paintItemLine.strokeWidth = 1;
    paintItemLine.style = PaintingStyle.stroke;
    paintItemLine.color = hint_line_color;

    paintBackground.style = PaintingStyle.fill;
    paintBackground.color = background_color;

    paintTransparent.color = Colors.transparent;
    paintTransparent.style = PaintingStyle.fill;


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

    rect = Rect.fromLTWH(0, 0, size.width, size.height);
    _touchCanvas.drawRect(rect, paintTransparent, onTapDown: (tapDetail) {
      if (_selectedBox != null) showInputTextBox(null, null);
    });

    // row item names
    for (int y = 0; y < board.getMaxLineLength(); y++) {
      var yInner = yInnerStart + y * heightInner + _lineOffset(y);
      rect = Rect.fromLTWH(xOuter, yInner, maxRowItemsWidth, heightInner);
      var rectTextBox = Rect.fromLTWH(xOuter, yInner - heightInner/2, maxRowItemsWidth * 2, heightInner * 2);
      var itemIndex = y + board.itemsCount;
      canvas.drawRect(rect, paintItemLine);
      _touchCanvas.drawRect(rect, paintTransparent,
          onTapUp: (tapDetail) {showInputTextBox(Point<int>(-1, itemIndex), rectTextBox);},
          onLongPressEnd: (tapDetail) {showInputTextBox(Point<int>(-1, itemIndex), rectTextBox);});
      _paintItemText(canvas, rect, board.logicalItems[board.blockIndex(itemIndex)][board.blockLine(itemIndex)],
          fontSize, font_color);
    }

    // column item names
    canvas.save();
    canvas.rotate(-90 / 180 * pi);
    canvas.translate(-xInnerStart + blockMargin, yInnerStart);
    for (int x = 0; x < board.getLineLength(0) ; x++) {
      var itemIndex = (board.blockIndex(x) < 1
          ? 0
          : (board.mapRowColumnBlockIndex(board.blockIndex(x)) + 1) )
          * board.itemsCount + board.blockLine(x);

      var xInner = x * widthInner + _lineOffset(x);
      rect = Rect.fromLTWH(0, xInner, maxRowItemsWidth, heightInner);
      var rectTextBox = Rect.fromLTWH(xOuter, xInner - heightInner/2, maxRowItemsWidth * 2, heightInner * 2);
      if (x < board.itemsCount) {
        canvas.drawRect(rect, paintItemLine);
        _touchCanvas.drawRect(rect, paintTransparent,
            onTapUp: (tapDetail) {showInputTextBox(Point<int>(itemIndex, -1), rectTextBox);},
            onLongPressEnd: (tapDetail) {showInputTextBox(Point<int>(itemIndex, -1), rectTextBox);});
      }
      _paintItemText(canvas, rect,
          board.logicalItems[board.blockIndex(itemIndex)][board.blockLine(itemIndex)], fontSize, font_color);
    }
    canvas.restore();

    for (int y = 0; y < board.getMaxLineLength(); y++) {
      var yInner = yInnerStart + y * heightInner + _lineOffset(y);
      for (int x = 0; x < board.getLineLength(y); x++) {
        var xInner = xInnerStart + x * widthInner + _lineOffset(x);
        rect = Rect.fromLTWH(xInner, yInner, widthInner, heightInner);
        _touchCanvas.drawRect(rect, paintBackground,
            onTapUp: (tapDetail) {if (_selectedBox == null) onTapped(x, y);},
            onLongPressEnd: (tapDetail) {if (_selectedBox == null) onLongTapped(x, y);});
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
