part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _wgs84(dynamic x, dynamic y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  var coord = LatLng(x as double, y as double);
  return coord.latitude.toString() + ' ' + coord.longitude.toString();
}

double _getlon() {
  return GCWizardScript_LON;
}

double _getlat() {
  return GCWizardScript_LAT;
}

void _setlon(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
  }
  if ((x as num).abs() > 180) {
    _handleError(INVALIDLONGITUDE);
    GCWizardScript_LON = x as double;
  } else {
    GCWizardScript_LON = x as double;
  }
}

void _setlat(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
  }
  if ((x as num).abs() > 90) {
    _handleError(INVALIDLATITUDE);
    GCWizardScript_LAT = 0;
  } else {
    GCWizardScript_LAT = x as double;
  }
}

double _distance(dynamic x1, dynamic y1, dynamic x2, dynamic y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double), defaultEllipsoid).distance;
}

double _bearing(dynamic x1, dynamic y1, dynamic x2, dynamic y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double), defaultEllipsoid).bearingAToB;
}

void _projection(dynamic x1, dynamic y1, dynamic dist, dynamic angle) {
  if (_isString(x1) || _isString(y1) || _isString(dist) || _isString(angle)) {
    _handleError(INVALIDTYPECAST);
  }
  LatLng _currentValues = projection(LatLng(x1 as double, y1 as double), angle as double, dist as double, defaultEllipsoid);
  GCWizardScript_LAT = _currentValues.latitude;
  GCWizardScript_LON = _currentValues.longitude;
}

void _centerthreepoints(dynamic lat1, dynamic lon1, dynamic lat2, dynamic lon2, dynamic lat3, dynamic lon3) {
  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2) || _isString(lat3) || _isString(lon3)) {
    _handleError(INVALIDTYPECAST);
    return;
  }

  double yDelta_a = (lat2 as double) - (lat1 as double);
  double xDelta_a = (lon2 as double) - (lon1 as double);
  double yDelta_b = (lat3 as double) - (lat2);
  double xDelta_b = (lon3 as double) - (lon2);

  double aSlope = yDelta_a / xDelta_a;
  double bSlope = yDelta_b / xDelta_b;

  GCWizardScript_LON = (aSlope * bSlope * (lat1 - lat3) + bSlope*(lon1 + lon2) - aSlope * (lon2 + lon3) ) / (2 * (bSlope - aSlope));
  GCWizardScript_LAT = -1 * (GCWizardScript_LON - (lon1 + lon2) / 2) / aSlope +  (lat1 + lat2)/2;
}

void _centertwopoints(dynamic lat1, dynamic lon1, dynamic lat2, dynamic lon2) {
  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  Map<String, dynamic> coord = centerPointTwoPoints(
      LatLng(lat1 as double, lon1 as double),
      LatLng(lat2 as double, lon2 as double),
      defaultEllipsoid) as Map<String, dynamic>;
  GCWizardScript_LAT = coord['centerPoint'].latitude as double;
  GCWizardScript_LON = coord['centerPoint'].longitude as double;
}

