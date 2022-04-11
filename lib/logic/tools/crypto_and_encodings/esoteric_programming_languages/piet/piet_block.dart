import 'dart:math';

class PietBlock {
  int _color = 0;
  int get color => _color;
  bool _knownColor = false;
  bool get KnownColor => _knownColor;

  List<Point> _pixels;

  PietBlock(int color, bool knownColor) {
    _color = color;
    _knownColor = knownColor;
    _pixels = <Point>[];
  }

  int get blockCount => _pixels.length;

  bool addPixel(int x, int y) {
    if (containsPixel(Point<int>(x, y))) return false;

    _pixels.add(Point<int>(x, y));
    return true;
  }

  bool containsPixel(Point<int> point) {
    return _pixels.contains(point);
  }

  Point get northLeft => _pixels.reduce((current, next) => ((current.y < next.y) || ((current.y == next.y) && current.x < next.x)) ? current : next);

  Point get northRight  => _pixels.reduce((current, next) => ((current.y < next.y) || ((current.y == next.y) && current.x > next.x)) ? current : next);

  Point get eastLeft  => _pixels.reduce((current, next) => ((current.x > next.x) || ((current.x == next.x) && current.y < next.y)) ? current : next);

  Point get eastRight => _pixels.reduce((current, next) => ((current.x > next.x) || ((current.x == next.x) && current.y > next.y)) ? current : next);

  Point get southLeft => _pixels.reduce((current, next) => ((current.y > next.y) || ((current.y == next.y) && current.x > next.x)) ? current : next);

  Point get southRight => _pixels.reduce((current, next) => ((current.y > next.y) || ((current.y == next.y) && current.x < next.x)) ? current : next);

  Point get westLeft  => _pixels.reduce((current, next) => ((current.x < next.x) || ((current.x == next.x) && current.y > next.y)) ? current : next);

  Point get westRight => _pixels.reduce((current, next) => ((current.x < next.x) || ((current.x == next.x) && current.y < next.y)) ? current : next);
}

