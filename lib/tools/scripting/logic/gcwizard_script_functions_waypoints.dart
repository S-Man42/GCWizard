part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

void _wptsadd(Object lat, Object lon) {
  if (_isString(lat) || _isString(lon)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }
  if ((lat as num).abs() > 90) {
    _handleError(_INVALIDLATITUDE);
    return;
  }
  if ((lon as num).abs() > 180) {
    _handleError(_INVALIDLONGITUDE);
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

double _wptslat(Object i) {
  if (!_isNumber(i)) {
    _handleError(_INVALIDTYPECAST);
    return 0.0;
  }
  if ((i as num).toInt() >= _waypoints.length || i.toInt() < 1) {
    _handleError(_RANGEERROR);
    return 0.0;
  }
  return _waypoints[i.toInt() - 1].point.latitude;
}

double _wptslon(Object i) {
  if (!_isNumber(i)) {
    _handleError(_INVALIDTYPECAST);
    return 0.0;
  }
  if ((i as num).toInt() >= _waypoints.length || i < 1) {
    _handleError(_RANGEERROR);
    return 0.0;
  }
  return _waypoints[i.toInt() - 1].point.longitude;
}

void _wptscenter(Object x) {
  if (!_isNumber(x)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }
  List<LatLng> coords = [];
  for (GCWMapPoint waypoint in _waypoints) {
    coords.add(LatLng(waypoint.point.latitude, waypoint.point.longitude));
  }
  LatLng coord = centroidCenterOfGravity(coords)!;
  if ((x as num) == 0) {
    // arithmetic
    coord = centroidArithmeticMean(coords, coord)!;
    GCWizardScript_LAT = coord.latitude;
    GCWizardScript_LON = coord.longitude;
  } else {
    // gravity
    GCWizardScript_LAT = coord.latitude;
    GCWizardScript_LON = coord.longitude;
  }
}
