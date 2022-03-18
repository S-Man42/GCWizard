import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/converter/dec.dart' as dec;
import 'package:gc_wizard/logic/tools/coords/converter/dmm.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart' as coord;
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';



// Equatorial dmmPart2Hms(DMMPart dmmPart) {
//   var dmm = coord.DMM(coord.DMMLatitude(dmmPart.sign, dmmPart.degrees, dmmPart.minutes),
//       coord.DMMLongitude(1, 0, 0.0) );//
//   return raDeg2Hms(dmm.toLatLng().latitude);
// }


/// Right ascension to equatorial coordinate system
Equatorial raDeg2Hms(DEG ra) {
  if ((ra == null) || (ra.degress == null)) return null;
  var deg = ra.degress.abs();

  var hour = (deg / 15.0).floor();
  var min = (((deg / 15.0) - hour) * 60).floor();
  var sec = ((((deg / 15.0) - hour) * 60) - min) * 60;

  return Equatorial(_sign(ra), hour, min, sec);
}

/// right ascension hms to degrees
DEG raHms2Deg(Equatorial equatorial) {
  if (equatorial == null) return null;

  var h = equatorial.hours;
  var m = equatorial.minutes;
  var s = equatorial.seconds;

  var sDeg = (s / 240.0);
  var deg = (h * 15.0) + (m / 4.0) + sDeg;

  return DEG(equatorial.sign * deg);
}

int _sign(num) {
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
          matches.first.group(5).isEmpty
              ? matches.first.group(4)
              : double.parse(matches.first.group(4) + matches.first.group(5))
      );
    }
    else
      return null;
  }

  @override
  String toString() {
    var _seconds = '';
      var __seconds =  seconds.toString().split('.');
      if ((__seconds.length < 2) || (__seconds[1].length <= 10))
        _seconds = seconds.toString();
      else
        _seconds = NumberFormat('0.' + '0' * 10).format(seconds);


    return (sign < 0 ? '-' : '') +
        hours.toString() + ":" +
        minutes.toString() + ":" +
        _seconds;
  }
}

class DEG {
  double degress;

  DEG(double degress) {
    this.degress = degress;
  }

  static DEG parse(String input, {wholeString = false}) {
    input = dec.prepareInput(input, wholeString: wholeString);
    if (input == null) return null;

    RegExp regex = RegExp(PATTERN_DEC + regexEnd, caseSensitive: false);

    if (regex.hasMatch(input)) {
      var matches = regex.firstMatch(input);

      var latSign = dec.sign(matches.group(1));
      var latDegrees = 0.0;
      if (matches.group(3) != null) {
        latDegrees = latSign * double.parse('${matches.group(2)}.${matches.group(3)}');
      } else {
        latDegrees = latSign * double.parse('${matches.group(2)}.0');
      }

      return DEG(latDegrees);
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

  static final PATTERN_DEC = '^\\s*?'
      '([\\+\\-])?\\s*?' //sign
      '(\\d{1,3})\\s*?' //degrees
      '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?' //millidegrees
      '[\\s°]?\\s*?'; //degree symbol
}
