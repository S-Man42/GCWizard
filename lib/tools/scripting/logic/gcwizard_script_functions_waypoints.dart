part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

void _wptsadd(dynamic lat, dynamic lon) {
  if (_isString(lat) || _isString(lon)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  if ((lat as num).abs() > 90) {
    _handleError(INVALIDLATITUDE);
    return;
  }
  if ((lon as num).abs() > 180) {
    _handleError(INVALIDLONGITUDE);
    return;
  }
  _waypoints.add(GCWMapPoint(
      uuid: 'wpt',
      markerText: 'wpt',
      point: LatLng((lat as double), (lon as double)),
      color: Colors.black,
      isEditable: false,
      isVisible: true));
}

void _wptsclear() {
  _waypoints = [];
}

int _wptscount() {
  return _waypoints.length;
}

double _wptslat(dynamic i) {
  if (_isString(i)) {
    _handleError(INVALIDTYPECAST);
    return 0.0;
  }
  if ((i as int) >= _waypoints.length || i < 1) {
    _handleError(RANGEERROR);
    return 0.0;
  }
  return _waypoints[i - 1].point.latitude;
}

double _wptslon(dynamic i) {
  if (_isString(i)) {
    _handleError(INVALIDTYPECAST);
    return 0.0;
  }
  if ((i as int) >= _waypoints.length || i < 1) {
    _handleError(RANGEERROR);
    return 0.0;
  }
  return _waypoints[i - 1].point.longitude;
}

void _wptscenter(dynamic x) {
  if (_isString(x)) {
    _handleError(INVALIDTYPECAST);
    return;
  }
  List<LatLng> coords = [];
  _waypoints.forEach((waypoint) {
    coords.add(LatLng(waypoint.point.latitude, waypoint.point.longitude));
  });
  LatLng coord = centroidCenterOfGravity(coords);
  if (x.toInt() == 0) {
    // arithmetic
    coord = centroidArithmeticMean(coords, coord);
    GCWizardScript_LAT = coord.latitude;
    GCWizardScript_LON = coord.longitude;
  } else {
    // gravity
    GCWizardScript_LAT = coord.latitude;
    GCWizardScript_LON = coord.longitude;
  }
}
