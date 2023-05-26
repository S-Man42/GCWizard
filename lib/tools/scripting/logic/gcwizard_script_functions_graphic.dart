part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

void _circle(Object x, Object y, Object r) {
  if (_isString(x) || _isString(y) || _isString(r)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('CIRCLE ' + (x as int).toString() + ' ' + (y as int).toString() + ' ' + (r as int).toString());
}

void _line(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(x2) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('LINE ' +
      (x1 as int).toString() +
      ' ' +
      (y1 as int).toString() +
      ' ' +
      (x2 as int).toString() +
      ' ' +
      (y2 as int).toString());
}

void _point(Object x, Object y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('POINT ' + (x as int).toString() + ' ' + (y as int).toString());
}

void _arc(Object x, Object y, Object r, Object a1, Object a2) {
  if (_isString(x) || _isString(y) || _isString(r) || _isString(a1) || _isString(a2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('ARC ' +
      (x as int).toString() +
      ' ' +
      (y as int).toString() +
      ' ' +
      (r as int).toString() +
      ' ' +
      (a1 as int).toString() +
      ' ' +
      (a2 as int).toString());
}

void _pie(Object x, Object y, Object r, Object a1, Object a2) {
  if (_isString(x) || _isString(y) || _isString(r) || _isString(a1) || _isString(a2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('ARC ' +
      (x as int).toString() +
      ' ' +
      (y as int).toString() +
      ' ' +
      (r as int).toString() +
      ' ' +
      (a1 as int).toString() +
      ' ' +
      (a2 as int).toString());
}

void _color(Object r, Object g, Object b) {
  if (_isString(r) || _isString(g) || _isString(b)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('COLOR ' + (r as int).toString() + ' ' + (g as int).toString() + ' ' + (b as int).toString());
}

void _fill(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('FILL ' + (x as int).toString());
}

void _stroke(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('STROKE ' + (x as int).toString());
}

void _box(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('BOX ' +
      (x1 as int).toString() +
      ' ' +
      (y1 as int).toString() +
      ' ' +
      (x2 as int).toString() +
      ' ' +
      (y2 as int).toString());
}

void _text(Object t, Object x, Object y, Object s) {
  if (_isString(x) || _isString(y) || _isString(s)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  t = (t as String).replaceAll(' ', '⟳');
  _graphics.add('TEXT ' + t + ' ' + (x as int).toString() + ' ' + (y as int).toString() + ' ' + (s as int).toString());
}

void _oval(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  _graphics.add('LINE ' +
      (x1 as int).toString() +
      ' ' +
      (y1 as int).toString() +
      ' ' +
      (x2 as int).toString() +
      ' ' +
      (y2 as int).toString());
}
