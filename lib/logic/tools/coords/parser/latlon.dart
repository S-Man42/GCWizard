import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:latlong/latlong.dart';

final PATTERN_NO_NUMBERS = '[^\\.,\\d]+?';
final PATTERN_NOTHING_OR_NO_NUMBERS = '[^\\.,\\d]*?';
final PATTERN_LAT_SIGN = '([NS\+\-])';
final PATTERN_LON_SIGN = '([EWO\+\-])';
final PATTERN_LON_SIGN_WITH_SPACE = '(?:[^\\d]+?$PATTERN_LON_SIGN)?';
final PATTERN_LAT_DEGREE_INT = '(\\d{1,2})';
final PATTERN_LON_DEGREE_INT = '(\\d{1,3})';
final PATTERN_SECONDS_MINUTES = '([0-5]?[0-9])';
final PATTERN_DECIMAL = '(?:\\s*?[\\.,]\\s*?(\\d+))?';

final PATTERN_DEC_TRAILINGSIGN =
    '\\s*'
  + PATTERN_LAT_DEGREE_INT
  + PATTERN_DECIMAL
  + PATTERN_NOTHING_OR_NO_NUMBERS + PATTERN_LAT_SIGN
  + '[^\\d]*?'
  + PATTERN_LON_DEGREE_INT
  + PATTERN_DECIMAL
  + PATTERN_NOTHING_OR_NO_NUMBERS + PATTERN_LON_SIGN;

final PATTERN_DEC =
    '\\s*'
  + PATTERN_LAT_SIGN + '?.*?'
  + PATTERN_LAT_DEGREE_INT
  + PATTERN_DECIMAL

  + PATTERN_LON_SIGN_WITH_SPACE + '.*?'
  + PATTERN_LON_DEGREE_INT
  + PATTERN_DECIMAL;

final PATTERN_DEG_TRAILINGSIGN =
    '\\s*'
  + PATTERN_LAT_DEGREE_INT + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES
  + PATTERN_DECIMAL
  + PATTERN_NOTHING_OR_NO_NUMBERS + PATTERN_LAT_SIGN
  + '[^\\d]*?'
  + PATTERN_LON_DEGREE_INT + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES
  + PATTERN_DECIMAL
  + PATTERN_NOTHING_OR_NO_NUMBERS + PATTERN_LON_SIGN;

final PATTERN_DEG =
    '\\s*'
  + PATTERN_LAT_SIGN + '?.*?'
  + PATTERN_LAT_DEGREE_INT + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES
  + PATTERN_DECIMAL

  + PATTERN_LON_SIGN_WITH_SPACE + '.*?'
  + PATTERN_LON_DEGREE_INT + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES
  + PATTERN_DECIMAL;

final PATTERN_DMS_TRAILINGSIGN =
    '\\s*'
  + PATTERN_LAT_DEGREE_INT + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES
  + PATTERN_DECIMAL
  + PATTERN_NOTHING_OR_NO_NUMBERS + PATTERN_LAT_SIGN
  + '[^\\d]*?'
  + PATTERN_LON_DEGREE_INT + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES
  + PATTERN_DECIMAL
  + PATTERN_NOTHING_OR_NO_NUMBERS + PATTERN_LON_SIGN;

final PATTERN_DMS =
    '\\s*'
  + PATTERN_LAT_SIGN + '?.*?'
  + PATTERN_LAT_DEGREE_INT + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES
  + PATTERN_DECIMAL

  + PATTERN_LON_SIGN_WITH_SPACE + '.*?'
  + PATTERN_LON_DEGREE_INT + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES + PATTERN_NO_NUMBERS
  + PATTERN_SECONDS_MINUTES
  + PATTERN_DECIMAL;

int _sign(String match) {
  if (match == null)
    return 1;

  if (match.contains(RegExp(r'[SW-]', caseSensitive: false))) {
    return -1;
  }

  return 1;
}

LatLng _parseDECTrailingSigns(String text) {

  RegExp regex = RegExp(PATTERN_DEC_TRAILINGSIGN, caseSensitive: false);
  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = _sign(matches.group(3));
    var latDegrees = 0.0;
    if (matches.group(2) != null) {
      latDegrees = latSign * double.parse('${matches.group(1)}.${matches.group(2)}');
    } else {
      latDegrees = latSign * double.parse('${matches.group(1)}.0');
    }

    var lonSign = _sign(matches.group(6));
    var lonDegrees = 0.0;
    if (matches.group(5) != null) {
      lonDegrees = lonSign * double.parse('${matches.group(4)}.${matches.group(5)}');
    } else {
      lonDegrees = lonSign * double.parse('${matches.group(4)}.0');
    }

    return DEC(latDegrees, lonDegrees).toLatLng();
  }

  return null;
}

LatLng parseDEC(String text) {

  var parsedTrailingSigns = _parseDECTrailingSigns(text);
  if (parsedTrailingSigns != null)
    return parsedTrailingSigns;

  RegExp regex = RegExp(PATTERN_DEC, caseSensitive: false);
  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = _sign(matches.group(1));
    var latDegrees = 0.0;
    if (matches.group(3) != null) {
      latDegrees = latSign * double.parse('${matches.group(2)}.${matches.group(3)}');
    } else {
      latDegrees = latSign * double.parse('${matches.group(2)}.0');
    }

    var lonSign = _sign(matches.group(4));
    var lonDegrees = 0.0;
    if (matches.group(6) != null) {
      lonDegrees = lonSign * double.parse('${matches.group(5)}.${matches.group(6)}');
    } else {
      lonDegrees = lonSign * double.parse('${matches.group(5)}.0');
    }

    return DEC(latDegrees, lonDegrees).toLatLng();
  }

  return null;
}

double _leftPadDEGMilliMinutes(String minutes, String milliMinutes) {
  if (milliMinutes.length <= 3)
    return double.tryParse('$minutes.${milliMinutes.padLeft(3, '0')}');

  int milliMinuteValue = int.tryParse(milliMinutes);
  int minuteValue = int.tryParse(minutes) + (milliMinuteValue / 1000).floor();

  return double.tryParse('$minuteValue.${milliMinuteValue % 1000}');
}

LatLng _parseDEGTrailingSigns(String text, leftPadMilliMinutes) {

  RegExp regex = RegExp(PATTERN_DEG_TRAILINGSIGN, caseSensitive: false);
  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = _sign(matches.group(4));
    var latDegrees = int.tryParse(matches.group(1));
    var latMinutes = 0.0;
    if (matches.group(3) != null) {
      if (leftPadMilliMinutes)
        latMinutes = _leftPadDEGMilliMinutes(matches.group(2), matches.group(3));
      else
        latMinutes = double.parse('${matches.group(2)}.${matches.group(3)}');
    } else {
      latMinutes = double.parse('${matches.group(2)}.0');
    }
    var lat = DEGLatitude(latSign, latDegrees, latMinutes);

    var lonSign = _sign(matches.group(8));
    var lonDegrees = lonSign * int.tryParse(matches.group(5));
    var lonMinutes = 0.0;
    if (matches.group(7) != null) {
      if (leftPadMilliMinutes)
        lonMinutes = _leftPadDEGMilliMinutes(matches.group(6), matches.group(7));
      else
        lonMinutes = double.parse('${matches.group(6)}.${matches.group(7)}');
    } else {
      lonMinutes = double.parse('${matches.group(6)}.0');
    }
    var lon = DEGLongitude(lonSign, lonDegrees, lonMinutes);

    return DEG(lat, lon).toLatLng();
  }

  return null;
}

LatLng parseDEG(String text, {leftPadMilliMinutes: false}) {
  var parsedTrailingSigns = _parseDEGTrailingSigns(text, leftPadMilliMinutes);
  if (parsedTrailingSigns != null)
    return parsedTrailingSigns;

  RegExp regex = RegExp(PATTERN_DEG, caseSensitive: false);
  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = _sign(matches.group(1));
    var latDegrees = int.tryParse(matches.group(2));
    var latMinutes = 0.0;
    if (matches.group(4) != null) {
      if (leftPadMilliMinutes)
        latMinutes = _leftPadDEGMilliMinutes(matches.group(3), matches.group(4));
      else
        latMinutes = double.parse('${matches.group(3)}.${matches.group(4)}');
    } else {
      latMinutes = double.parse('${matches.group(3)}.0');
    }
    var lat = DEGLatitude(latSign, latDegrees, latMinutes);

    var lonSign = _sign(matches.group(5));
    var lonDegrees = int.tryParse(matches.group(6));
    var lonMinutes = 0.0;
    if (matches.group(8) != null) {
      if (leftPadMilliMinutes)
        lonMinutes = _leftPadDEGMilliMinutes(matches.group(7), matches.group(8));
      else
        lonMinutes = double.parse('${matches.group(7)}.${matches.group(8)}');
    } else {
      lonMinutes = double.parse('${matches.group(7)}.0');
    }
    var lon = DEGLongitude(lonSign, lonDegrees, lonMinutes);

    return DEG(lat, lon).toLatLng();
  }

  return null;
}

LatLng _parseDMSTrailingSigns(String text) {

  RegExp regex = RegExp(PATTERN_DMS_TRAILINGSIGN, caseSensitive: false);
  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = _sign(matches.group(5));
    var latDegrees = int.tryParse(matches.group(1));
    var latMinutes = int.tryParse(matches.group(2));
    var latSeconds = 0.0;
    if (matches.group(4) != null) {
      latSeconds = double.parse('${matches.group(3)}.${matches.group(4)}');
    } else {
      latSeconds = double.parse('${matches.group(3)}.0');
    }
    var lat = DMSLatitude(latSign, latDegrees, latMinutes, latSeconds);

    var lonSign = _sign(matches.group(10));
    var lonDegrees = int.tryParse(matches.group(6));
    var lonMinutes = int.tryParse(matches.group(7));
    var lonSeconds = 0.0;
    if (matches.group(9) != null) {
      lonSeconds = double.parse('${matches.group(8)}.${matches.group(9)}');
    } else {
      lonSeconds = double.parse('${matches.group(8)}.0');
    }
    var lon = DMSLongitude(lonSign, lonDegrees, lonMinutes, lonSeconds);

    return DMS(lat, lon).toLatLng();
  }

  return null;
}

LatLng parseDMS(String text) {
  var parsedTrailingSigns = _parseDMSTrailingSigns(text);
  if (parsedTrailingSigns != null)
    return parsedTrailingSigns;

  RegExp regex = RegExp(PATTERN_DMS, caseSensitive: false);
  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = _sign(matches.group(1));
    var latDegrees = int.tryParse(matches.group(2));
    var latMinutes = int.tryParse(matches.group(3));
    var latSeconds = 0.0;
    if (matches.group(5) != null) {
      latSeconds = double.parse('${matches.group(4)}.${matches.group(5)}');
    } else {
      latSeconds = double.parse('${matches.group(4)}.0');
    }
    var lat = DMSLatitude(latSign, latDegrees, latMinutes, latSeconds);

    var lonSign = _sign(matches.group(6));
    var lonDegrees = int.tryParse(matches.group(7));
    var lonMinutes = int.tryParse(matches.group(8));
    var lonSeconds = 0.0;
    if (matches.group(10) != null) {
      lonSeconds = double.parse('${matches.group(9)}.${matches.group(10)}');
    } else {
      lonSeconds = double.parse('${matches.group(9)}.0');
    }
    var lon = DMSLongitude(lonSign, lonDegrees, lonMinutes, lonSeconds);

    return DMS(lat, lon).toLatLng();
  }

  return null;
}

Map<String, dynamic> parseLatLon(String text) {
  if (text == null || text.length == 0)
    return null;

  LatLng coord = parseDMS(text);
  if (coord != null)
    return {'format': keyCoordsDMS, 'coordinate': coord};

  coord = parseDEG(text);
  if (coord != null)
    return {'format': keyCoordsDEG, 'coordinate': coord};

  coord = parseDEC(text);
  if (coord != null)
    return {'format': keyCoordsDEC, 'coordinate': coord};

  return null;
}