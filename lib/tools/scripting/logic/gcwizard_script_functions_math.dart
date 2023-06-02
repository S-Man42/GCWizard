part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

int _sgn(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  if (x as num == 0) {
    return 0;
  } else if (x > 0) {
    return 1;
  } else {
    return -1;
  }
}

num _mod(Object? x, Object? y) {
  if (!_isNumber(x) || !_isNumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  if (y == 0) {
    _handleError(_DIVISIONBYZERO);
    return 0;
  }
  return ((x as num) % (y as num));
}

double _sqrt(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return sqrt(x as num);
}

double _sqr(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return ((x as num) * x) as double;
}

double _exp(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return exp(x as num);
}

double _sin(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return sin(x as num);
}

double _cos(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return cos(x as num);
}

double _tan(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return tan(x as num);
}

double _asin(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return asin(x as num);
}

double _acos(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return acos(x as num);
}

double _atan(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return atan(x as num);
}

double _deg(Object? radian) {
  if (!_isNumber(radian)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (radian as num) * 180 / pi;
}

double _rad(Object? degree) {
  if (!_isNumber(degree)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (degree as num) * pi / 180;
}

int _ceil(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as num).ceil();
}

int _floor(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as num).floor();
}

double _ln(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return log(x as num);
}

double _log10(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return log(x as num) / log(10);
}

double _pi() {
  return pi;
}

double _rnd(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }

  if (x != 0) {
    _randomNumber = _random.nextDouble();
  }
  return _randomNumber;
}

double _fac(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }

  double result = 1.0;
  for (int i = 1; i <= (x as num).toInt(); i++) {
    result *= i;
  }
  return result;
}

num _frac(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return ((x as num) - x.truncate());
}

int _trunc(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as num).truncate();
}

num _abs(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return (x as num).abs();
}

num _pow(Object? x, Object? y) {
  if (!_isNumber(x) || !_isNumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  return pow(x as num, y as num);
}

int _qsum(Object? x) {
  if (!_isInt(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  int result = 0;
  (x as int).toString().split('').forEach((digit) {
    result = result + int.parse(digit);
  });
  return result;
}

int _iqsum(Object? x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  int result = 0;
  String number = (x as int).toString();
  while (number.length > 1) {
    result = 0;
    number.split('').forEach((digit) {
      result = result + int.parse(digit);
    });
    number = result.toString();
  }

  return result;
}

int _ggt(Object? x, Object? y) {
  if (!_isNumber(x) || !_isNumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }
  int h;

  if (x as num == 0) return (y as num).toInt().abs();
  if (y as num == 0) return x.toInt().abs();

  do {
    h = (x as num).toInt() % (y as num).toInt();
    x = y;
    y = h;
  } while (y != 0);

  return x.toInt().abs();
}

num _kgv(Object? x, Object? y) {
  if (!_isNumber(x) || !_isNumber(y)) {
    _handleError(_INVALIDTYPECAST);
    return 0;
  }

  return (((x as num) * (y as num)).abs() / _ggt(x, y));
}

String _convert(Object? value, Object? startBase, Object? destinationBase) {
  if (!_isString(value) || !_isInt(startBase) || !_isInt(destinationBase)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  return convertBase(value as String, startBase as int, destinationBase as int);
}

