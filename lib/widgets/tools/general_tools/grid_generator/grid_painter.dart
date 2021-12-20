import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:touchable/touchable.dart';

enum GridMode {BOXES, GRID}
enum GridEnumerationStart {TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}
enum GridBoxEnumerationDirection {HORIZONTAL, VERTICAL}
enum GridBoxEnumerationBehaviour {STRAIGHT, ALTERNATED}
enum GridPaintColor {BLACK, WHITE, RED, YELLOW, GREEN, BLUE}

class GridPainter extends StatefulWidget {
  final GridMode mode;
  final int countRows;
  final int countColumns;
  final GridPaintColor tapColor;
  final List<String> boxEnumeration;
  final List<String> columnEnumeration;
  final List<String> rowEnumeration;
  final GridEnumerationStart enumerationStart;
  final GridBoxEnumerationBehaviour boxEnumerationBehaviour;
  final GridBoxEnumerationDirection boxEnumerationDirection;

  GridPainter({Key key,
    this.mode: GridMode.BOXES,
    this.countRows: 10,
    this.countColumns: 10,
    this.tapColor: GridPaintColor.BLACK,
    this.boxEnumeration: const [
      '1','2','3','4','5','6','7','8','9','10',
      '11','12','13','14','15','16','17','18','19','20',
      '21','22','23','24','25','26','27','28','29','30',
      '31','32','33','34','35','36','37','38','39','40',
      '41','42','43','44','45','46','47','48','49','50',
      '51','52','53','54','55','56','57','58','59','60',
      '61','62','63','64','65','66','67','68','69','70',
      '71','72','73','74','75','76','77','78','79','80',
      '81','82','83','84','85','86','87','88','89','90',
      '91','92','93','94','95','96','97','98','99','100',
    ],
    this.columnEnumeration: const ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'],
    this.rowEnumeration: const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
    this.enumerationStart: GridEnumerationStart.TOP_LEFT,
    this.boxEnumerationDirection: GridBoxEnumerationDirection.HORIZONTAL,
    this.boxEnumerationBehaviour: GridBoxEnumerationBehaviour.STRAIGHT,
    // @required
    // this.gridState
  }) : super(key: key);

  @override
  GridPainterState createState() => GridPainterState();
}

class GridPainterState extends State<GridPainter> {
  Map<int, Map<int, GridPaintColor>> gridState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CanvasTouchDetector(
                  builder: (context) {
                    return CustomPaint(
                      painter: CustomGridPainter(
                        context,
                        widget.mode,
                        widget.countRows,
                        widget.countColumns,
                        widget.tapColor,
                        widget.boxEnumeration,
                        widget.columnEnumeration,
                        widget.rowEnumeration,
                        widget.enumerationStart,
                        widget.boxEnumerationBehaviour,
                        widget.boxEnumerationDirection,
                        gridState,
                        (int i, int j) {
                          setState(() {
                            if (gridState == null)
                              gridState = <int, Map<int, GridPaintColor>>{};

                            if (gridState[i] == null) {
                              gridState[i] = <int, GridPaintColor>{};
                            }

                            var delete = gridState[i][j] == widget.tapColor;

                            if (i == 0 && j == 0) {
                              for (int k = 0; k <= widget.countRows; k++) {
                                for (int l = 0; l <= widget.countColumns; l++) {
                                  if (gridState[k] == null) {
                                    gridState[k] = <int, GridPaintColor>{};
                                    continue;
                                  }

                                  gridState[k].remove(l);

                                  if (!delete)
                                    gridState[k].putIfAbsent(l, () => widget.tapColor);
                                }
                              }

                              return;
                            }

                            if (i == 0) {
                              for (int k = 0; k <= widget.countRows; k++) {
                                if (gridState[k] == null) {
                                  gridState[k] = <int, GridPaintColor>{};
                                  continue;
                                }

                                gridState[k].remove(j);

                                if (!delete)
                                  gridState[k].putIfAbsent(j, () => widget.tapColor);
                              }

                              return;
                            }


                            if (j == 0) {
                              for (int l = 0; l <= widget.countColumns; l++) {
                                if (gridState[i] == null) {
                                  gridState[i] = <int, GridPaintColor>{};
                                  return;
                                }

                                gridState[i].remove(l);

                                if (!delete) {
                                  gridState[i].putIfAbsent(l, () => widget.tapColor);
                                }
                              }

                              return;
                            }

                            if (gridState[i] == null)
                              gridState[i] = <int, GridPaintColor>{};

                            gridState[i].remove(j);

                            if (!delete)
                              gridState[i].putIfAbsent(j, () => widget.tapColor);
                          });
                        }
                      )
                    );
                  }
                )
            )
        )
      ],
    );
  }
}

class CustomGridPainter extends CustomPainter {
  final BuildContext context;
  final GridMode mode;
  final int countRows;
  final int countColumns;
  final GridPaintColor tapColor;
  final List<String> boxEnumeration;
  final List<String> columnEnumeration;
  final List<String> rowEnumeration;
  final GridEnumerationStart enumerationStart;
  final GridBoxEnumerationBehaviour boxEnumerationBehaviour;
  final GridBoxEnumerationDirection boxEnumerationDirection;
  final Map<int, Map<int, GridPaintColor>> gridState;
  final Function(int, int) onTapped;

  CustomGridPainter(
    this.context,
    this.mode,
    this.countRows,
    this.countColumns,
    this.tapColor,
    this.boxEnumeration,
    this.columnEnumeration,
    this.rowEnumeration,
    this.enumerationStart,
    this.boxEnumerationBehaviour,
    this.boxEnumerationDirection,
    this.gridState,
    this.onTapped,
  );

  String _getEnumeration(int index) {
    if (mode == GridMode.BOXES) {
      if (boxEnumeration == null)
        return '';
      if (index >= boxEnumeration.length)
        return '';

      return boxEnumeration[index];
    }
  }

  _getColor(GridPaintColor gridColor) {
    switch (gridColor) {
      case GridPaintColor.BLACK: return Colors.black;
      case GridPaintColor.WHITE: return Colors.white;
      case GridPaintColor.RED: return Colors.red;
      case GridPaintColor.YELLOW: return Colors.yellow;
      case GridPaintColor.BLUE: return Colors.blue;
      case GridPaintColor.GREEN: return Colors.green;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);
    ThemeColors colors = themeColors();

    if (mode == GridMode.BOXES) {
      var paint = Paint();

      int _countRows = countRows + 1;
      int _countColumns = countColumns + 1;

      double boxWidth = size.width / _countColumns;
      double boxHeight = size.height / _countRows;

      var enumerationIndex = -1;
      for (int i = 0; i < _countRows; i++) {
        for (int j = 0; j < _countColumns; j++) {
          if (i > 0 && j > 0)
            enumerationIndex++;

          var x = j * boxWidth;
          var y = i * boxHeight;

          paint.color = gridState != null && gridState[i] != null && gridState[i][j] != null ? _getColor(gridState[i][j]) : colors.sudokuBackground();
          paint.style = PaintingStyle.fill;

          if (i == 0 || j == 0)
            paint.color = colors.sudokuBackground();

          _touchCanvas.drawRect(Rect.fromLTWH(x, y, boxWidth, boxHeight), paint,
              onTapDown: (tapDetail) {
                onTapped(i, j);
              }
          );

          paint.color = colors.accent();
          paint.strokeWidth = 1;

          _touchCanvas.drawLine(Offset(x, 0.0), Offset(x, size.width), paint);
          _touchCanvas.drawLine(Offset(0.0, y), Offset(size.height, y), paint);

          if (i == 0 || j == 0)
            continue;

          var enumerationText = _getEnumeration(enumerationIndex);
          if (enumerationText == null || enumerationText.isEmpty)
            continue;

          var textColor = colors.mainFont();

          TextSpan span = TextSpan(
              style: gcwTextStyle().copyWith(color: textColor, fontSize: boxHeight * _fontSize(enumerationText)),
              text: enumerationText);
          TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
          textPainter.layout();

          textPainter.paint(
              canvas,
              Offset(x + (boxWidth - textPainter.width) * 0.5, y + (boxHeight - textPainter.height) * 0.5));
        }
      }
    } else {

    }
  }

  _fontSize(String text) {
    var len = text.length;
    switch (len) {
      case 1: return 0.8;
      case 2: return 0.7;
      case 3: return 0.5;
      case 4: return 0.4;
      default: return 0.2;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
