// https://github.com/maxogden/equatorial

import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/converter/dec.dart' as dec;
import 'package:intl/intl.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';


/// Right ascension to equatorial coordinate system
Equatorial raDegree2Time(RADEG ra) {
  if ((ra == null) || (ra.degress == null)) return null;
  var deg = ra.degress.abs();

  var hour = (deg / 15.0).floor();
  var min = (((deg / 15.0) - hour) * 60).floor();
  var sec = ((((deg / 15.0) - hour) * 60) - min) * 60;

  return Equatorial(_sign(ra.degress), hour, min, sec);
}

/// Right ascension hms to degree
RADEG raTime2Degree(Equatorial equatorial) {
  if (equatorial == null) return null;

  var h = equatorial.hours;
  var m = equatorial.minutes;
  var s = equatorial.seconds;

  var sDeg = (s / 240.0);
  var deg = (h * 15.0) + (m / 4.0) + sDeg;

  return RADEG(equatorial.sign * deg);
}

int _sign(double num) {
  return num < 0 ? -1 : 1;
}

/// equatorial coordinate system
class Equatorial {
  int sign;
  int hours;
  int minutes;
  double seconds;

  Equatorial(int neg, int hours , int min, double sec) {
    this.sign = neg;
    this.hours = hours.abs();
    this.minutes = min.abs();
    this.seconds = sec.abs();
  }

  static Equatorial parse (String input) {
    var regex = new RegExp(r"([+|-]?)([\d]*):([0-5]?[0-9]):([0-5]?[0-9])(\.\d*)*");
    if (input == null) return null;

    var matches = regex.allMatches(input);

    if (matches.length > 0) {
      return new Equatorial(
          (matches.first.group(1) == "-") ? -1 : 1,
          int.parse(matches.first.group(2)),
          int.parse(matches.first.group(3)),
          ((matches.first.group(5) == null) || matches.first.group(5).isEmpty)
              ? double.parse(matches.first.group(4))
              : double.parse(matches.first.group(4) + matches.first.group(5))
      );
    }
    else
      return null;
  }

  @override
  String toString() {
    var _hours = hours;
    var _minutes = minutes;
    var _secondsStr = '';
    var _secondsSplitted =  seconds.toString().split('.');

    if ((_secondsSplitted.length < 2) || (_secondsSplitted[1].length <= 10))
      _secondsStr = seconds.toString();
    else
      _secondsStr = NumberFormat('0.0' + '#' * 9).format(seconds);

    //Values like 59.999999999' may be rounded to 60.0. So in that case,
    //the degree has to be increased while minutes should be set to 0.0
    if (_secondsStr.startsWith('60')) {
      _secondsStr = '0';
      _minutes += 1;
    }
    if (_minutes == 60) {
      _minutes = 0;
      _hours += 1;
    }

    return (sign < 0 ? '-' : '') +
        _hours.toString() + ":" +
        _minutes.toString() + ":" +
        _secondsStr;
  }
}

class RADEG {
  double degress;

  RADEG(double degress) {
    this.degress = degress;
  }

  static RADEG parse(String input, {wholeString = false}) {
    input = dec.prepareInput(input, wholeString: wholeString);
    if (input == null) return null;

    RegExp regex = RegExp(_PATTERN_RADEG + regexEnd, caseSensitive: false);

    if (regex.hasMatch(input)) {
      var matches = regex.firstMatch(input);

      var latSign = dec.sign(matches.group(1));
      var latDegrees = 0.0;
      if (matches.group(3) != null)
        latDegrees = latSign * double.parse('${matches.group(2)}.${matches.group(3)}');
      else
        latDegrees = latSign * double.parse('${matches.group(2)}.0');

      return RADEG(latDegrees);
    }
    return null;
  }

  @override
  String toString([int precision]) {
    if (precision == null) precision = 10;
    if (precision < 1) precision = 1;

    String fixedDigits = '0' * min(precision, 3);
    String variableDigits = precision > 3 ? '#' * (precision - 3) : '';

    return '${NumberFormat('0.' + fixedDigits + variableDigits).format(degress)}';
  }

  static final _PATTERN_RADEG = '^\\s*?'
      '([\\+\\-])?\\s*?' //sign
      '(\\d{1,3})\\s*?' //degrees
      '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?' //millidegrees
      '[\\s°]?\\s*?'; //degree symbol
}
