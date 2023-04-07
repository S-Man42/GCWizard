part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

void _circle(dynamic x, dynamic y, dynamic r) {
  if (_isString(x) || _isString(y) || _isString(r)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('CIRCLE ' + x.toInt().toString() + ' ' + y.toInt().toString() + ' ' + r.toInt().toString());
}

void _line(dynamic x1, dynamic y1, dynamic x2, dynamic y2) {
  if (_isString(x1) || _isString(x2) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('LINE ' +
      x1.toInt().toString() +
      ' ' +
      y1.toInt().toString() +
      ' ' +
      x2.toInt().toString() +
      ' ' +
      y2.toInt().toString());
}

void _point(dynamic x, dynamic y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('POINT ' + x.toInt().toString() + ' ' + y.toInt().toString());
}

void _arc(dynamic x, dynamic y, dynamic r, dynamic a1, dynamic a2) {
  if (_isString(x) || _isString(y) || _isString(r) || _isString(a1) || _isString(a2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('ARC ' +
      x.toInt().toString() +
      ' ' +
      y.toInt().toString() +
      ' ' +
      r.toInt().toString() +
      ' ' +
      a1.toInt().toString() +
      ' ' +
      a2.toInt().toString());
}

void _pie(dynamic x, dynamic y, dynamic r, dynamic a1, dynamic a2) {
  if (_isString(x) || _isString(y) || _isString(r) || _isString(a1) || _isString(a2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('ARC ' +
      x.toInt().toString() +
      ' ' +
      y.toInt().toString() +
      ' ' +
      r.toInt().toString() +
      ' ' +
      a1.toInt().toString() +
      ' ' +
      a2.toInt().toString());
}

void _color(dynamic r, dynamic g, dynamic b) {
  if (_isString(r) || _isString(g) || _isString(b)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('COLOR ' + r.toInt().toString() + ' ' + g.toInt().toString() + ' ' + b.toInt().toString());
}

void _fill(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('FILL ' + x.toInt().toString());
}

void _stroke(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('STROKE ' + x.toInt().toString());
}

void _box(dynamic x1, dynamic y1, dynamic x2, dynamic y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('BOX ' +
      x1.toInt().toString() +
      ' ' +
      y1.toInt().toString() +
      ' ' +
      x2.toInt().toString() +
      ' ' +
      y2.toInt().toString());
}

void _text(dynamic t, dynamic x, dynamic y, dynamic s) {
  if (_isString(x) || _isString(y) || _isString(s)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  t = t.replaceAll(' ', '⟳');
  _graphics.add('TEXT ' + (t as String) + ' ' + x.toInt().toString() + ' ' + y.toInt().toString() + ' ' + s.toInt().toString());
}

void _oval(dynamic x1, dynamic y1, dynamic x2, dynamic y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('LINE ' +
      x1.toInt().toString() +
      ' ' +
      y1.toInt().toString() +
      ' ' +
      x2.toInt().toString() +
      ' ' +
      y2.toInt().toString());
}
