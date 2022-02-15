import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_paint_data.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_sizes.dart';

class SymbolTableEncryption {
  @override
  SymbolTableEncryptionSizes sizes(SymbolTableEncryptionSizes sizes) {
    return sizes;
  }

  @override
  Canvas paint(SymbolTablePaintData paintData) {
    var countColumns = paintData.sizes.countColumns;
    var canvas = paintData.canvas;
    var data = paintData.data;
    var imageIndexes = paintData.imageIndexes;
    var _sizes = paintData.sizes;

    var countRows = _sizes.countRows;
    var absBorderWidth = _sizes.symbolWidth * _sizes.borderWidth;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;


    var maxRect = Rect.fromLTWH(0, 0, _sizes.canvasWidth, _sizes.canvasHeight);
    canvas.clipRect(maxRect);
    canvas.drawRect(maxRect, paint);

    var tileSize = _sizes.tileWidth;
    var symbolSize = _sizes.symbolWidth;

    for (var i = 0; i <= countRows; i++) {
      for (var j = 0; j < countColumns; j++) {
        var imageIndex = i * countColumns + j;

        if (imageIndex < imageIndexes.length) {
          if (imageIndexes[imageIndex] != null) {
            var image = data.images[imageIndexes[imageIndex]].values.first.standardImage;

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
}