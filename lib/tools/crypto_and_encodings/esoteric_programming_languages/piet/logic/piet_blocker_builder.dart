part of 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_language.dart';

const _knownColors = [
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

class _PietBlockerBuilder {
  // we if want to support custom colors and operations going forward
  // we'll need to allow extensions to add to this collection

  List<List<int>> _data;
  _PietBlock _block;
  var _blockCache = Map<Point<int>, _PietBlock>();
  int _width;
  int _height;

  _PietBlockerBuilder(List<List<int>> data) {
    _data = data;
    _width = _data.length;
    _height = _data[0].length;
  }

  _PietBlock _getBlockAt(int x, int y) {
    return _buildPietBlock(x, y);
  }

  _PietBlock _buildPietBlock(int x, int y) {
    var point = Point<int>(x, y);
    if (_blockCache.containsKey(point)) return _blockCache[point];
    int targetColor = _data[x][y];
    var knownColor = _knownColors.contains(targetColor);

    _block = _PietBlock(targetColor, knownColor);
    _buildPietBlockRec(x, y, targetColor);
    _blockCache.addAll({point: _block});

//     print("block: " + x.toString() + '/' + y.toString() + ' ' + _block.blockCount.toString() + " color: " + (targetColor).toString()); //_knownColors.indexOf(targetColor).toString()
    return _block;
  }

  // void _buildPietBlockRecX(int x, int y, int xOffset, int yOffset) {
  //   var newX = x + xOffset;
  //   var newY = y + yOffset;
  //   print("X: " +newX.toString() +" Y: "+newY.toString());
  //
  //   if (newX < 0 || newX >= _width || newY < 0 || newY >= _height) // out of bounds
  //     return;
  //
  //   var currentColor = _data[newY][newX];
  //   if (currentColor != _block.color) // colors don't match - you hit an edge
  //     return;
  //
  //   if (!_block.addPixel(Point<int>(newX, newY))) return;
  //
  //   // top
  //   if (yOffset != 1) _buildPietBlockRec(newX, newY, 0, -1);
  //
  //   // bottom
  //   if (yOffset != -1) _buildPietBlockRec(newX, newY, 0, 1);
  //
  //   // left
  //   if (xOffset != 1) _buildPietBlockRec(newX, newY, -1, 0);
  //
  //   // right
  //   if (xOffset != -1) _buildPietBlockRec(newX, newY, 1, 0);
  // }

  void _buildPietBlockRec(int x, int y, int currentColor) {
    var queue = Set<Point<int>>();
    queue.add(Point<int>(x, y));

    while (!queue.isEmpty) {
      var queuePixel = queue.last;
      queue.remove(queuePixel);
      _block.addPixel(queuePixel);
      x = queuePixel.x;
      y = queuePixel.y;

      _addIsValidBlock(x + 1, y, currentColor, queue);
      _addIsValidBlock(x, y + 1, currentColor, queue);
      _addIsValidBlock(x - 1, y, currentColor, queue);
      _addIsValidBlock(x, y - 1, currentColor, queue);
    }
  }

  Set<Point<int>> _addIsValidBlock(int x, int y, int color, Set<Point<int>> queue) {
    if (x < 0 || x >= _width || y < 0 || y >= _height) // out of bounds
      return queue;
    if (_data[x][y] == color && !_block.containsPixel(Point<int>(x, y)))
      queue.add(Point<int>(x, y));
    return queue;
  }
}
