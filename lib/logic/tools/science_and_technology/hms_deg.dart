import 'package:gc_wizard/logic/tools/coords/converter/dec.dart' as dec;
import 'package:gc_wizard/logic/tools/coords/converter/dmm.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart' as coord;
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';



Equatorial dmmPart2Hms(DMMPart dmmPart) {
  var dmm = coord.DMM(coord.DMMLatitude(dmmPart.sign, dmmPart.degrees, dmmPart.minutes),
      coord.DMMLongitude(1, 0, 0.0) );//
  return raDeg2Hms(dmm.toLatLng().latitude);
}

/// Right ascension to equatorial coordinate system
Equatorial raDeg2Hms(double ra) {
  if (ra == null) return null;
  var deg = ra.abs();

  var hour = (deg / 15.0).floor();
  var min = (((deg / 15.0) - hour) * 60).floor();
  var sec = ((((deg / 15.0) - hour) * 60) - min) * 60;

  return Equatorial(_sign(ra), hour, min, sec);
}

/// right ascension hms to degrees
double raHms2Deg(Equatorial equatorial) {
  if (equatorial == null) return null;

  var h = equatorial.hours;
  var m = equatorial.minutes;
  var s = equatorial.seconds;

  var sDeg = (s / 240.0);
  var deg = (h * 15.0) + (m / 4.0) + sDeg;

  return equatorial.sign * deg;
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
    return (sign < 0 ? '-' : '') +
        hours.toString() + ":" +
        minutes.toString() + ":" +
        seconds.toString();
  }
}

class DMMPart extends coord.DMMPart {

  static DMMPart fromDeg(double deg) {
    var lat = latLonToDMM(LatLng(deg, 0)).latitude;
    return DMMPart(lat.sign, lat.degrees, lat.minutes);
  }

  DMMPart(sign, degrees, minutes) : super(sign, degrees, minutes);

  String _dmmPartNumberFormat([int precision = 6]) {
    var formatString = '00.';
    if (precision == null) precision = 6;
    if (precision < 0) precision = 0;

    if (precision <= 3) formatString += '0' * precision;
    if (precision > 3) formatString += '000' + '#' * (precision - 3);

    return formatString;
  }

  Map<String, dynamic> _formatParts([int precision]) {
    var _minutesStr = NumberFormat(_dmmPartNumberFormat(precision)).format(minutes);
    var _degrees = degrees;
    var _sign = (sign < 0) ? '-' : '';

    //Values like 59.999999999' may be rounded to 60.0. So in that case,
    //the degree has to be increased while minutes should be set to 0.0
    if (_minutesStr.startsWith('60')) {
      _minutesStr = '00.000';
      _degrees += 1;
    }

    var _degreesStr = _degrees.toString();

    return {
      'sign': {'value': sign, 'formatted': _sign},
      'degrees': _degreesStr,
      'minutes': _minutesStr
    };
  }

  String _format([int precision]) {
    var formattedParts = _formatParts(precision);

    return formattedParts['sign']['formatted'] +
        formattedParts['degrees'] +
        '° ' +
        formattedParts['minutes'] +
        '\'';
  }

  @override
  String toString([int precision]) {
    return '${_format(precision)}';
  }

  static DMMPart parse(String input, {leftPadMilliMinutes: false, wholeString: false}) {
    input = dec.prepareInput(input, wholeString: wholeString);
    if (input == null) return null;

    var parsedTrailingSigns = _parseDMMTrailingSigns(input, leftPadMilliMinutes);
    if (parsedTrailingSigns != null) return parsedTrailingSigns;

    RegExp regex = RegExp(PATTERN_DMM, caseSensitive: false);
    if (regex.hasMatch(input)) {
      var matches = regex.firstMatch(input);

      var latSign = dec.sign(matches.group(1));
      var latDegrees = int.tryParse(matches.group(2));
      var latMinutes = 0.0;
      if (matches.group(4) != null) {
        if (leftPadMilliMinutes && (matches.group(4).length) < 3)
          latMinutes = _leftPadDMMMilliMinutes(matches.group(3), matches.group(4));
        else
          latMinutes = double.parse('${matches.group(3)}.${matches.group(4)}');
      } else {
        latMinutes = double.parse('${matches.group(3)}.0');
      }
      return DMMPart(latSign, latDegrees, latMinutes);
    }

    return null;
  }

  static double _leftPadDMMMilliMinutes(String minutes, String milliMinutes) {
    if (milliMinutes.length <= 3) return double.tryParse('$minutes.${milliMinutes.padLeft(3, '0')}');

    int milliMinuteValue = int.tryParse(milliMinutes);
    int minuteValue = int.tryParse(minutes) + (milliMinuteValue / 1000).floor();

    return double.tryParse('$minuteValue.${milliMinuteValue % 1000}');
  }

  static DMMPart _parseDMMTrailingSigns(String text, leftPadMilliMinutes) {
    RegExp regex = RegExp(PATTERN_DMM_TRAILINGSIGN, caseSensitive: false);

    if (regex.hasMatch(text)) {
      var matches = regex.firstMatch(text);

      var latSign = dec.sign(matches.group(4));
      var latDegrees = int.tryParse(matches.group(1));
      var latMinutes = 0.0;
      if (matches.group(3) != null) {
        if (leftPadMilliMinutes)
          latMinutes = _leftPadDMMMilliMinutes(matches.group(2), matches.group(3));
        else
          latMinutes = double.parse('${matches.group(2)}.${matches.group(3)}');
      } else {
        latMinutes = double.parse('${matches.group(2)}.0');
      }
      return DMMPart(latSign, latDegrees, latMinutes);
    }

    return null;
  }

  static final PATTERN_DMM_TRAILINGSIGN = '^\\s*?'
      '(\\d{1,3})\\s*?[\\s°]\\s*?' //lat degrees + symbol
      '([0-5]?\\d)\\s*?' //lat minutes
      '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?' //lat milliminutes
      '[\\s\'´′`]?\\s*?' //lat minute symbol
      '([NSEWO]|[\\+\\-])\\s*?'; //lat sign


  static final PATTERN_DMM = '^\\s*?'
      '([NSEWO]$LETTER*?|[\\+\\-])?\\s*?' //lat sign
      '(\\d{1,3})\\s*?[\\s°]\\s*?' //lat degrees + symbol
      '([0-5]?\\d)\\s*?' //lat minutes
      '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?' //lat milliminutes
      '[\\s\'´′`]?\\s*?'; //lat minute symbol
}