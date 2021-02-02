import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:latlong/latlong.dart';

final PATTERN_NO_NUMBERS = r'\s+?';
final PATTERN_NOTHING_OR_NO_NUMBERS = r'\s*?';
final PATTERN_LAT_SIGN = r'([NS][A-Za-zÄÖÜäöü]*?|[\+\-])';
final PATTERN_LON_SIGN = r'([EWO][A-Za-zÄÖÜäöü]*?|[\+\-])';
final PATTERN_LON_SIGN_WITH_SPACE = '(?:\\s+?$PATTERN_LON_SIGN)?';
final PATTERN_LAT_DEGREE_INT = r'(\d{1,2})[\s°]+?';
final PATTERN_LON_DEGREE_INT = r'(\d{1,3})[\s°]+?';
final PATTERN_SECONDS_MINUTES = '([0-5]?[0-9])[\\s\']+?';
final PATTERN_DECIMAL = r'(?:\s*?[\.,]\s*?(\d+))?' + '[\\s\'°"]+?';

final _LETTER = '[A-ZÄÖÜ]';

var regexEnd = '';

final PATTERN_DEC_TRAILINGSIGN =
    '^\\s*?'
    '(\\d{1,3})\\s*?'                      //lat degrees
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lat millidegrees
    '[\\s°]?\\s*?'                         //lat degrees symbol
    '([NS]$_LETTER*?|[\\+\\-])\\s*?'       //lat sign

    '[,\\s]\\s*?'                          //delimiter lat lon

    '(\\d{1,3})\\s*?'                      //lon degrees
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lon millidegrees
    '[\\s°]?\\s*?'                         //lon degree symbol
    '([EWO]$_LETTER*?|[\\+\\-])'           //lon sign;
    '\\s*?';

final PATTERN_DEC =
    '^\\s*?'
    '([NS]$_LETTER*?|[\\+\\-])?\\s*?'      //lat sign
    '(\\d{1,3})\\s*?'                      //lat degrees
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lat millidegrees
    '[\\s°]?\\s*?'                         //lat degree symbol

    '\\s*?[,\\s]\\s*?'                     //delimiter lat lon

    '([EWO]$_LETTER*?|[\\+\\-])?\\s*?'     //lon sign
    '(\\d{1,3})\\s*?'                      //lon degrees
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lon millidegrees
    '[\\s°]?'                              //lon degree symbol
    '\\s*?';

final PATTERN_DMM_TRAILINGSIGN =
    '^\\s*?'
    '(\\d{1,3})\\s*?[\\s°]\\s*?'           //lat degrees + symbol
    '([0-5]?\\d)\\s*?'                     //lat minutes
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lat milliminutes
    '[\\s\'´′`]?\\s*?'                     //lat minute symbol
    '([NS]$_LETTER*?|[\\+\\-])\\s*?'       //lat sign

    '[,\\s]\\s*?'                          //delimiter lat lon

    '(\\d{1,3})\\s*?[\\s°]\\s*?'           //lon degrees + symbol
    '([0-5]?\\d)\\s*?'                     //lon minutes
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lon milliminutes
    '[\\s\'´′`]?\\s*?'                     //lon minutes symbol
    '([EWO]$_LETTER*?|[\\+\\-])'           //lon sign;
    '\\s*?';

final PATTERN_DMM =
    '^\\s*?'
    '([NS]$_LETTER*?|[\\+\\-])?\\s*?'      //lat sign
    '(\\d{1,3})\\s*?[\\s°]\\s*?'           //lat degrees + symbol
    '([0-5]?\\d)\\s*?'                     //lat minutes
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lat milliminutes
    '[\\s\'´′`]?\\s*?'                     //lat minute symbol

    '\\s*?[,\\s]\\s*?'                     //delimiter lat lon

    '([EWO]$_LETTER*?|[\\+\\-])?\\s*?'     //lon sign
    '(\\d{1,3})\\s*?[\\s°]\\s*?'           //lon degrees + symbol
    '([0-5]?\\d)\\s*?'                     //lon minutes
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lon milliminutes
    '[\\s\'´′`]?'                          //lon minutes symbol
    '\\s*?';

final PATTERN_DMS_TRAILINGSIGN =
    '^\\s*?'
    '(\\d{1,3})\\s*?[\\s°]\\s*?'           //lat degrees + symbol
    '([0-5]?\\d)\\s*?[\\s\'´′`]\\s*?'      //lat minutes + symbol
    '([0-5]?\\d)\\s*?'                     //lat seconds
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lat milliseconds
    '[\\s"]?\\s*?'                         //lat seconds symbol
    '([NS]$_LETTER*?|[\\+\\-])\\s*?'       //lat sign

    '[,\\s]\\s*?'                          //delimiter lat lon

    '(\\d{1,3})\\s*?[\\s°]\\s*?'           //lon degrees + symbol
    '([0-5]?\\d)\\s*?[\\s\'´′`]\\s*?'      //lon minutes + symbol
    '([0-5]?\\d)\\s*?'                     //lon seconds
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lon milliseconds
    '[\\s"]?\\s*?'                         //lon seconds symbol
    '([EWO]$_LETTER*?|[\\+\\-])'          //lon sign;
    '\\s*?';

final PATTERN_DMS =
    '^\\s*?'
    '([NS]$_LETTER*?|[\\+\\-])?\\s*?'      //lat sign
    '(\\d{1,3})\\s*?[\\s°]\\s*?'           //lat degrees + symbol
    '([0-5]?\\d)\\s*?[\\s\'´′`]\\s*?'        //lat minutes + symbol
    '([0-5]?\\d)\\s*?'                     //lat seconds
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lat milliseconds
    '[\\s"]?\\s*?'                         //lat seconds symbol

    '\\s*?[,\\s]\\s*?'                     //delimiter lat lon

    '([EWO]$_LETTER*?|[\\+\\-])?\\s*?'     //lon sign
    '(\\d{1,3})\\s*?[\\s°]\\s*?'           //lon degrees + symbol
    '([0-5]?\\d)\\s*?[\\s\'´′`]\\s*?'      //lon minutes + symbol
    '([0-5]?\\d)\\s*?'                     //lon seconds
    '(?:\\s*?[.,]\\s*?(\\d+))?\\s*?'       //lon milliseconds
    '[\\s"]?'                              //lon seconds symbol
    '\\s*?';

int _sign(String match) {
  if (match == null)
    return 1;

  if (match[0].contains(RegExp(r'[SW-]', caseSensitive: false))) {
    return -1;
  }

  return 1;
}

String _prepareInput(String text, {wholeString = false}) {
  if (text == null)
    return null;

  if (wholeString) {
    text = text.trim();
    regexEnd = wholeString ? '\$' : '';
  }

  if (text.length == 0)
    return null;

  return text;
}

LatLng _parseDECTrailingSigns(String text) {

  RegExp regex = RegExp(PATTERN_DEC_TRAILINGSIGN + regexEnd, caseSensitive: false);
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

LatLng parseDEC(String text, {wholeString = false}) {

  text = _prepareInput(text, wholeString: wholeString);
  if (text == null)
    return null;

  var parsedTrailingSigns = _parseDECTrailingSigns(text);
  if (parsedTrailingSigns != null)
    return parsedTrailingSigns;

  RegExp regex = RegExp(PATTERN_DEC + regexEnd, caseSensitive: false);

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

double _leftPadDMMMilliMinutes(String minutes, String milliMinutes) {
  if (milliMinutes.length <= 3)
    return double.tryParse('$minutes.${milliMinutes.padLeft(3, '0')}');

  int milliMinuteValue = int.tryParse(milliMinutes);
  int minuteValue = int.tryParse(minutes) + (milliMinuteValue / 1000).floor();

  return double.tryParse('$minuteValue.${milliMinuteValue % 1000}');
}

LatLng _parseDMMTrailingSigns(String text, leftPadMilliMinutes) {

  RegExp regex = RegExp(PATTERN_DMM_TRAILINGSIGN + regexEnd, caseSensitive: false);

  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = _sign(matches.group(4));
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
    var lat = DMMLatitude(latSign, latDegrees, latMinutes);

    var lonSign = _sign(matches.group(8));
    var lonDegrees = lonSign * int.tryParse(matches.group(5));
    var lonMinutes = 0.0;
    if (matches.group(7) != null) {
      if (leftPadMilliMinutes)
        lonMinutes = _leftPadDMMMilliMinutes(matches.group(6), matches.group(7));
      else
        lonMinutes = double.parse('${matches.group(6)}.${matches.group(7)}');
    } else {
      lonMinutes = double.parse('${matches.group(6)}.0');
    }
    var lon = DMMLongitude(lonSign, lonDegrees, lonMinutes);

    return DMM(lat, lon).toLatLng();
  }

  return null;
}

LatLng parseDMM(String text, {leftPadMilliMinutes: false, wholeString: false}) {

  text = _prepareInput(text, wholeString: wholeString);
  if (text == null)
    return null;

  var parsedTrailingSigns = _parseDMMTrailingSigns(text, leftPadMilliMinutes);
  if (parsedTrailingSigns != null)
    return parsedTrailingSigns;

  RegExp regex = RegExp(PATTERN_DMM + regexEnd, caseSensitive: false);
  if (regex.hasMatch(text)) {
    var matches = regex.firstMatch(text);

    var latSign = _sign(matches.group(1));
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
    var lat = DMMLatitude(latSign, latDegrees, latMinutes);

    var lonSign = _sign(matches.group(5));
    var lonDegrees = int.tryParse(matches.group(6));
    var lonMinutes = 0.0;
    if (matches.group(8) != null) {
      if (leftPadMilliMinutes && matches.group(8).length < 3)
        lonMinutes = _leftPadDMMMilliMinutes(matches.group(7), matches.group(8));
      else
        lonMinutes = double.parse('${matches.group(7)}.${matches.group(8)}');
    } else {
      lonMinutes = double.parse('${matches.group(7)}.0');
    }
    var lon = DMMLongitude(lonSign, lonDegrees, lonMinutes);

    return DMM(lat, lon).toLatLng();
  }

  return null;
}

LatLng _parseDMSTrailingSigns(String text) {

  RegExp regex = RegExp(PATTERN_DMS_TRAILINGSIGN + regexEnd, caseSensitive: false);
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

LatLng parseDMS(String text, {wholeString = false}) {

  text = _prepareInput(text, wholeString: wholeString);
  if (text == null)
    return null;

  var parsedTrailingSigns = _parseDMSTrailingSigns(text);
  if (parsedTrailingSigns != null)
    return parsedTrailingSigns;

  RegExp regex = RegExp(PATTERN_DMS + regexEnd, caseSensitive: false);
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

//wholeString == false: The first match at the text begin is taken - for copy
//wholeString == true: The whole text must be a valid coord - for var coords
Map<String, dynamic> parseLatLon(String text, {wholeString = false}) {
  LatLng coord = parseDMS(text, wholeString: wholeString);
  if (coord != null)
    return {'format': keyCoordsDMS, 'coordinate': coord};

  coord = parseDMM(text, wholeString: wholeString);
  if (coord != null)
    return {'format': keyCoordsDMM, 'coordinate': coord};

  coord = parseDEC(text, wholeString: wholeString);
  if (coord != null)
    return {'format': keyCoordsDEC, 'coordinate': coord};

  return null;
}