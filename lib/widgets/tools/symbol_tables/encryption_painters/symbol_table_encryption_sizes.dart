import 'dart:math';

import 'package:flutter/material.dart';

enum SymbolTableEncryptionMode{FIXED_SYMBOLSIZE, FIXED_CANVASWIDTH}

class SymbolTableEncryptionSizes {
  int countImages;
  int countColumns;
  int countRows;
  double symbolWidth;
  double symbolHeight;
  double tileWidth;
  double tileHeight;
  double canvasWidth;
  double canvasHeight;
  // 0 - 1, percent of symbolsize
  double borderWidth;
  SymbolTableEncryptionMode mode;

  SymbolTableEncryptionSizes({
    @required
    this.countImages,
    @required
    this.countColumns,
    this.countRows,
    this.symbolWidth,
    this.symbolHeight,
    this.tileWidth,
    this.tileHeight,
    this.canvasWidth,
    this.canvasHeight,
    this.borderWidth,
    @required
    this.mode
  }) {
    _setCountRows();
    _setBorderWidth();
    _setTileSize();
    _setSymbolSize();
    _setCanvasWidth();
    _setCanvasHeight();
  }

  _setCountRows() {
    if (this.countColumns != null && this.countImages != null) {
      countRows = (countImages / countColumns).floor();
      if (countRows * countColumns < countImages)
        countRows++;
    }
  }

  _setBorderWidth() {
    if (borderWidth == null)
      borderWidth = 0.0;

    borderWidth = max(-0.9, borderWidth);
  }

  _setTileSize() {
    if (mode == SymbolTableEncryptionMode.FIXED_CANVASWIDTH) {
      tileWidth = canvasWidth / countColumns;
    } else {
      tileWidth = symbolWidth * (1 + borderWidth);
    }
    tileHeight = tileWidth;
  }

  _setSymbolSize() {
    if (mode == SymbolTableEncryptionMode.FIXED_CANVASWIDTH) {
      symbolWidth = tileWidth / (1 + borderWidth);
    }
  }

  _setCanvasWidth() {
    if (mode == SymbolTableEncryptionMode.FIXED_SYMBOLSIZE) {
      canvasWidth = tileWidth * countColumns;
    }
  }

  _setCanvasHeight() {
    canvasHeight = tileHeight * countRows;
  }
}