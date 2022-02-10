import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';

class SymbolTablePaintData {
  Canvas canvas;
  Size canvasSize;
  int countColumns;
  SymbolTableData data;
  List<int> imageIndexes;
  Function onCanvasChanged;
  // 0 - 1, percent of symbolsize
  double borderWidth;

  SymbolTablePaintData({
    this.canvas,
    this.canvasSize,
    this.countColumns,
    this.data,
    this.imageIndexes,
    this.onCanvasChanged,
    this.borderWidth
  });
}

class SymbolTableEncryptionPainter extends CustomPainter {
  final SymbolTablePaintData paintData;
  final Function paintFunction;

  const SymbolTableEncryptionPainter({this.paintData, this.paintFunction});

  @override
  void paint(Canvas canvas, Size size) {
    paintData.canvas = canvas;
    paintData.canvasSize = size;
    paintFunction(paintData);
  }

  @override
  bool shouldRepaint(SymbolTableEncryptionPainter oldDelegate) => true;
}