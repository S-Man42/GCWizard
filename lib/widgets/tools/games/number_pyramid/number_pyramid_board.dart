import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:touchable/touchable.dart';

enum NumberPyramidFillType { USER_FILLED, CALCULATED }

class NumberPyramidBoard extends StatefulWidget {
  final NumberPyramidFillType type;
  final Function onChanged;
  final List<List<Map<String, dynamic>>> board;

  NumberPyramidBoard({Key key, this.onChanged, this.board, this.type: NumberPyramidFillType.CALCULATED})
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
                        if (value == null) {
                          widget.board[x][y] = null;
                          widget.onChanged(widget.board);
                          return;
                        }

                        widget.board[x][y] = {'value': value, 'type': NumberPyramidFillType.USER_FILLED};
                        widget.onChanged(widget.board);
                      });
                    }));
                  },
                )))
      ],
    );
  }
}

class NumberPyramidBoardPainter extends CustomPainter {
  final Function(int, int, int) setBoxValue;
  final List<List<Map<String, dynamic>>> board;
  final BuildContext context;
  final NumberPyramidFillType type;

  NumberPyramidBoardPainter(this.context, this.type, this.board, this.setBoxValue);

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    ThemeColors colors = themeColors();

    var paint = Paint();
    var paintBack = Paint();
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    paint.color = colors.accent();
    paintBack.style = PaintingStyle.fill;
    paintBack.color = colors.gridBackground();

    double widthOuter = size.width;
    double heightOuter = size.height;
    double xOuter = 0 * widthOuter;
    double yOuter = 0 * heightOuter;
    int rowCount =  this.board.length;
    double widthInner = widthOuter / rowCount;
    double heightInner = min(heightOuter / rowCount, widthInner / 2);

    for (int i = 0; i < rowCount; i++) {
      double xInner = (widthOuter + xOuter - (i+1) * widthInner) / 2;
      double yInner = yOuter + i * heightInner;

      for (int j = 0; j < i+1; j++) {
        var boardY = j;
        var boardX = i;

        _touchCanvas.drawRect(Rect.fromLTWH(xInner, yInner, widthInner, heightInner), paintBack,
            onTapDown: (tapDetail) {
              _removeCalculated(board);
              _showInputDialog(boardX, boardY);
            });

        _touchCanvas.drawRect(Rect.fromLTWH(xInner, yInner, widthInner, heightInner), paint);

        if (board[boardX][boardY] != null) {
          var textColor =
              board[boardX][boardY]['type'] == NumberPyramidFillType.USER_FILLED ? colors.accent() : colors.mainFont();

          TextSpan span = TextSpan(
              style: gcwTextStyle().copyWith(color: textColor, fontSize: heightInner * 0.8),
              text: board[boardX][boardY]['value'].toString());
          TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
          textPainter.layout();

          textPainter.paint(
              canvas,
              Offset(xInner + (widthInner - textPainter.width) * 0.5,
                  yInner + (heightInner - textPainter.height) * 0.5));
        }

        xInner += widthInner;
      }
    }
  }

  _removeCalculated(List<List<Map<String, dynamic>>> board) {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < i + 1; j++) {
        if (board[i][j] != null && board[i][j]['type'] == NumberPyramidFillType.CALCULATED) board[i][j] = null;
      }
    }
  }

  _showInputDialog(int x, y) {
    var columns = <Widget>[];
    int _value = 0;

    columns.add(
      Container(
        width: 100,
        height: 30,
        child:         GCWIntegerTextField(
            onChanged:  (ret) {
              _value = ret['value'];
            }
      )

    ));

    for (int i = 0; i < 3; i++) {
      var rows = <Widget>[];
      for (int j = 0; j < 3; j++) {
        var value = i * 3 + j + 1;

        rows.add(GCWButton(
          text: value.toString(),
          textStyle: gcwTextStyle().copyWith(fontSize: 32, color: themeColors().dialogText()),
          onPressed: () {
            _value = i * 3 + j + 1;
            // Navigator.of(context).pop();
            // setBoxValue(x, y, value);
          },
        ));
      }

      columns.add(Row(
        children: rows,
      ));
    }

    columns.add(GCWButton(
      text: i18n(context, 'sudokusolver_removevalue'),
      onPressed: () {
        Navigator.of(context).pop();
        setBoxValue(x, y, null);
      },
    ));

    columns.add(GCWButton(
      text: 'Enter',
      onPressed: () {
        Navigator.of(context).pop();
        setBoxValue(x, y, _value);
      },
    ));

    showGCWDialog(
        context,
        i18n(context, 'sudokusolver_entervalue'),
        Container(
          height: 300,
          child: Column(children: columns),
        ),
        []);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
