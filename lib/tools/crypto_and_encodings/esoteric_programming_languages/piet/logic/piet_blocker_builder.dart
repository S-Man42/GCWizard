import 'dart:core';
import 'dart:math';

import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_block.dart';

const knownColors = [
  //format RGB
  // reds
  0xFFC0C0, // light
  0xFF0000,
  0xC00000, //dark
  // yellows
  0xFFFFC0,
  0xFFFF00,
  0x0C0C000,
  // greens
  0xC0FFC0,
  0x00FF00,
  0x00C000,
  // cyans
  0xC0FFFF,
  0x00FFFF,
  0x00C0C0,
  // blues
  0xC0C0FF,
  0x0000FF,
  0x0000C0,
  // magentas
  0xFFC0FF,
  0xFF00FF,
  0xC000C0,
  // white
  0xFFFFFF,
  // black
  0x000000
];

class PietBlockerBuilder {
  // we if want to support custom colors and operations going forward
  // we'll need to allow extensions to add to this collection

  List<List<int>> _data;
  PietBlock _block;
  var _blockCache = Map<Point<int>, PietBlock>();
  int _width;
  int _height;

  PietBlockerBuilder(List<List<int>> data) {
    _data = data;
    _width = _data[0].length;
    _height = _data.length;
  }

  PietBlock getBlockAt(int x, int y) {
    return _buildPietBlock(x, y);
  }

  PietBlock _buildPietBlock(int x, int y) {
    var point = Point<int>(x, y);
    if (_blockCache.containsKey(point)) return _blockCache[point];
    int targetColor = _data[y][x];
    var knownColor = knownColors.contains(targetColor);

    _block = PietBlock(targetColor, knownColor);
    _buildPietBlockRec(x, y, 0, 0);
    _blockCache.addAll({point: _block});

    return _block;
  }

  void _buildPietBlockRec(int x, int y, int xOffset, int yOffset) {
    var newX = x + xOffset;
    var newY = y + yOffset;

    if (newX < 0 || newX >= _width || newY < 0 || newY >= _height) // out of bounds
      return;

    var currentColor = _data[newY][newX];
    if (currentColor != _block.color) // colors don't match - you hit an edge
      return;

    if (!_block.addPixel(Point<int>(newX, newY))) return;

    // top
    if (yOffset != 1) _buildPietBlockRec(newX, newY, 0, -1);

    // bottom
    if (yOffset != -1) _buildPietBlockRec(newX, newY, 0, 1);

    // left
    if (xOffset != 1) _buildPietBlockRec(newX, newY, -1, 0);

    // right
    if (xOffset != -1) _buildPietBlockRec(newX, newY, 1, 0);
  }
}
