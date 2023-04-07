part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _wgs84(dynamic x, dynamic y) {
  if (_isString(x) || _isString(y)) {
    _handleError(INVALIDTYPECAST);
    return '';
  }
  var coord = DMM((x), (y));
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
  if (x.abs() > 180) {
    _handleError(INVALIDLONGITUDE);
    GCWizardScript_LON = x;
  } else
    GCWizardScript_LON = x;
}

void _setlat(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
  }
  if (x.abs() > 90) {
    _handleError(INVALIDLATITUDE);
    GCWizardScript_LAT = 0;
  } else
    GCWizardScript_LAT = x;
}

double _distance(dynamic x1, dynamic y1, dynamic x2, dynamic y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1, y1), LatLng(x2, y2), defaultEllipsoid()).distance;
}

double _bearing(dynamic x1, dynamic y1, dynamic x2, dynamic y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1, y1), LatLng(x2, y2), defaultEllipsoid()).bearingAToB;
}

void _projection(dynamic x1, dynamic y1, dynamic dist, dynamic angle) {
  if (_isString(x1) || _isString(y1) || _isString(dist) || _isString(angle)) {
    _handleError(INVALIDTYPECAST);
  }
  var _currentValues = projection(LatLng(x1, y1), angle['value'], dist, defaultEllipsoid());
  GCWizardScript_LAT = _currentValues.latitude;
  GCWizardScript_LON = _currentValues.longitude;
}

void _centerthreepoints(dynamic lat1, dynamic lon1, dynamic lat2, dynamic lon2, dynamic lat3, dynamic lon3) {
  double _checkDist(double dist1, double dist2, double dist3) {
    return (dist1 - dist2) * (dist1 - dist2) + (dist1 - dist3) * (dist1 - dist3) + (dist2 - dist3) * (dist2 - dist3);
  }

  Map<String, dynamic> _calculateCenterPointThreePoints(LatLng coord1, LatLng coord2, LatLng coord3, Ellipsoid ells) {
    double lat = (coord1.latitude + coord2.latitude + coord3.latitude) / 3.0;
    double lon = (coord1.longitude + coord2.longitude + coord3.longitude) / 3.0;
    var calculatedPoint = LatLng(lat, lon);

    double dist1 = distanceBearing(calculatedPoint, coord1, ells).distance;
    double dist2 = distanceBearing(calculatedPoint, coord2, ells).distance;
    double dist3 = distanceBearing(calculatedPoint, coord3, ells).distance;

    double dist = max(dist1, max(dist2, dist3));
    double originalDist = dist;

    double d = _checkDist(dist1, dist2, dist3);
    double distSum = dist1 + dist2 + dist3;

    int c = 0;

    while (d > epsilon) {
      c++;
      if (c > 1000) {
        dist = originalDist;
        c = 0;
        calculatedPoint = LatLng(lat, lon);
      }

      double bearing = Random().nextDouble() * 360.0;
      LatLng projectedPoint = projection(calculatedPoint, bearing, dist, ells);

      dist1 = distanceBearing(projectedPoint, coord1, ells).distance;
      dist2 = distanceBearing(projectedPoint, coord2, ells).distance;
      dist3 = distanceBearing(projectedPoint, coord3, ells).distance;

      double newD = _checkDist(dist1, dist2, dist3);
      double newDistSum = dist1 + dist2 + dist3;

      if (newD < d && newDistSum < distSum + 1000000) {
        calculatedPoint = projectedPoint;

        dist *= 1.5; //adjusted these values empirical
        d = newD;
        distSum = newDistSum;
      } else if (newD > d || newDistSum > distSum + 1000000) dist /= 1.2;
    }

    return {'centerPoint': calculatedPoint, 'distance': dist1};
  }

  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2) || _isString(lat3) || _isString(lon3)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  Map<String, dynamic> coord = _calculateCenterPointThreePoints(
      LatLng(lat1, lon1), LatLng(lat2, lon2), LatLng(lat3, lon3), defaultEllipsoid());
  GCWizardScript_LAT = coord['centerPoint'].latitude;
  GCWizardScript_LON = coord['centerPoint'].longitude;
}

void _centertwopoints(dynamic lat1, dynamic lon1, dynamic lat2, dynamic lon2) {
  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  Map<String, dynamic> coord = centerPointTwoPoints(LatLng(lat1, lon1), LatLng(lat2, lon2), defaultEllipsoid());
  GCWizardScript_LAT = coord['centerPoint'].latitude;
  GCWizardScript_LON = coord['centerPoint'].longitude;
}
}
