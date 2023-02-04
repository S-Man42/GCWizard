import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/tools/games/number_pyramid/logic/number_pyramid_solver.dart';
import 'package:touchable/touchable.dart';

Point<int> selectedBox;

class NumberPyramidBoard extends StatefulWidget {
  final NumberPyramidFillType type;
  final Function(int, int) showBoxValue;
  final Function onChanged;
  final NumberPyramid board;

  NumberPyramidBoard({Key key, this.onChanged, this.showBoxValue, this.board, this.type: NumberPyramidFillType.CALCULATED})
      : super(key: key);

  @override
  NumberPyramidBoardState createState() => NumberPyramidBoardState();
}

class NumberPyramidBoardState extends State<NumberPyramidBoard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: AspectRatio(
                aspectRatio: 1 / 0.5,
                child: CanvasTouchDetector(
                  gesturesToOverride: [GestureType.onTapDown],
                  builder: (context) {
                    return CustomPaint(
                      painter: NumberPyramidBoardPainter(context, widget.type, widget.board, (x, y, value) {
                          setState(() {
                            if (value == null)
                              widget.board.setValue(x, y, null, NumberPyramidFillType.CALCULATED);
                            else
                              widget.board.setValue(x, y, value, NumberPyramidFillType.USER_FILLED);

                            widget.onChanged(widget.board);
                          });
                        },
                        widget.showBoxValue)
                    );
                  },
                ))
        )
      ],
    );
  }
}

class NumberPyramidBoardPainter extends CustomPainter {
  final Function(int, int, int) setBoxValue;
  final Function(int, int) showBoxValue;
  final NumberPyramid board;
  final BuildContext context;
  final NumberPyramidFillType type;

  NumberPyramidBoardPainter(this.context, this.type, this.board, this.setBoxValue, this.showBoxValue);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    ThemeColors colors = themeColors();

    var paint = Paint();
    var paintBack = Paint();
    Rect selectedRect;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = colors.accent();
    paintBack.style = PaintingStyle.fill;
    paintBack.color = colors.gridBackground();

    const border = 2;
    double widthOuter = size.width - 2*border;
    double heightOuter = size.height - 2*border;
    double xOuter = border.toDouble();
    double yOuter = border.toDouble();
    double widthInner = widthOuter / board.getRowsCount();
    double heightInner = min(heightOuter /  board.getRowsCount(), widthInner / 2);

    for (int y = 0; y < board.getRowsCount(); y++) {
      double xInner = (widthOuter + xOuter - (y+1) * widthInner) / 2;
      double yInner = yOuter + y * heightInner;

      for (int x = 0; x < board.getColumnsCount(y); x++) {
        var boardY = y;
        var boardX = x;

        _touchCanvas.drawRect(Rect.fromLTWH(xInner, yInner, widthInner, heightInner), paintBack,
            onTapDown: (tapDetail) {
              selectedBox = Point<int>(boardX, boardY);
              showBoxValue(boardX, boardY);
            });

        if (selectedBox != null && selectedBox.x == x && selectedBox.y == y)
          selectedRect = Rect.fromLTWH(xInner, yInner, widthInner, heightInner);

        _touchCanvas.drawRect(Rect.fromLTWH(xInner, yInner, widthInner, heightInner), paint);

        if (board.getValue(boardX, boardY) != null) {
          var textColor =
              board.getType(boardX, boardY) == NumberPyramidFillType.USER_FILLED ? colors.accent() : colors.mainFont();

          var fontsize = heightInner * 0.8;
          var text = board.getValue(boardX, boardY).toString();
          var textPainter = _buildTextPainter(text, textColor, fontsize);

          while (textPainter.width > widthInner) {
            fontsize *= 0.95;
            if (fontsize < heightInner * 0.8 * 0.5) { // min. 50% fontsize
              if (text == null || text.length < 2) break;
              var splitPos = (text.length / 2).ceil();
              text = text.substring(0, splitPos) + '\n' + text.substring(splitPos);
              textPainter = _buildTextPainter(text, textColor, fontsize);
              break;
            }

            textPainter = _buildTextPainter(text, textColor, fontsize);
          }

          textPainter.paint(
              canvas,
              Offset(xInner + (widthInner  - textPainter.width) * 0.5,
                     yInner + (heightInner - textPainter.height) * 0.5));
        }

        xInner += widthInner;
      }
    }

    if (selectedRect != null) {
      paint.color = colors.focused();
      _touchCanvas.drawRect(selectedRect, paint);
    }
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
