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
            // mode: GridMode.
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
                          color: Colors.black,
                          border: Border.all(color: themeColors().accent(), width: 5)
                      )
                          : BoxDecoration(
                          color: Colors.black,
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
                        color: Colors.white,
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: Colors.white,
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
                        color: Colors.red,
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: Colors.red,
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
                        color: Colors.yellow,
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: Colors.yellow,
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
                        color: Colors.blue,
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: Colors.blue,
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
                        color: Colors.green,
                        border: Border.all(color: themeColors().accent(), width: 5)
                    )
                        : BoxDecoration(
                        color: Colors.green,
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
