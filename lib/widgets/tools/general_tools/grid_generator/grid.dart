import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/tools/general_tools/grid_generator/grid_painter.dart';



class Grid extends StatefulWidget {
  @override
  GridState createState() => GridState();
}

class GridState extends State<Grid> {
  var _currentColor = GridPaintColor.RED;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: min(500, MediaQuery.of(context).size.height * 0.8)),
          child: GridPainter(
            tapColor: _currentColor,
            mode: GridMode.BOXES
            //
            // onChanged: (newBoard) {
            //   setState(() {
            //     _currentBoard = newBoard;
            //   });
            // },
          ),
        ),
        Row(
          children: [
            Expanded(
                child: InkWell(
                  child: Container(
                    height: 50,
                    decoration: _currentColor == GridPaintColor.BLACK
                      ? BoxDecoration(
                          color: GRID_COLORS[GridPaintColor.BLACK]['color'],
                          border: Border.all(color: themeColors().accent(), width: 5)
                      )
                          : BoxDecoration(
                          color: GRID_COLORS[GridPaintColor.BLACK]['color'],
                          border: Border.all(color: themeColors().mainFont(), width: 1.0)
                      ),
                    margin: EdgeInsets.only(right: DEFAULT_MARGIN),
                  ),
                  onTap: () {
                    setState(() {
                      _currentColor = GridPaintColor.BLACK;
                    });
                  },
                )
            ),
            Expanded(
                child: InkWell(
                  child: Container(
                    height: 50,
                    decoration: _currentColor == GridPaintColor.WHITE
                        ? BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.WHITE]['color'],
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.WHITE]['color'],
                        border: Border.all(color: themeColors().mainFont(), width: 1.0)
                    ),
                    margin : EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                  ),
                  onTap: () {
                    setState(() {
                      _currentColor = GridPaintColor.WHITE;
                    });
                  },
                )
            ),
            Expanded(
                child: InkWell(
                  child: Container(
                    height: 50,
                    decoration: _currentColor == GridPaintColor.RED
                        ? BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.RED]['color'],
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.RED]['color'],
                        border: Border.all(color: themeColors().mainFont(), width: 1.0)
                    ),
                    margin : EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                  ),
                  onTap: () {
                    setState(() {
                      _currentColor = GridPaintColor.RED;
                    });
                  },
                )
            ),
            Expanded(
                child: InkWell(
                  child: Container(
                    height: 50,
                    decoration: _currentColor == GridPaintColor.YELLOW
                        ? BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.YELLOW]['color'],
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.YELLOW]['color'],
                        border: Border.all(color: themeColors().mainFont(), width: 1.0)
                    ),
                    margin : EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                  ),
                  onTap: () {
                    setState(() {
                      _currentColor = GridPaintColor.YELLOW;
                    });
                  },
                )
            ),
            Expanded(
                child: InkWell(
                  child: Container(
                    height: 50,
                    decoration: _currentColor == GridPaintColor.BLUE
                        ? BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.BLUE]['color'],
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.BLUE]['color'],
                        border: Border.all(color: themeColors().mainFont(), width: 1.0)
                    ),
                    margin : EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                  ),
                  onTap: () {
                    setState(() {
                      _currentColor = GridPaintColor.BLUE;
                    });
                  },
                )
            ),
            Expanded(
                child: InkWell(
                  child: Container(
                    height: 50,
                    decoration: _currentColor == GridPaintColor.GREEN
                        ? BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.GREEN]['color'],
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: GRID_COLORS[GridPaintColor.GREEN]['color'],
                        border: Border.all(color: themeColors().mainFont(), width: 1.0)
                    ),
                    margin : EdgeInsets.only(left: DEFAULT_MARGIN),
                  ),
                  onTap: () {
                    setState(() {
                      _currentColor = GridPaintColor.GREEN;
                    });
                  },
                )
            ),
          ],
        )
      ],
    );
  }
}
