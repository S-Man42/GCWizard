import 'dart:math';

class PietBlock {
  int _Color = 0;
  int get Color => _Color;
  bool _KnownColor = false;
  bool get KnownColor => _KnownColor;

  List<Point> _pixels;

  PietBlock(int color, bool knownColor) {
    _Color = color;
    _KnownColor = knownColor;
    _pixels = <Point>[];
  }

  int get BlockCount => _pixels.length;

  bool AddPixel(int x, int y) {
    if (ContainsPixel(Point<int>(x, y))) return false;

    _pixels.add(Point<int>(x, y));
    return true;
  }

  bool ContainsPixel(Point<int> point) {
    return _pixels.contains(point);
  }

  Point get NorthLeft => _pixels.reduce((current, next) => ((current.y < next.y) || ((current.y == next.y) && current.x < next.x)) ? current : next); //.orderBy(p => p.Y).ThenBy(p => p.X).First();

  Point get NorthRight  => _pixels.reduce((current, next) => ((current.y < next.y) || ((current.y == next.y) && current.x > next.x)) ? current : next); //.OrderBy(p => p.Y).ThenByDescending(p => p.X).First();

  Point get EastLeft  => _pixels.reduce((current, next) => ((current.x > next.x) || ((current.x == next.x) && current.y < next.y)) ? current : next); //.OrderByDescending(p => p.X).ThenBy(p => p.Y).First();

  Point get EastRight => _pixels.reduce((current, next) => ((current.x > next.x) || ((current.x == next.x) && current.y > next.y)) ? current : next); //.OrderByDescending(p => p.X).ThenByDescending(p => p.Y).First();

  Point get SouthLeft => _pixels.reduce((current, next) => ((current.y > next.y) || ((current.y == next.y) && current.x > next.x)) ? current : next); //.OrderByDescending(p => p.Y).ThenByDescending(p => p.X).First();

  Point get SouthRight => _pixels.reduce((current, next) => ((current.y > next.y) || ((current.y == next.y) && current.x < next.x)) ? current : next); //.OrderByDescending(p => p.Y).ThenBy(p => p.X).First();

  Point get WestLeft  => _pixels.reduce((current, next) => ((current.x < next.x) || ((current.x == next.x) && current.y > next.y)) ? current : next); //.OrderBy(p => p.X).ThenByDescending(p => p.Y).First();

  Point get WestRight => _pixels.reduce((current, next) => ((current.x < next.x) || ((current.x == next.x) && current.y < next.y)) ? current : next); //.OrderBy(p => p.X).ThenBy(p => p.Y).First();
}

