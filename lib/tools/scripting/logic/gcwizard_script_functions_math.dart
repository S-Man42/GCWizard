part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

int _sgn(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
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

int _mod(Object x, Object y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  if (y == 0) {
    _handleError(DIVISIONBYZERO);
    return 0;
  }
  return ((x as int) % (y as int));
}

double _sqrt(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return sqrt(x as num);
}

double _sqr(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return ((x as num) * x) as double;
}

double _exp(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return exp(x as num);
}

double _sin(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return sin(x as num);
}

double _cos(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return cos(x as num);
}

double _tan(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return tan(x as num);
}

double _asin(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return asin(x as num);
}

double _acos(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return acos(x as num);
}

double _atan(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return atan(x as num);
}

double _deg(Object radian) {
  if (_isString(radian)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (radian as num) * 180 / pi;
}

double _rad(Object degree) {
  if (_isString(degree)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (degree as num) * pi / 180;
}

int _ceil(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as num).ceil();
}

int _floor(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as num).floor();
}

double _ln(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return log(x as num);
}

double _log10(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return log(x as num) / log(10);
}

double _pi() {
  return pi;
}

double _rnd(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }

  if (x != 0) {
    _randomNumber = _random.nextDouble();
  }
  return _randomNumber;
}

double _fac(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }

  double result = 1.0;
  for (int i = 1; i <= (x as int); i++) {
    result = result * i;
  }
  return result;
}

double _frac(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return ((x as num) - x.truncate()) as double;
}

double _trunc(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as num).truncate() as double;
}

double _abs(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as num).abs() as double;
}

double _pow(Object x, Object y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return pow(x as num, y as num) as double;
}

int _qsum(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  int result = 0;
  (x as int).toString().split('').forEach((digit) {
    result = result + int.parse(digit);
  });
  return result;
}

int _iqsum(Object x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
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

int _ggt(Object x, Object y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  int h;

  if (x as int == 0) return (y as int).abs();
  if (y as int == 0) return x.abs();

  do {
    h = (x as int) % (y as int);
    x = y;
    y = h;
  } while (y != 0);

  return x.abs();
}

int _kgv(Object x, Object y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }

  return (((x as int) * (y as int)).abs() / _ggt(x, y)) as int;
}

String _convert(Object value, Object startBase, Object destinationBase) {
  if (_isNotString(value) || _isString(startBase) || _isString(destinationBase)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  return convertBase(value as String, startBase as int, destinationBase as int);
}

