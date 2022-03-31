// https://github.com/maxogden/equatorial

import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/converter/dec.dart' as dec;
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:intl/intl.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';


/// degree to Right ascension
RightAscension raDegree2Time(RaDeg ra) {
  if ((ra == null) || (ra.degress == null)) return null;
  var deg = ra.degress.abs();

  var hour = (deg / 15.0).floor();
  var min = (((deg / 15.0) - hour) * 60).floor();
  var sec = ((((deg / 15.0) - hour) * 60) - min) * 60;

  return RightAscension(_sign(ra.degress), hour, min, sec);
}

/// Right ascension hms to degree
RaDeg raTime2Degree(RightAscension equatorial) {
  if (equatorial == null) return null;

  var h = equatorial.hours;
  var m = equatorial.minutes;
  var s = equatorial.seconds;

  var sDeg = (s / 240.0);
  var deg = (h * 15.0) + (m / 4.0) + sDeg;

  return RaDeg(equatorial.sign * deg);
}

int _sign(double num) {
  return num < 0 ? -1 : 1;
}

/// equatorial coordinate system
class RightAscension {
  int sign;
  int hours;
  int minutes;
  double seconds;

  RightAscension(int neg, int hours , int min, double sec) {
    this.sign = neg;
    this.hours = hours.abs();
    this.minutes = min.abs();
    this.seconds = sec.abs();
  }

  static RightAscension parse (String input) {
    var regex = new RegExp(r"([+|-]?)([\d]*):([0-5]?[0-9]):([0-5]?[0-9])(\.\d*)*");
    if (input == null) return null;

    var matches = regex.allMatches(input);

    if (matches.length > 0) {
      return new RightAscension(
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
    var hourFormat = hours +  (minutes / 60) + (seconds / 3600);

    return (sign < 0 ? '-' : '') + formatHoursToHHmmss(hourFormat, limitHours: false );
  }
}

class RaDeg {
  double degress;

  RaDeg(double degress) {
    this.degress = degress;
  }

  static RaDeg parse(String input, {wholeString = false}) {
    input = dec.prepareInput(input, wholeString: wholeString);
    if (input == null) return null;

    RegExp regex = RegExp(_PATTERN_RADEG + regexEnd, caseSensitive: false);

    if (regex.hasMatch(input)) {
      var matches = regex.firstMatch(input);

      var sign = dec.sign(matches.group(1));
      var degree = 0.0;
      if (matches.group(3) != null)
        degree = sign * double.parse('${matches.group(2)}.${matches.group(3)}');
      else
        degree = sign * double.parse('${matches.group(2)}.0');

      return RaDeg(degree);
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
