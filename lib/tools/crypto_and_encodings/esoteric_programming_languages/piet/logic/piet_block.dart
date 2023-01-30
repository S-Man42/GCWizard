part of 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/logic/piet_language.dart';

class _PietBlock {
  int _color = 0;

  int get color => _color;
  bool _knownColor = false;

  bool get knownColor => _knownColor;

  var _pixels = Set<Point<int>>();

  _PietBlock(int color, bool knownColor) {
    _color = color;
    _knownColor = knownColor;
  }

  int get blockCount => _pixels.length;

  bool addPixel(Point<int> point) {
    return _pixels.add(point);
  }

  bool containsPixel(Point<int> point) {
    return _pixels.contains(point);
  }

  Point get northLeft {
    var _point = _pixels.reduce((current, next) => (current.y < next.y) ? current : next);
    return _pixels.where((point) => point.y == _point.y).reduce((current, next) => (current.x < next.x) ? current : next);
  }

  Point get northRight {
    var _point = _pixels.reduce((current, next) => (current.y < next.y) ? current : next);
    return _pixels.where((point) => point.y == _point.y).reduce((current, next) => (current.x > next.x) ? current : next);
  }

  Point get eastLeft {
    var _point = _pixels.reduce((current, next) => (current.x > next.x) ? current : next);
    return _pixels.where((point) => point.x == _point.x).reduce((current, next) => (current.y < next.y) ? current : next);
  }

  Point get eastRight {
    var _point = _pixels.reduce((current, next) => (current.x > next.x) ? current : next);
    return _pixels.where((point) => point.x == _point.x).reduce((current, next) => (current.y > next.y) ? current : next);
  }

  Point get southLeft {
    var _point = _pixels.reduce((current, next) => (current.y > next.y) ? current : next);
    return _pixels.where((point) => point.y == _point.y).reduce((current, next) => (current.x > next.x) ? current : next);
  }

  Point get southRight {
    var _point = _pixels.reduce((current, next) => (current.y > next.y) ? current : next);
    return _pixels.where((point) => point.y == _point.y).reduce((current, next) => (current.x < next.x) ? current : next);
  }

  Point get westLeft {
    var _point = _pixels.reduce((current, next) => (current.x < next.x) ? current : next);
    return _pixels.where((point) => point.x == _point.x).reduce((current, next) => (current.y > next.y) ? current : next);
  }

  Point get westRight {
    var _point = _pixels.reduce((current, next) => (current.x < next.x) ? current : next);
    return _pixels.where((point) => point.x == _point.x).reduce((current, next) => (current.y < next.y) ? current : next);
  }
}


