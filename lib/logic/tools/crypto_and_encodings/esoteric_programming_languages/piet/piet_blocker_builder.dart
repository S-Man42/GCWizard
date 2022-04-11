import 'dart:core';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_block.dart';

final knownColors = { //format BBGGRR (not RGB)
  // reds
  0xC0C0FF, // light
  0x0000FF,
  0x0000C0, //dark
  // yellows
  0xC0FFFF,
  0x00FFFF,
  0x00C0C0,
  // greens
  0xC0FFC0,
  0x00FF00,
  0x00C000,
  // cyans
  0xFFFFC0,
  0xFFFF00,
  0xC0C000,
  // blues
  0xFFC0C0,
  0xFF0000,
  0xC00000,
  // magentas
  0xFFC0FF,
  0xFF00FF,
  0xC000C0,
  // white
  0xFFFFFF,
  // black
  0x000000
}.toList();

class PietBlockerBuilder {
  // we if want to support custom colors and operations going forward
  // we'll need to allow extensions to add to this collection

  List<List<int>> _data;
  int _width;
  int _height;

  PietBlockerBuilder(List<List<int>> data) {
    _data = data;
    _width = _data[0].length;
    _height = _data.length;
  }

  PietBlock GetBlockAt(int x, int y) {
    return _BuildPietBlock(x, y);
  }

  PietBlock _BuildPietBlock(int x, int y) {
    int targetColor = _data[y][x];
    var knownColor = knownColors.contains(targetColor);
    PietBlock block = PietBlock(targetColor, knownColor);

    return BuildPietBlockRec(block, x, y, 0, 0);
  }

  PietBlock BuildPietBlockRec(PietBlock block, int x, int y, int xOffset, int yOffset) {
    var newX = x + xOffset;
    var newY = y + yOffset;

    if (newX < 0 || newX >= _width || newY < 0 || newY >= _height) // out of bounds
      return block;

    var currentColor = _data[newY][newX];
    if (currentColor != block.Color) // colors don't match - you hit an edge
      return block;

    // int countBefore = block.BlockCount;
    if (!block.AddPixel(newX, newY)) return block;

    // top
    if (yOffset != 1) BuildPietBlockRec(block, newX, newY, 0, -1);

    // bottom
    if (yOffset != -1) BuildPietBlockRec(block, newX, newY, 0, 1);

    // left
    if (xOffset != 1) BuildPietBlockRec(block, newX, newY, -1, 0);

    // right
    if (xOffset != -1) BuildPietBlockRec(block, newX, newY, 1, 0);

    return block;
  }
}

