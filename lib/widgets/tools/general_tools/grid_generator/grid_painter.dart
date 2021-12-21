

import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:touchable/touchable.dart';

enum GridMode {BOXES, GRID, POINTS}
enum GridEnumerationStart {TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}
enum GridBoxEnumerationDirection {UP, DOWN, LEFT, RIGHT}
enum GridBoxEnumerationBehaviour {STRAIGHT, ALTERNATED, SPIRAL}
enum GridPaintColor {BLACK, WHITE, RED, YELLOW, GREEN, BLUE}

enum _TapMode {SINGLE, ROW, COLUMN, ALL}

final GRID_COLORS = {
  GridPaintColor.BLACK: {
    'color': Colors.black,
    'fontColor': Colors.white
  },
  GridPaintColor.WHITE: {
    'color': Colors.white,
    'fontColor': Colors.black
  },
  GridPaintColor.RED: {
    'color': Colors.red,
    'fontColor': Colors.black
  },
  GridPaintColor.YELLOW: {
    'color': Colors.yellow,
    'fontColor': Colors.black
  },
  GridPaintColor.BLUE: {
    'color': Colors.indigo,
    'fontColor': Colors.white
  },
  GridPaintColor.GREEN: {
    'color': Colors.green,
    'fontColor': Colors.black
  },
};

class GridPainter extends StatefulWidget {
  final GridMode mode;
  final int countRows;
  final int countColumns;
  final GridPaintColor tapColor;
  final List<String> boxEnumeration;
  final List<String> columnEnumeration;
  final List<String> rowEnumeration;
  final GridEnumerationStart boxEnumerationStart;
  final GridBoxEnumerationBehaviour boxEnumerationBehaviour;
  final GridBoxEnumerationDirection boxEnumerationStartDirection;

  GridPainter({Key key,
    this.mode: GridMode.BOXES,
    this.countRows: 2,
    this.countColumns: 2,
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
    this.boxEnumerationStart: GridEnumerationStart.BOTTOM_LEFT,
    this.boxEnumerationStartDirection: GridBoxEnumerationDirection.RIGHT,
    this.boxEnumerationBehaviour: GridBoxEnumerationBehaviour.SPIRAL,
    // @required
    // this.gridState
  }) : super(key: key);

  @override
  GridPainterState createState() => GridPainterState();
}

class GridPainterState extends State<GridPainter> {
  Map<int, Map<int, GridPaintColor>> gridState;
  List<String> _boxEnumeration;

  List<String> _fillBoxEnumeration() {
    List<List<String>> helper = List.generate(widget.countRows, (_) => List.generate(widget.countColumns, (_) => null));
    var boxEnumeration;
    if (widget.boxEnumeration.length > widget.countColumns * widget.countRows)
      boxEnumeration = widget.boxEnumeration.sublist(0, widget.countRows * widget.countColumns);
    else
      boxEnumeration = widget.boxEnumeration;

    var i = widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT || widget.boxEnumerationStart == GridEnumerationStart.TOP_RIGHT ? 0 : (widget.countRows - 1);
    var j = widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT || widget.boxEnumerationStart == GridEnumerationStart.BOTTOM_LEFT ? 0 : (widget.countColumns - 1);

    var currentDirection = widget.boxEnumerationStartDirection;

    var idx = 0;
    while (idx < boxEnumeration.length) {
      print('$i $j');
      helper[i][j] = widget.boxEnumeration[idx++];

      switch (currentDirection) {
        case GridBoxEnumerationDirection.UP:
          if (i > 0 && helper[i - 1][j] == null) {
            i--;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case GridBoxEnumerationBehaviour.STRAIGHT:
                if (widget.boxEnumerationStart == GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }

                i = widget.countRows - 1;
                break;
              case GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT || widget.boxEnumerationStart == GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }
                currentDirection = GridBoxEnumerationDirection.DOWN;
                break;
              case GridBoxEnumerationBehaviour.SPIRAL:
                if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
                  j++;
                  currentDirection = GridBoxEnumerationDirection.RIGHT;
                } else {
                  j--;
                  currentDirection = GridBoxEnumerationDirection.LEFT;
                }

                break;
            }
          };
          break;

        case GridBoxEnumerationDirection.DOWN:
          if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
            i++;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case GridBoxEnumerationBehaviour.STRAIGHT:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT) {
                  j++;
                } else {
                  j--;
                }

                i = 0;
                break;
              case GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT || widget.boxEnumerationStart == GridEnumerationStart.BOTTOM_LEFT) {
                  j++;
                } else {
                  j--;
                }
                currentDirection = GridBoxEnumerationDirection.UP;
                break;
              case GridBoxEnumerationBehaviour.SPIRAL:
                if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
                  j++;
                  currentDirection = GridBoxEnumerationDirection.RIGHT;
                } else {
                  j--;
                  currentDirection = GridBoxEnumerationDirection.LEFT;
                }

                break;
            }
          };
          break;

        case GridBoxEnumerationDirection.LEFT:
          if (j > 0 && helper[i][j - 1] == null) {
            j--;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case GridBoxEnumerationBehaviour.STRAIGHT:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }

                j = widget.countColumns - 1;
                break;
              case GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT || widget.boxEnumerationStart == GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }
                currentDirection = GridBoxEnumerationDirection.RIGHT;
                break;
              case GridBoxEnumerationBehaviour.SPIRAL:
                if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
                  i++;
                  currentDirection = GridBoxEnumerationDirection.DOWN;
                } else {
                  i--;
                  currentDirection = GridBoxEnumerationDirection.UP;
                }

                break;
            }
          };
          break;

        case GridBoxEnumerationDirection.RIGHT:
          if (j + 1 < widget.countColumns && helper[i][j + 1] == null) {
            j++;
          } else {
            switch (widget.boxEnumerationBehaviour) {
              case GridBoxEnumerationBehaviour.STRAIGHT:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT) {
                  i++;
                } else {
                  i--;
                }

                j = 0;
                break;
              case GridBoxEnumerationBehaviour.ALTERNATED:
                if (widget.boxEnumerationStart == GridEnumerationStart.TOP_LEFT || widget.boxEnumerationStart == GridEnumerationStart.TOP_RIGHT) {
                  i++;
                } else {
                  i--;
                }
                currentDirection = GridBoxEnumerationDirection.LEFT;
                break;
              case GridBoxEnumerationBehaviour.SPIRAL:
                if (i + 1 < widget.countRows && helper[i + 1][j] == null) {
                  i++;
                  currentDirection = GridBoxEnumerationDirection.DOWN;
                } else {
                  i--;
                  currentDirection = GridBoxEnumerationDirection.UP;
                }

                break;
            }
          };
          break;
      }
    }

    var output = <String>[];
    for (int i = 0; i < widget.countRows; i++) {
      for (int j = 0; j < widget.countColumns; j++) {
        output.add(helper[i][j]);
      }
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mode == GridMode.BOXES && _boxEnumeration == null) {
      _boxEnumeration = _fillBoxEnumeration();
    }

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
                        _boxEnumeration,
                        widget.columnEnumeration,
                        widget.rowEnumeration,
                        widget.boxEnumerationStart,
                        widget.boxEnumerationBehaviour,
                        widget.boxEnumerationStartDirection,
                        gridState,
                        (int i, int j, int countRows, int countColumns, _TapMode mode) {
                          setState(() {
                            if (gridState == null)
                              gridState = <int, Map<int, GridPaintColor>>{};

                            if (gridState[i] == null) {
                              gridState[i] = <int, GridPaintColor>{};
                            }

                            var delete = gridState[i][j] == widget.tapColor;

                            if (mode == _TapMode.ALL) {
                              for (int k = 0; k <= countRows; k++) {
                                for (int l = 0; l <= countColumns; l++) {
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

                            if (mode == _TapMode.COLUMN) {
                              for (int k = 0; k <= countRows; k++) {
                                if (gridState[k] == null) {
                                  gridState[k] = <int, GridPaintColor>{};
                                }

                                gridState[k].remove(j);

                                if (!delete)
                                  gridState[k].putIfAbsent(j, () => widget.tapColor);
                              }

                              return;
                            }


                            if (mode == _TapMode.ROW) {
                              for (int l = 0; l <= countColumns; l++) {
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
  final Function(int, int, int, int, _TapMode) onTapped;

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

  String _getEnumeration({int boxIndex, int columnIndex, int rowIndex}) {
    if (boxIndex != null) {
      if (boxEnumeration == null)
        return null;
      if (boxIndex >= boxEnumeration.length)
        return null;

      return boxEnumeration[boxIndex];
    } else if (columnIndex != null) {
      if (columnEnumeration == null)
        return null;
      if (columnIndex >= columnEnumeration.length)
        return null;

      return columnEnumeration[columnIndex];
    } else if (rowIndex != null) {
      if (rowEnumeration == null)
        return null;
      if (rowIndex >= rowEnumeration.length)
        return null;

      return rowEnumeration[rowIndex];
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = Paint();

    if (mode == GridMode.BOXES) {
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

          paint.color = gridState != null && gridState[i] != null && gridState[i][j] != null ? GRID_COLORS[gridState[i][j]]['color'] : themeColors().sudokuBackground();
          paint.style = PaintingStyle.fill;

          if (i == 0 || j == 0)
            paint.color = paint.color.withOpacity(0.0);

          _touchCanvas.drawRect(Rect.fromLTWH(x, y, boxWidth, boxHeight), paint,
              onTapDown: (tapDetail) {
                var mode;
                if (i == 0 && j == 0) {
                  mode = _TapMode.ALL;
                } else if (i == 0) {
                  mode = _TapMode.COLUMN;
                } else if (j == 0) {
                  mode = _TapMode.ROW;
                } else {
                  mode = _TapMode.SINGLE;
                }

                onTapped(i, j, _countRows, countColumns, mode);
              }
          );

          paint.color = themeColors().accent();
          paint.strokeWidth = 2;

          _touchCanvas.drawLine(Offset(x + boxWidth, 0.0), Offset(x + boxWidth, size.width), paint);
          _touchCanvas.drawLine(Offset(0.0, y + boxHeight), Offset(size.height, y + boxHeight), paint);

          if (i == 0 || j == 0)
            continue;

          /******************************************************************************/
          // Draw Text

          var enumerationText = _getEnumeration(boxIndex: enumerationIndex);
          if (enumerationText == null || enumerationText.isEmpty)
            continue;

          var textColor = themeColors().mainFont();

          var fontSize = 20.0;
          TextPainter textPainter;
          TextSpan span;
          do {
            fontSize -= 0.5;
            span = TextSpan(
                style: gcwTextStyle().copyWith(color: textColor, fontSize: fontSize),
                text: enumerationText);
            textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
            textPainter.layout();
          } while (textPainter.height > boxHeight * 0.9 || textPainter.width > boxWidth * 0.9);

          textPainter.paint(
              canvas,
              Offset(x + (boxWidth - textPainter.width) * 0.5, y + (boxHeight - textPainter.height) * 0.5));
        }
      }
    } else if (mode == GridMode.POINTS) {
      double _countRows = countRows + 0.5;
      double _countColumns = countColumns + 0.5;

      double boxWidth = size.width / _countColumns;
      double boxHeight = size.height / _countRows;

      paint.color = themeColors().accent();
      paint.strokeWidth = 2;

      for (int i = 0; i < _countRows - 1; i++) {
        for (int j = 0; j < _countColumns - 1; j++) {
          var x = j * boxWidth;
          var y = i * boxHeight;

          _touchCanvas.drawLine(Offset(x + boxWidth, boxHeight * 0.8), Offset(x + boxWidth, size.width - boxHeight / 2), paint);
          _touchCanvas.drawLine(Offset(boxWidth * 0.8, y + boxHeight), Offset(size.height - boxWidth / 2, y + boxHeight), paint);
        }
      }

      for (int i = 0; i < _countRows - 1; i++) {
        for (int j = 0; j < _countColumns - 1; j++) {
          var x = j * boxWidth;
          var y = i * boxHeight;

          /******************************************************************************/
          // Draw Text

          String enumerationTextColumn;
          String enumerationTextRow;
          if (i == 0) {
            enumerationTextColumn = _getEnumeration(columnIndex: j);
          } if (j == 0) {
            enumerationTextRow = _getEnumeration(rowIndex: i);
          }

          var textColor = themeColors().mainFont();

          if (enumerationTextColumn != null && enumerationTextColumn.isNotEmpty) {
            TextSpan span = TextSpan(
                style: gcwTextStyle().copyWith(color: textColor, fontSize: boxHeight * _fontSize(enumerationTextColumn.length + 1)),
                text: enumerationTextColumn);
            TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
            textPainter.layout();

            textPainter.paint(
                canvas,
                Offset(x + boxWidth - textPainter.width * 0.5, 0.0)
            );
          }

          paint.color = paint.color.withOpacity(0.0);

          _touchCanvas.drawRect(Rect.fromLTWH(x + boxWidth / 2, 0.0, boxWidth, boxHeight), paint,
            onTapDown: (tapDetail) {
              onTapped(i, j, countRows, countColumns, _TapMode.COLUMN);
            }
          );

          if (enumerationTextRow != null && enumerationTextRow.isNotEmpty) {
            var fontSize = 20.0;
            TextPainter textPainter;
            TextSpan span;
            do {
              fontSize -= 0.5;
              span = TextSpan(
                  style: gcwTextStyle().copyWith(color: textColor, fontSize: fontSize),
                  text: enumerationTextRow);
              textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
              textPainter.layout();
            } while (textPainter.height > boxHeight * 0.9 || textPainter.width > boxWidth * 0.9);

            textPainter.paint(
                canvas,
                Offset(0.0, y + boxHeight - textPainter.height * 0.5)
            );
          }

          paint.color = paint.color.withOpacity(0.0);

          _touchCanvas.drawRect(Rect.fromLTWH(0.0 / 2, y + boxHeight / 2, boxWidth, boxHeight), paint,
            onTapDown: (tapDetail) {
              onTapped(i, j, countRows, countColumns, _TapMode.ROW);
            }
          );
          /*************************************************************************/
        }
      }

      for (int i = 0; i < _countRows - 1; i++) {
        for (int j = 0; j < _countColumns - 1; j++) {
          var x = j * boxWidth;
          var y = i * boxHeight;

          paint.color = gridState != null && gridState[i] != null && gridState[i][j] != null ? GRID_COLORS[gridState[i][j]]['color'] : paint.color.withOpacity(0.0);;
          paint.style = PaintingStyle.fill;

          _touchCanvas.drawCircle(Offset(x + boxWidth, y + boxHeight), boxWidth * 0.4, paint,
              onTapDown: (tapDetail) {
                onTapped(i, j, countRows, countColumns, _TapMode.SINGLE);
              }
          );
        }
      }
    } else if (mode == GridMode.GRID) {
      double _countRows = countRows + 1.5;
      double _countColumns = countColumns + 1.5;

      double boxWidth = size.width / _countColumns;
      double boxHeight = size.height / _countRows;

      paint.color = themeColors().accent().withOpacity(0.1);
      paint.strokeWidth = 2;

      for (int i = 1; i < _countRows - 1; i++) {
        for (int j = 1; j < _countColumns - 1; j++) {
          var x = j * boxWidth;
          var y = i * boxHeight;

          _touchCanvas.drawLine(Offset(x + 0.75 * boxWidth, 0.75 * boxHeight), Offset(x + 0.75 * boxWidth, size.width - 0.75 * boxHeight), paint);
          _touchCanvas.drawLine(Offset(0.75 * boxWidth, y + 0.75 * boxHeight), Offset(size.height - boxWidth * 0.75, y + 0.75 * boxHeight), paint);
        }
      }

      for (int i = 0; i < (_countRows * 2 - 1); i++) {
        for (int j = 0; j < (_countColumns * 2 - 1); j++) {
          if ((i + j) % 2 == 0)
            continue;

          var x = j * boxWidth / 2;
          var y = i * boxHeight / 2;

          if (gridState != null && gridState[i] != null && gridState[i][j] != null) {
            paint.color = GRID_COLORS[gridState[i][j]]['color'];
            paint.style = PaintingStyle.stroke;
            paint.strokeWidth = 6;

            var path = Path();

            if (j % 2 == 0 && j > 0) {
              path.moveTo(x + boxWidth * 0.75 , y + boxHeight * 0.25);
              path.relativeLineTo(0.0, boxHeight);
            } else if (i % 2 == 0 && i > 0) {
              path.moveTo(x + boxWidth * 0.25, y + boxHeight * 0.75);
              path.relativeLineTo(boxWidth, 0.0);
            }

            _touchCanvas.drawPath(path, paint);
          }

          paint.style = PaintingStyle.fill;
          paint.color = paint.color.withOpacity(0.0);

          var mode =  _TapMode.SINGLE;

          var path = Path();
          if (j % 2 == 0 && j > 0) {
            path.moveTo(x + boxWidth * 0.75 , y + boxHeight * 0.25);

            if (i == 1) {
              path.relativeLineTo(boxWidth / 2, 0.0);
              path.relativeLineTo(0.0, boxHeight / 2);
              path.relativeLineTo(-boxWidth / 2, boxHeight / 2);
              path.relativeLineTo(-boxWidth / 2, -boxHeight / 2);
              path.relativeLineTo(0.0, -boxHeight / 2);
              path.relativeLineTo(boxWidth / 2, 0.0);
            } else {
              path.relativeLineTo(boxWidth / 2, boxHeight / 2);
              path.relativeLineTo(-boxWidth / 2, boxHeight / 2);
              path.relativeLineTo(-boxWidth / 2, -boxHeight / 2);
              path.relativeLineTo(boxWidth / 2, -boxHeight / 2);
            }
          } else if (i % 2 == 0 && i > 0) {
            path.moveTo(x + boxWidth * 0.25, y + boxHeight * 0.75);

            if (j == 1) {
              path.relativeLineTo(0.0, -boxHeight / 2);
              path.relativeLineTo(boxWidth / 2, 0.0);
              path.relativeLineTo(boxWidth / 2, boxHeight / 2);
              path.relativeLineTo(-boxWidth / 2, boxHeight / 2);
              path.relativeLineTo(-boxWidth / 2, 0.0);
              path.relativeLineTo(0.0, -boxHeight / 2);
            } else {
              path.relativeLineTo(boxWidth / 2, -boxHeight / 2);
              path.relativeLineTo(boxWidth / 2, boxHeight / 2);
              path.relativeLineTo(-boxWidth / 2, boxHeight / 2);
              path.relativeLineTo(-boxWidth / 2, -boxHeight / 2);
            }
          }

          _touchCanvas.drawPath(path, paint, onTapDown: (tapDetail) {
            if (j == 1) {
              mode = _TapMode.ROW;
            } else if (i == 1) {
              mode = _TapMode.COLUMN;
            }

            onTapped(i, j, countRows * 2 - 1, countColumns * 2 - 1, mode);
          });
        }
      }
    }
  }

  _fontSize(int textLength) {
    switch (textLength) {
      case 1: return 0.8;
      case 2: return 0.7;
      case 3: return 0.5;
      case 4: return 0.4;
      case 5: return 0.3;
      default: return 0.2;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
