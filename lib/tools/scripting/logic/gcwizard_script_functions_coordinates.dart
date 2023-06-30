part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _wgs84(Object x, Object y) {
  if (_isString(x) || _isString(y)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  var coord = LatLng(x as double, y as double);
  return coord.latitude.toString() + ' ' + coord.longitude.toString();
}

double _getlon() {
  return _state.GCWizardScript_LON;
}

double _getlat() {
  return _state.GCWizardScript_LAT;
}

void _setlon(Object x) {
  if (_isString(x)) {
    _handleError(_INVALIDTYPECAST);
  }
  if ((x as num).abs() > 180) {
    _handleError(_INVALIDLONGITUDE);
    _state.GCWizardScript_LON = x as double;
  } else {
    _state.GCWizardScript_LON = x as double;
  }
}

void _setlat(Object x) {
  if (_isString(x)) {
    _handleError(_INVALIDTYPECAST);
  }
  if ((x as num).abs() > 90) {
    _handleError(_INVALIDLATITUDE);
    _state.GCWizardScript_LAT = 0;
  } else {
    _state.GCWizardScript_LAT = x as double;
  }
}

double _distance(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(_INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double), const Ellipsoid(ELLIPSOID_NAME_WGS84, 6378137.0, 298.257223563)).distance;
}

double _bearing(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(_INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double), defaultEllipsoid).bearingAToB;
}

void _projection(Object x1, Object y1, Object dist, Object angle) {
  if (_isString(x1) || _isString(y1) || _isString(dist) || _isString(angle)) {
    _handleError(_INVALIDTYPECAST);
  }
  LatLng _currentValues = projection(LatLng(x1 as double, y1 as double), angle as double, dist as double, defaultEllipsoid);
  _state.GCWizardScript_LAT = _currentValues.latitude;
  _state.GCWizardScript_LON = _currentValues.longitude;
}

void _centerthreepoints(Object lat1, Object lon1, Object lat2, Object lon2, Object lat3, Object lon3) {
  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2) || _isString(lat3) || _isString(lon3)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }

  double yDelta_a = (lat2 as double) - (lat1 as double);
  double xDelta_a = (lon2 as double) - (lon1 as double);
  double yDelta_b = (lat3 as double) - (lat2);
  double xDelta_b = (lon3 as double) - (lon2);

  double aSlope = yDelta_a / xDelta_a;
  double bSlope = yDelta_b / xDelta_b;

  _state.GCWizardScript_LON = (aSlope * bSlope * (lat1 - lat3) + bSlope*(lon1 + lon2) - aSlope * (lon2 + lon3) ) / (2 * (bSlope - aSlope));
  _state.GCWizardScript_LAT = -1 * (_state.GCWizardScript_LON - (lon1 + lon2) / 2) / aSlope +  (lat1 + lat2)/2;
}

void _centertwopoints(Object lat1, Object lon1, Object lat2, Object lon2) {
  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }
  CenterPointDistance coord = centerPointTwoPoints(
      LatLng(lat1 as double, lon1 as double),
      LatLng(lat2 as double, lon2 as double),
      defaultEllipsoid);
  _state.GCWizardScript_LAT = coord.centerPoint.latitude;
  _state.GCWizardScript_LON = coord.centerPoint.longitude;
}

