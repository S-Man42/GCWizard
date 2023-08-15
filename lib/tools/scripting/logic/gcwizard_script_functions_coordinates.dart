part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _wgs84(Object x, Object y) {
  if (_isString(x) || _isString(y)) {
    _handleError(_INVALIDTYPECAST);
    return '';
  }
  var coord = LatLng(x as double, y as double);
  return coord.latitude.toString() + ' ' + coord.longitude.toString();
}

double _getLon() {
  return _state.GCWizardScript_LON;
}

double _getLat() {
  return _state.GCWizardScript_LAT;
}

void _setLon(Object x) {
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

void _setLat(Object x) {
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

_GCWList _convertTo(Object target) {
  if (_isNotNumber(target)) {
    _handleError(_INVALIDTYPECAST);
  }

  LatLng coord = LatLng(_getLat(), _getLon());
  String targetCoord = '';

  if (_GCW_SCRIPT_COORD_CONVERTER[target] != null) {
    targetCoord = formatCoordOutput(
        coord, CoordinateFormat(_GCW_SCRIPT_COORD_CONVERTER[target]!), getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
  } else {
    _handleError(_INVALIDCOORDINATEFORMAT);
  }

  List<String> targetCoordData = [];
  _GCWList targetData = _GCWList();

  _listAdd(targetData, targetCoord);
  switch (target as num) {
    //TODO 'package:prefs/prefs.dart': Failed assertion: line 244 pos 12: '_initCalled': Prefs.init() must be called first in an initState() preferably!
    case _COORD_DMM: //= 1;

    case _COORD_DUTCH_GRID: //= 8;

    case _COORD_GAUSS_KRUEGER_GK1: //= 901;
    case _COORD_GAUSS_KRUEGER_GK2: //= 902;
    case _COORD_GAUSS_KRUEGER_GK3: //= 903;
    case _COORD_GAUSS_KRUEGER_GK4: //= 904;
    case _COORD_GAUSS_KRUEGER_GK5: //= 905;

    case _COORD_LAMBERT93: //= 1093;
    case _COORD_LAMBERT2008: //= 1008;
    case _COORD_ETRS89LCC: //= 1089;
    case _COORD_LAMBERT72: //= 1072;
    case _COORD_LAMBERT93_CC42: //= 1042;
    case _COORD_LAMBERT93_CC43: //= 1043;
    case _COORD_LAMBERT93_CC44: //= 1044;
    case _COORD_LAMBERT93_CC45: //= 1045;
    case _COORD_LAMBERT93_CC46: //= 1046;
    case _COORD_LAMBERT93_CC47: //= 1047;
    case _COORD_LAMBERT93_CC48: //= 1048;
    case _COORD_LAMBERT93_CC49: //= 1049;
    case _COORD_LAMBERT93_CC50: //= 1050;

    case _COORD_SLIPPYMAP_0: //= 1400;
    case _COORD_SLIPPYMAP_1: //= 1401;
    case _COORD_SLIPPYMAP_2: //= 1402;
    case _COORD_SLIPPYMAP_3: //= 1403;
    case _COORD_SLIPPYMAP_4: //= 1404;
    case _COORD_SLIPPYMAP_5: //= 1405;
    case _COORD_SLIPPYMAP_6: //= 1406;
    case _COORD_SLIPPYMAP_7: //= 1407;
    case _COORD_SLIPPYMAP_8: //= 1408;
    case _COORD_SLIPPYMAP_9: //= 1409;
    case _COORD_SLIPPYMAP_10: //= 1410;
    case _COORD_SLIPPYMAP_11: //= 1411;
    case _COORD_SLIPPYMAP_12: //= 1412;
    case _COORD_SLIPPYMAP_13: //= 1413;
    case _COORD_SLIPPYMAP_14: //= 1414;
    case _COORD_SLIPPYMAP_15: //= 1415;
    case _COORD_SLIPPYMAP_16: //= 1416;
    case _COORD_SLIPPYMAP_17: //= 1417;
    case _COORD_SLIPPYMAP_18: //= 1418;
    case _COORD_SLIPPYMAP_19: //= 1419;
    case _COORD_SLIPPYMAP_20: //= 1420;
    case _COORD_SLIPPYMAP_21: //= 1421;
    case _COORD_SLIPPYMAP_22: //= 1422;
    case _COORD_SLIPPYMAP_23: //= 1423;
    case _COORD_SLIPPYMAP_24: //= 1424;
    case _COORD_SLIPPYMAP_25: //= 1425;
    case _COORD_SLIPPYMAP_26: //= 1426;
    case _COORD_SLIPPYMAP_27: //= 1427;
    case _COORD_SLIPPYMAP_28: //= 1428;
    case _COORD_SLIPPYMAP_29: //= 1429;
    case _COORD_SLIPPYMAP_30: //= 1430;
      break;

    case _COORD_DEC: //= 0;
    case _COORD_DMS: //= 2;
      targetCoordData = targetCoord.split('\n');
      _listAdd(targetData, targetCoordData[0]);
      _listAdd(targetData, targetCoordData[1]);
      break;

    case _COORD_UTM: //= 3;
    case _COORD_MGRS: //= 4;
      targetCoordData = targetCoord.split(' ');
      _listAdd(targetData, targetCoordData[0]);
      _listAdd(targetData, targetCoordData[1]);
      _listAdd(targetData, targetCoordData[2]);
      _listAdd(targetData, targetCoordData[3]);
      break;

    case _COORD_XYZ: //= 5;
      targetCoordData = targetCoord.split('\n');
      _listAdd(targetData, targetCoordData[0].split(': ')[1]);
      _listAdd(targetData, targetCoordData[1].split(': ')[1]);
      _listAdd(targetData, targetCoordData[2].split(': ')[1]);
      break;

    case _COORD_SWISS_GRID: //= 6;
    case _COORD_SWISS_GRID_PLUS: //= 7;
    case _COORD_MERCATOR: //= 12;
    case _COORD_NATURAL_AREA_CODE: //= 13;
      targetCoordData = targetCoord.split('\n');
      _listAdd(targetData, targetCoordData[0].split(': ')[1]);
      _listAdd(targetData, targetCoordData[1].split(': ')[1]);
      break;

    case _COORD_MAIDENHEAD: //= 11;
    case _COORD_GEOHASH: //= 15;
    case _COORD_GEO3X3: //= 16;
    case _COORD_GEOHEX: //= 17;
    case _COORD_OPEN_LOCATION_CODE: //= 18;
    case _COORD_MAKANEY: //= 19;
    case _COORD_QUADTREE: //= 20;
    _listAdd(targetData, targetCoord);
      break;

    case _COORD_REVERSE_WIG_WALDMEISTER: //= 21;
      targetCoordData = targetCoord.split('\n');
      _listAdd(targetData, targetCoordData[0]);
      _listAdd(targetData, targetCoordData[1]);
      _listAdd(targetData, targetCoordData[2]);
      break;

    case _COORD_REVERSE_WIG_DAY1976: //= 22;
      targetCoordData = targetCoord.split('\n');
      _listAdd(targetData, targetCoordData[0]);
      _listAdd(targetData, targetCoordData[1]);
      break;

    default:
      _handleError(_INVALIDCOORDINATEFORMAT);
  }

  return targetData;
}

void _convertFrom(Object source, _GCWList parameter) {
  if (_isNotNumber(source)) {
    _handleError(_INVALIDTYPECAST);
  }

  late LatLng coord;
  late Object parameter_1;
  late Object parameter_2;
  late Object parameter_3;
  late Object parameter_4;
  // TODO
  switch (source as num) {
    case _COORD_DEC:
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isNotNumber(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotNumber(parameter_2)) _handleError(_INVALIDTYPECAST);
      coord = LatLng(parameter_1 as double, parameter_2 as double);
      break;
    case _COORD_UTM: //= 3;
      if (_listLength(parameter) != 4) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      parameter_3 = _listGet(parameter, 2)!;
      parameter_4 = _listGet(parameter, 3)!;
      if (_isNotInt(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotString(parameter_2)) _handleError(_INVALIDTYPECAST);
      if (_isNotNumber(parameter_3)) _handleError(_INVALIDTYPECAST);
      if (_isNotNumber(parameter_4)) _handleError(_INVALIDTYPECAST);
      UTMREF utm = UTMREF(UTMZone(parameter_1 as int, parameter_1, parameter_2 as String), parameter_3 as double, parameter_4 as double);
      coord = UTMREFtoLatLon(utm, defaultEllipsoid);
      break;
    case _COORD_DMM: //= 1;
    case _COORD_DMS: //= 2;

    case _COORD_MGRS: //= 4;
    case _COORD_XYZ: //= 5;
    case _COORD_SWISS_GRID: //= 6;
    case _COORD_SWISS_GRID_PLUS: //= 7;
    case _COORD_DUTCH_GRID: //= 8;
    //case _COORD_GAUSS_KRUEGER ://= 9;
    case _COORD_GAUSS_KRUEGER_GK1: //= 901;
    case _COORD_GAUSS_KRUEGER_GK2: //= 902;
    case _COORD_GAUSS_KRUEGER_GK3: //= 903;
    case _COORD_GAUSS_KRUEGER_GK4: //= 904;
    case _COORD_GAUSS_KRUEGER_GK5: //= 905;
    //case _COORD_LAMBERT ://= 10;
    case _COORD_LAMBERT93: //= 1093;
    case _COORD_LAMBERT2008: //= 1008;
    case _COORD_ETRS89LCC: //= 1089;
    case _COORD_LAMBERT72: //= 1072;
    case _COORD_LAMBERT93_CC42: //= 1042;
    case _COORD_LAMBERT93_CC43: //= 1043;
    case _COORD_LAMBERT93_CC44: //= 1044;
    case _COORD_LAMBERT93_CC45: //= 1045;
    case _COORD_LAMBERT93_CC46: //= 1046;
    case _COORD_LAMBERT93_CC47: //= 1047;
    case _COORD_LAMBERT93_CC48: //= 1048;
    case _COORD_LAMBERT93_CC49: //= 1049;
    case _COORD_LAMBERT93_CC50: //= 1050;
    case _COORD_MAIDENHEAD: //= 11;
    case _COORD_MERCATOR: //= 12;
    case _COORD_NATURAL_AREA_CODE: //= 13;
    //case _COORD_SLIPPY_MAP ://= 14;
    case _COORD_SLIPPYMAP_0: //= 1400;
    case _COORD_SLIPPYMAP_1: //= 1401;
    case _COORD_SLIPPYMAP_2: //= 1402;
    case _COORD_SLIPPYMAP_3: //= 1403;
    case _COORD_SLIPPYMAP_4: //= 1404;
    case _COORD_SLIPPYMAP_5: //= 1405;
    case _COORD_SLIPPYMAP_6: //= 1406;
    case _COORD_SLIPPYMAP_7: //= 1407;
    case _COORD_SLIPPYMAP_8: //= 1408;
    case _COORD_SLIPPYMAP_9: //= 1409;
    case _COORD_SLIPPYMAP_10: //= 1410;
    case _COORD_SLIPPYMAP_11: //= 1411;
    case _COORD_SLIPPYMAP_12: //= 1412;
    case _COORD_SLIPPYMAP_13: //= 1413;
    case _COORD_SLIPPYMAP_14: //= 1414;
    case _COORD_SLIPPYMAP_15: //= 1415;
    case _COORD_SLIPPYMAP_16: //= 1416;
    case _COORD_SLIPPYMAP_17: //= 1417;
    case _COORD_SLIPPYMAP_18: //= 1418;
    case _COORD_SLIPPYMAP_19: //= 1419;
    case _COORD_SLIPPYMAP_20: //= 1420;
    case _COORD_SLIPPYMAP_21: //= 1421;
    case _COORD_SLIPPYMAP_22: //= 1422;
    case _COORD_SLIPPYMAP_23: //= 1423;
    case _COORD_SLIPPYMAP_24: //= 1424;
    case _COORD_SLIPPYMAP_25: //= 1425;
    case _COORD_SLIPPYMAP_26: //= 1426;
    case _COORD_SLIPPYMAP_27: //= 1427;
    case _COORD_SLIPPYMAP_28: //= 1428;
    case _COORD_SLIPPYMAP_29: //= 1429;
    case _COORD_SLIPPYMAP_30: //= 1430;
    case _COORD_GEOHASH: //= 15;
    case _COORD_GEO3X3: //= 16;
    case _COORD_GEOHEX: //= 17;
    case _COORD_OPEN_LOCATION_CODE: //= 18;
    case _COORD_MAKANEY: //= 19;
    case _COORD_QUADTREE: //= 20;
    case _COORD_REVERSE_WIG_WALDMEISTER: //= 21;
    case _COORD_REVERSE_WIG_DAY1976: //= 22;
      break;
    default:
      _handleError(_INVALIDCOORDINATEFORMAT);
  }

  List<String> targetCoord =
      formatCoordOutput(coord, CoordinateFormat(_GCW_SCRIPT_COORD_CONVERTER[source]!)).split('\n');
  _setLat(targetCoord[0] as double);
  _setLon(targetCoord[1] as double);
}

double _distance(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(_INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double),
          const Ellipsoid(ELLIPSOID_NAME_WGS84, 6378137.0, 298.257223563))
      .distance;
}

double _bearing(Object x1, Object y1, Object x2, Object y2) {
  if (_isString(x1) || _isString(y1) || _isString(x2) || _isString(y2)) {
    _handleError(_INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double), defaultEllipsoid)
      .bearingAToB;
}

void _projection(Object x1, Object y1, Object dist, Object angle) {
  if (_isString(x1) || _isString(y1) || _isString(dist) || _isString(angle)) {
    _handleError(_INVALIDTYPECAST);
  }
  LatLng _currentValues =
      projection(LatLng(x1 as double, y1 as double), angle as double, dist as double, defaultEllipsoid);
  _state.GCWizardScript_LAT = _currentValues.latitude;
  _state.GCWizardScript_LON = _currentValues.longitude;
}

void _centerThreePoints(Object lat1, Object lon1, Object lat2, Object lon2, Object lat3, Object lon3) {
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

  _state.GCWizardScript_LON =
      (aSlope * bSlope * (lat1 - lat3) + bSlope * (lon1 + lon2) - aSlope * (lon2 + lon3)) / (2 * (bSlope - aSlope));
  _state.GCWizardScript_LAT = -1 * (_state.GCWizardScript_LON - (lon1 + lon2) / 2) / aSlope + (lat1 + lat2) / 2;
}

void _centerTwoPoints(Object lat1, Object lon1, Object lat2, Object lon2) {
  if (_isString(lat1) || _isString(lon1) || _isString(lat2) || _isString(lon2)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }
  CenterPointDistance coord = centerPointTwoPoints(
      LatLng(lat1 as double, lon1 as double), LatLng(lat2 as double, lon2 as double), defaultEllipsoid);
  _state.GCWizardScript_LAT = coord.centerPoint.latitude;
  _state.GCWizardScript_LON = coord.centerPoint.longitude;
}
