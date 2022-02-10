import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_paint_data.dart';

Canvas paintSymbolTableEncryptionDefault(SymbolTablePaintData paintData) {
  var countColumns = paintData.countColumns;
  var canvas = paintData.canvas;
  var data = paintData.data;
  var imageIndexes = paintData.imageIndexes;
  var borderWidth = max(-0.9, paintData.borderWidth ?? 0.0);
  var canvasSize = paintData.canvasSize;

  var countRows = (imageIndexes.length / countColumns).floor();
  if (countRows * countColumns < imageIndexes.length)
    countRows++;

  var tileSize = canvasSize.width / countColumns;
  var symbolSize = tileSize / (1 + borderWidth);
  var absBorderWidth = symbolSize * borderWidth;

  final paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  var maxRect = Rect.fromLTWH(0, 0, canvasSize.width, canvasSize.height);
  canvas.clipRect(maxRect);
  canvas.drawRect(maxRect, paint);

  for (var i = 0; i <= countRows; i++) {
    for (var j = 0; j < countColumns; j++) {
      var imageIndex = i * countColumns + j;

      if (imageIndex < imageIndexes.length) {
        if (imageIndexes[imageIndex] != null) {
          var image = data.images[imageIndexes[imageIndex]].values.first.drawableImage;

          paintImage(
              canvas: canvas,
              fit: BoxFit.contain,
              rect: Rect.fromLTWH(j * tileSize + absBorderWidth / 2, i * tileSize + absBorderWidth / 2, symbolSize, symbolSize),
              image: image);
        }
      }
    }
  }

  return canvas;
}