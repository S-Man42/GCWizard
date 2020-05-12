import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

String _degAndDMSNumberFormat([int precision = 6]) {
  var formatString = '00.';
  if (precision == null)
    precision = 6;
  if (precision < 0)
    precision = 0;

  if (precision <= 3)
    formatString += '0' * precision;
  if (precision > 3)
    formatString += '000' + '#' * (precision - 3);

  return formatString;
}

int sign(double value) {
  return value == 0 ? 1 : value.sign.floor();
}

double lonDEGToDEC(DEG coord) {
  return normalizeLon(DEGToDEC(coord));
}

double latDEGToDEC(DEG coord) {
  return normalizeLat(DEGToDEC(coord));
}

double lonDMSToDEC(DMS coord) {
  return normalizeLon(DMSToDEC(coord));
}

double latDMSToDEC(DMS coord) {
  return normalizeLat(DMSToDEC(coord));
}

double DEGToDEC(DEG coord) {
  return coord.sign * (coord.degrees.abs() + coord.minutes / 60.0);
}

double DMSToDEC(DMS coord) {
  return coord.sign * (coord.degrees.abs() + coord.minutes / 60.0 + coord.seconds / 60.0 / 60.0);
}

double normalizeLat(double lat) {
  if (lat > 90.0)
    return normalizeLat(180.0 - lat);
  if (lat < -90.0)
    return normalizeLat(-180.0 + -lat);

  return lat;
}

double normalizeLon(double lon) {
  if (lon > 180.0)
    return normalizeLon(lon - 360.0);
  if (lon < -180.0)
    return normalizeLon(360.0 + lon);

  return lon;
}

DEG decToDeg(double coord, bool isLatitude) {
  coord = isLatitude ? normalizeLat(coord) : normalizeLon(coord);

  var _sign = sign(coord);

  int _degrees = coord.abs().floor();
  double _minutes = (coord.abs() - _degrees) * 60.0;

  return DEG(_sign, _degrees, _minutes);
}

Map<String, dynamic> formattedDEG(double _coord, bool isLatitude, {int precision}) {
  DEG deg = decToDeg(_coord, isLatitude);

  var _minutesStr = NumberFormat(_degAndDMSNumberFormat(precision)).format(deg.minutes);
  var _degrees = deg.degrees;
  var _sign = _getSignString(deg.sign, isLatitude);

  //Values like 59.999999999' may be rounded to 60.0. So in that case,
  //the degree has to be increased while minutes should be set to 0.0
  if (_minutesStr.startsWith('60')) {
    _minutesStr = '00.000';
    _degrees += 1;
  }

  var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3,'0');

  return {'sign': {'value': deg.sign, 'formatted': _sign}, 'degrees': _degreesStr, 'minutes': _minutesStr};
}

DMS decToDMS(double coord, bool isLatitude) {
  coord = isLatitude ? normalizeLat(coord) : normalizeLon(coord);

  var _sign = sign(coord);

  int _degrees = coord.abs().floor();
  double _minutesD = (coord.abs() - _degrees) * 60.0;

  int _minutes = _minutesD.floor();
  double _seconds = (_minutesD - _minutes) * 60.0;

  return DMS(_sign, _degrees, _minutes, _seconds);
}

_formattedDEGToString(Map<String, dynamic> formattedDEG) {
  return formattedDEG['sign']['formatted']
    + ' ' + formattedDEG['degrees'] + '° '
    + formattedDEG['minutes'] + '\'';
}

Map<String, dynamic> formattedDMS(double _coord, bool isLatitude, {int precision}) {
  DMS dms = decToDMS(_coord, isLatitude);

  var _sign = _getSignString(dms.sign, isLatitude);
  var _secondsStr = NumberFormat(_degAndDMSNumberFormat(precision)).format(dms.seconds);
  var _minutes = dms.minutes;

  //Values like 59.999999999 may be rounded to 60.0. So in that case,
  //the greater unit (minutes or degrees) has to be increased instead
  if (_secondsStr.startsWith('60')) {
    _secondsStr = '00.000';
    _minutes += 1;
  }

  var _degrees = dms.degrees;

  var _minutesStr = _minutes.toString().padLeft(2, '0');
  if (_minutesStr.startsWith('60')) {
    _minutesStr = '00';
    _degrees += 1;
  }

  var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3,'0');

  return {'sign': {'value': dms.sign, 'formatted': _sign}, 'degrees': _degreesStr, 'minutes': _minutesStr, 'seconds': _secondsStr};
}

_formattedDMSToString(Map<String, dynamic> formattedDMS) {
  return formattedDMS['sign']['formatted']
    + ' ' + formattedDMS['degrees'] + '° '
    + formattedDMS['minutes'] + '\' '
    + formattedDMS['seconds'] + '"';
}

String _getSignString(int sign, bool isLatitude) {
  var _sign = '';

  if (sign < 0) {
    _sign = isLatitude ? 'S' : 'W';
  } else {
    _sign = isLatitude ? 'N' : 'E';
  }

  return _sign;
}

Map<String, String> decToString(LatLng _coords) {
  var _lat = NumberFormat('00.000#######').format(_coords.latitude);
  var _lon = NumberFormat('000.000#######').format(_coords.longitude);

  return {'latitude': _lat, 'longitude': _lon};
}

Map<String, String> decToDegString(LatLng _coords) {
  var _lat = _formattedDEGToString(formattedDEG(_coords.latitude, true));
  var _lon = _formattedDEGToString(formattedDEG(_coords.longitude, false));

  return {'latitude': _lat, 'longitude': _lon};
}

Map<String, String> decToDMSString(LatLng _coords) {
  var _lat = _formattedDMSToString(formattedDMS(_coords.latitude, true));
  var _lon = _formattedDMSToString(formattedDMS(_coords.longitude, false));

  return {'latitude': _lat, 'longitude': _lon};
}