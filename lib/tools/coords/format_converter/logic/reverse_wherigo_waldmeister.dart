import 'dart:math';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/dec.dart';
import 'package:latlong2/latlong.dart';

const int _wLength = 6;

LatLng reverseWIGWaldmeisterToLatLon(ReverseWherigoWaldmeister waldmeister) {
  var a = waldmeister.a;
  var b = waldmeister.b;
  var c = waldmeister.c;

  int _latSign = 1;
  int _lonSign = 1;
  double _lon, _lat;

  if ((a % 1000 - a % 100) / 100 == 1) {
    _latSign = 1;
    _lonSign = 1;
  } else if ((a % 1000 - a % 100) / 100 == 2) {
    _latSign = -1;
    _lonSign = 1;
  } else if ((a % 1000 - a % 100) / 100 == 3) {
    _latSign = 1;
    _lonSign = -1;
  } else if ((a % 1000 - a % 100) / 100 == 4) {
    _latSign = -1;
    _lonSign = -1;
  }

  if ((_numberAtBackPosition(c, _wLength - 2) + _numberAtBackPosition(c, _wLength - 5)) % 2 == 0) {
    // a3 b5 . b2 c4 a1 c5 a6
    _lat = (_latSign *
        (_numberAtBackPosition(a, _wLength - 3) * 10 +
          _numberAtBackPosition(b, _wLength - 5) +
          _numberAtBackPosition(b, _wLength - 2) * 0.1 +
          _numberAtBackPosition(c, _wLength - 4) * 0.01 +
          _numberAtBackPosition(a, _wLength - 1) * 0.001 +
          _numberAtBackPosition(c, _wLength - 5) * 1.0E-4 +
          _numberAtBackPosition(a, _wLength - 6) * 1.0E-5));
    // a2 c1 c6 . b4 b1 a5 c2 b6
    _lon = (_lonSign *
        (_numberAtBackPosition(a, _wLength - 2) * 100 +
          _numberAtBackPosition(c, _wLength - 1) * 10 +
          _numberAtBackPosition(c, _wLength - 6) +
          _numberAtBackPosition(b, _wLength - 4) * 0.1 +
          _numberAtBackPosition(b, _wLength - 1) * 0.01 +
          _numberAtBackPosition(a, _wLength - 5) * 0.001 +
          _numberAtBackPosition(c, _wLength - 2) * 1.0E-4 +
          _numberAtBackPosition(b, _wLength - 6) * 1.0E-5));
  } else {
    // b1 a6 . a3 c1 c4 c5 a1
    _lat = (_latSign *
        (_numberAtBackPosition(b, _wLength - 1) * 10 +
          _numberAtBackPosition(a, _wLength - 6) +
          _numberAtBackPosition(a, _wLength - 3) * 0.1 +
          _numberAtBackPosition(c, _wLength - 1) * 0.01 +
          _numberAtBackPosition(c, _wLength - 4) * 0.001 +
          _numberAtBackPosition(c, _wLength - 5) * 1.0E-4 +
          _numberAtBackPosition(a, _wLength - 1) * 1.0E-5));
    // b5 c6 a5 . a2 b4 b6 c2 b2
    _lon = (_lonSign *
        (_numberAtBackPosition(b, _wLength - 5) * 100 +
          _numberAtBackPosition(c, _wLength - 6) * 10 +
          _numberAtBackPosition(a, _wLength - 5) +
          _numberAtBackPosition(a, _wLength - 2) * 0.1 +
          _numberAtBackPosition(b, _wLength - 4) * 0.01 +
          _numberAtBackPosition(b, _wLength - 6) * 0.001 +
          _numberAtBackPosition(c, _wLength - 2) * 1.0E-4 +
          _numberAtBackPosition(b, _wLength - 2) * 1.0E-5));
  }

  return decToLatLon(DEC(_lat, _lon));
}

ReverseWherigoWaldmeister latLonToReverseWIGWaldmeister(LatLng coord) {
  var _lat = coord.latitude;
  var _lon = coord.longitude;

  late double _a4, _b3, _c3, _tempb3, _tempc3;
  String a, b, c;

  if (_lat < 0 && _lon < 0) {
    _a4 = 4;
    _lat *= -1;
    _lon *= -1;
  } else if (_lat < 0 && _lon > 0) {
    _a4 = 2;
    _lat *= -1;
  } else if (_lat > 0 && _lon < 0) {
    _a4 = 3;
    _lon *= -1;
  } else if (_lat >= 0 && _lon >= 0) {
    _a4 = 1;
  }

  _lon = _lon + 1.0E-12;
  _lat = _lat + 1.0E-12;
  _lat = _lat * 100000 - _lat * 100000 % 1;
  _lon = _lon * 100000 - _lon * 100000 % 1;

  if ((((_lon % 100 - _lon % 10) / 10 + (_lat % 100 - _lat % 10) / 10) % 2) == 0) {
    _tempb3 = (11 -
        ((_lat % 1000 - _lat % 100) / 100 * 8 +
                (_lon % 100000000 - _lon % 10000000) / 10000000 * 6 +
                (_lat % 10000000 - _lat % 1000000) / 1000000 * 4 +
                _a4 * 2 +
                (_lon % 1000 - _lon % 100) / 100 * 3 +
                _lat % 10 * 5 +
                (_lon % 10000 - _lon % 1000) / 1000 * 9 +
                (_lat % 100000 - _lat % 10000) / 10000 * 7) %
            11);

    _b3 = _transformCheckSum(_tempb3);

    _tempc3 = (11 -
        ((_lon % 100000 - _lon % 10000) / 10000 * 8 +
                (_lat % 1000000 - _lat % 100000) / 100000 * 6 +
                _lon % 10 * 4 +
                (_lon % 10000000 - _lon % 1000000) / 1000000 * 2 +
                (_lon % 100 - _lon % 10) / 10 * 3 +
                (_lat % 10000 - _lat % 1000) / 1000 * 5 +
                (_lat % 100 - _lat % 10) / 10 * 9 +
                (_lon % 1000000 - _lon % 100000) / 100000 * 7) %
            11);

    _c3 = _transformCheckSum(_tempc3);

    a = ((_lat % 1000 - _lat % 100) ~/ 100).toString() +
        ((_lon % 100000000 - _lon % 10000000) ~/ 10000000).toString() +
        ((_lat % 10000000 - _lat % 1000000) ~/ 1000000).toString() +
        _a4.toInt().toString() +
        ((_lon % 1000 - _lon % 100) ~/ 100).toString() +
        (_lat % 10).toInt().toString();
    b = ((_lon % 10000 - _lon % 1000) ~/ 1000).toString() +
        ((_lat % 100000 - _lat % 10000) ~/ 10000).toString() +
        _b3.toInt().toString() +
        ((_lon % 100000 - _lon % 10000) ~/ 10000).toString() +
        ((_lat % 1000000 - _lat % 100000) ~/ 100000).toString() +
        (_lon % 10).toInt().toString();
    c = ((_lon % 10000000 - _lon % 1000000) ~/ 1000000).toString() +
        ((_lon % 100 - _lon % 10) ~/ 10).toString() +
        _c3.toInt().toString() +
        ((_lat % 10000 - _lat % 1000) ~/ 1000).toString() +
        ((_lat % 100 - _lat % 10) ~/ 10).toString() +
        ((_lon % 1000000 - _lon % 100000) ~/ 100000).toString();
  } else {
    _tempb3 = (11 -
        (_lat % 10 * 8 +
                (_lon % 100000 - _lon % 10000) / 10000 * 6 +
                (_lat % 100000 - _lat % 10000) / 10000 * 4 +
                _a4 * 2 +
                (_lon % 1000000 - _lon % 100000) / 100000 * 3 +
                (_lat % 1000000 - _lat % 100000) / 100000 * 5 +
                (_lat % 10000000 - _lat % 1000000) / 1000000 * 9 +
                _lon % 10 * 7) %
            11);

    _b3 = _transformCheckSum(_tempb3);

    _tempc3 = (11 -
        ((_lon % 10000 - _lon % 1000) / 1000 * 8 +
                (_lon % 100000000 - _lon % 10000000) / 10000000 * 6 +
                (_lon % 1000 - _lon % 100) / 100 * 4 +
                (_lat % 10000 - _lat % 1000) / 1000 * 2 +
                (_lon % 100 - _lon % 10) / 10 * 3 +
                (_lat % 1000 - _lat % 100) / 100 * 5 +
                (_lat % 100 - _lat % 10) / 10 * 9 +
                (_lon % 10000000 - _lon % 1000000) / 1000000 * 7) %
            11);

    _c3 = _transformCheckSum(_tempc3);

    a = (_lat % 10).toInt().toString() +
        ((_lon % 100000 - _lon % 10000) ~/ 10000).toString() +
        ((_lat % 100000 - _lat % 10000) ~/ 10000).toString() +
        _a4.toInt().toString() +
        ((_lon % 1000000 - _lon % 100000) ~/ 100000).toString() +
        ((_lat % 1000000 - _lat % 100000) ~/ 100000).toString();
    b = ((_lat % 10000000 - _lat % 1000000) ~/ 1000000).toString() +
        (_lon % 10).toInt().toString() +
        _b3.toInt().toString() +
        ((_lon % 10000 - _lon % 1000) ~/ 1000).toString() +
        ((_lon % 100000000 - _lon % 10000000) ~/ 10000000).toString() +
        ((_lon % 1000 - _lon % 100) ~/ 100).toString();
    c = ((_lat % 10000 - _lat % 1000) ~/ 1000).toString() +
        ((_lon % 100 - _lon % 10) ~/ 10).toString() +
        _c3.toInt().toString() +
        ((_lat % 1000 - _lat % 100) ~/ 100).toString() +
        ((_lat % 100 - _lat % 10) ~/ 10).toString() +
        ((_lon % 10000000 - _lon % 1000000) ~/ 1000000).toString();
  }

  return ReverseWherigoWaldmeister(int.parse(a), int.parse(b), int.parse(c));
}

double _transformCheckSum(double value) {
  if (value == 10) {
    return 0;
  } else if (value == 11) {
    return 5;
  } else {
    return value;
  }
}

ReverseWherigoWaldmeister? parseReverseWherigoWaldmeister(String input) {
  RegExp regExp = RegExp(r'^\s*(\d+)(\s*,\s*|\s+)(\d+)(\s*,\s*|\s+)(\d+)\s*$');
  var matches = regExp.allMatches(input);
  if (matches.isEmpty) return null;

  var match = matches.elementAt(0);

  if (match.group(1) == null || match.group(3) == null || match.group(5) == null) {
    return null;
  }

  var a = int.tryParse(match.group(1)!);
  var b = int.tryParse(match.group(3)!);
  var c = int.tryParse(match.group(5)!);

  if (a == null || b == null || c == null) return null;

  var waldmeister = ReverseWherigoWaldmeister(a, b, c);

  if (!_checkSumTest(waldmeister)) return null;
  return waldmeister;
}

bool _checkSumTest(ReverseWherigoWaldmeister waldmeister) {
  var a = waldmeister.a;
  var b = waldmeister.b;
  var c = waldmeister.c;
  var b3Calc = 0;
  var c3Calc = 0;

  var latlng = reverseWIGWaldmeisterToLatLon(waldmeister);
  var n = (latlng.latitude.abs() * 100000).round();
  var e = (latlng.longitude.abs() * 100000).round();

  const int _nLength = 7;
  const int _eLength = 8;


  if ((_numberAtBackPosition(c, _wLength - 2) + _numberAtBackPosition(c, _wLength - 5)) % 2 == 0) {
    //b3 = 11 – ((2*a4 + 4*n1 + 7*n3 + 8*n5 + 5*n7 + 6*e1 + 9*e5 + 3*e6) mod 11)
    b3Calc = 11 - ((
        2 * _numberAtBackPosition(a, _wLength - 4) +
        4 * _numberAtBackPosition(n, _nLength - 1) +
        7 * _numberAtBackPosition(n, _nLength - 3) +
        8 * _numberAtBackPosition(n, _nLength - 5) +
        5 * _numberAtBackPosition(n, _nLength - 7) +
        6 * _numberAtBackPosition(e, _eLength - 1) +
        9 * _numberAtBackPosition(e, _eLength - 5) +
        3 * _numberAtBackPosition(e, _eLength - 6)) % 11);
    //c3 = 11 – ((6*n2 + 5*n4 + 9*n6 + 2*e2 + 7*e3 + 8*e4 + 3*e7 + 4*e8) mod 11)
    c3Calc = 11 - ((
        6 * _numberAtBackPosition(n, _nLength - 2) +
        5 * _numberAtBackPosition(n, _nLength - 4) +
        9 * _numberAtBackPosition(n, _nLength - 6) +
        2 * _numberAtBackPosition(e, _eLength - 2) +
        7 * _numberAtBackPosition(e, _eLength - 3) +
        8 * _numberAtBackPosition(e, _eLength - 4) +
        3 * _numberAtBackPosition(e, _eLength - 7) +
        4 * _numberAtBackPosition(e, _eLength - 8)) % 11);
  } else {
    //b3 = 11 – ((2*a4 + 9*n1 + 5*n2 + 4*n3 + 8*n7 + 3*e3 + 6*e4 + 7*e8) mod 11)
    b3Calc = 11 - ((
        2 * _numberAtBackPosition(a, _wLength - 4) +
        9 * _numberAtBackPosition(n, _nLength - 1) +
        5 * _numberAtBackPosition(n, _nLength - 2) +
        4 * _numberAtBackPosition(n, _nLength - 3) +
        8 * _numberAtBackPosition(n, _nLength - 7) +
        3 * _numberAtBackPosition(e, _eLength - 3) +
        6 * _numberAtBackPosition(e, _eLength - 4) +
        7 * _numberAtBackPosition(e, _eLength - 8)) % 11);
    //c3 = 11 – ((2*n4 + 5*n5 + 9*n6 + 6*e1 + 7*e2 + 8*e5 + 4*e6 + 3*e7) mod 11)
    c3Calc = 11 - ((
        2 * _numberAtBackPosition(n, _nLength - 4) +
        5 * _numberAtBackPosition(n, _nLength - 5) +
        9 * _numberAtBackPosition(n, _nLength - 6) +
        6 * _numberAtBackPosition(e, _eLength - 1) +
        7 * _numberAtBackPosition(e, _eLength - 2) +
        8 * _numberAtBackPosition(e, _eLength - 5) +
        4 * _numberAtBackPosition(e, _eLength - 6) +
        3 * _numberAtBackPosition(e, _eLength - 7)) % 11);
  }
  b3Calc = _transformCheckSum(b3Calc.toDouble()).toInt();
  c3Calc = c3Calc == 10 ? 0 : c3Calc == 11 ? 5 : c3Calc;

  var b3Ref = _numberAtBackPosition(b, _wLength - 3);
  var c3Ref = _numberAtBackPosition(c, _wLength - 3);

  return b3Calc == b3Ref && c3Calc == c3Ref;
}

int _numberAtBackPosition(int number, int position) {
  return ((number % pow(10, position + 1) - number % pow(10, position)) / pow(10, position)).toInt();
}
