import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

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
  if (lat > 90)
    return 180 - lat;
  if (lat < -90)
    return -180 + -lat;

  return lat;
}

double normalizeLon(double lon) {
  if (lon > 180)
    return lon - 360;
  if (lon < -180)
    return 360 + lon;

  return lon;
}

String _coordDecToDeg(double _coord, bool isLatitude) {
  var _sign = _getSign(_coord, isLatitude);

  int _degrees = _coord.abs().floor();
  double _minutes = (_coord.abs() - _degrees) * 60.0;

  var _minutesStr = NumberFormat('00.000###').format(_minutes);

  //Values like 59.999999999' may be rounded to 60.0. So in that case,
  //the degree has to be increased while minutes should be set to 0.0
  if (_minutesStr.startsWith('60')) {
    _minutesStr = '00.000';
    _degrees += 1;
  }

  var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3,'0');

  return '$_sign $_degreesStr° $_minutesStr\'';
}

String _coordDecToDMS(double _coord, bool isLatitude) {
  var _sign = _getSign(_coord, isLatitude);

  int _degrees = _coord.abs().floor();
  double _minutesD = (_coord.abs() - _degrees) * 60.0;

  int _minutes = _minutesD.floor();
  double _seconds = (_minutesD - _minutes) * 60.0;

  var _secondsStr = NumberFormat('00.000###').format(_seconds);

  //Values like 59.999999999 may be rounded to 60.0. So in that case,
  //the greater unit (minutes or degrees) has to be increased instead
  if (_secondsStr.startsWith('60')) {
    _secondsStr = '00.000';
    _minutes += 1;
  }

  var _minutesStr = _minutes.toString().padLeft(2, '0');
  if (_minutesStr.startsWith('60')) {
    _minutesStr = '00';
    _degrees += 1;
  }

  var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3,'0');

  return '$_sign $_degreesStr° $_minutesStr\' $_secondsStr"';
}

String _getSign(double _coord, bool isLatitude) {
  var _sign = '';

  if (_coord < 0.0) {
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
  var _lat = '${_coordDecToDeg(_coords.latitude, true)}';
  var _lon = '${_coordDecToDeg(_coords.longitude, false)}';

  return {'latitude': _lat, 'longitude': _lon};
}

Map<String, String> decToDMSString(LatLng _coords) {
  var _lat = '${_coordDecToDMS(_coords.latitude, true)}';
  var _lon = '${_coordDecToDMS(_coords.longitude, false)}';

  return {'latitude': _lat, 'longitude': _lon};
}