part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

int _sgn(dynamic x) {
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

int _mod(dynamic x, dynamic y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  if (y == 0) {
    _handleError(DIVISIONBYZERO);
    return 0;
  }
  return (x.toInt() % y.toInt()) as int;
}

double _sqrt(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return sqrt(x as num);
}

double _sqr(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return ((x as num) * x) as double;
}

double _exp(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return exp(x as num);
}

double _sin(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return sin(x as num);
}

double _cos(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return cos(x as num);
}

double _tan(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return tan(x as num);
}

double _asin(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return asin(x as num);
}

double _acos(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return acos(x as num);
}

double _atan(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return atan(x as num);
}

double _deg(dynamic radian) {
  if (_isString(radian)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (radian as num) * 180 / pi;
}

double _rad(dynamic degree) {
  if (_isString(degree)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (degree as num) * pi / 180;
}

int _ceil(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as num).ceil();
}

int _floor(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as num).floor();
}

double _ln(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return log(x as num);
}

double _log10(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return log(x as num) / log(10);
}

double _pi() {
  return pi;
}

double _rnd(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }

  if (x != 0) {
    _randomNumber = _random.nextDouble();
  }
  return _randomNumber;
}

double _fac(dynamic x) {
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

double _frac(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return ((x as num) - x.truncate()) as double;
}

double _trunc(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as num).truncate() as double;
}

double _abs(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return (x as num).abs() as double;
}

double _pow(dynamic x, dynamic y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  return pow(x as num, y as num) as double;
}

int _qsum(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  int result = 0;
  x.toInt().toString().split('').forEach((digit) {
    result = result + int.parse(digit);
  });
  return result;
}

int _iqsum(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }
  int result = 0;
  String number = x.toInt().toString();
  while (number.length > 1) {
    result = 0;
    number.split('').forEach((digit) {
      result = result + int.parse(digit);
    });
    number = result.toString();
  }

  return result;
}

int _ggt(dynamic x, dynamic y) {
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

int _kgv(dynamic x, dynamic y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return 0;
  }

  return (((x as int) * (y as int)).abs() / _ggt(x, y)).toInt();
}

String _convert(dynamic value, dynamic startBase, dynamic destinationBase) {
  if (_isNotString(value) || _isString(startBase) || _isString(destinationBase)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  return convertBase(value as String, startBase as int, destinationBase as int);
}

