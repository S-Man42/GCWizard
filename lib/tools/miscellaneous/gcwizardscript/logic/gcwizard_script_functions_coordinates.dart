part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

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
  if (_isNotInt(target)) {
    _handleError(_INVALIDTYPECAST);
  }

  LatLng coord = LatLng(_getLat(), _getLon());
  String targetCoord = '';

  if (_GCW_SCRIPT_COORD_CONVERTER[target as int] == null) {
    _handleError(_INVALIDCOORDINATEFORMAT);
  }

  List<String> targetCoordData = [];
  _GCWList targetData = _GCWList();

  switch (target) {
    case _COORD_DMM: //= 1;
      DMM result = latLonToDMM(coord);

      _listAdd(
          targetData,
          latSign(result.latitude.sign) +
              ' ' +
              result.latitude.degrees.toString() +
              '° ' +
              result.latitude.minutes.toStringAsFixed(3) +
              "' " +
              latSign(result.longitude.sign) +
              ' ' +
              result.longitude.degrees.toString() +
              '° ' +
              result.latitude.minutes.toStringAsFixed(3) +
              "'");
      _listAdd(
          targetData,
          latSign(result.latitude.sign) +
              ' ' +
              result.latitude.degrees.toString() +
              '° ' +
              result.latitude.minutes.toStringAsFixed(3) +
              "'");
      _listAdd(targetData, latSign(result.latitude.sign));
      _listAdd(targetData, result.latitude.degrees);
      _listAdd(targetData, result.latitude.minutes);
      _listAdd(
          targetData,
          lonSign(result.longitude.sign) +
              ' ' +
              result.longitude.degrees.toString() +
              '° ' +
              result.longitude.minutes.toStringAsFixed(3) +
              "'");
      _listAdd(targetData, lonSign(result.longitude.sign));
      _listAdd(targetData, result.longitude.degrees);
      _listAdd(targetData, result.longitude.minutes);
      break;

    case _COORD_DMS: //= 2;
      DMS result = latLonToDMS(coord);

      _listAdd(
          targetData,
          latSign(result.latitude.sign) +
              ' ' +
              result.latitude.degrees.toString() +
              '° ' +
              result.latitude.minutes.toStringAsFixed(3) +
              "' " +
              result.latitude.seconds.toStringAsFixed(3) +
              latSign(result.longitude.sign) +
              ' ' +
              result.longitude.degrees.toString() +
              '° ' +
              result.latitude.minutes.toStringAsFixed(3) +
              "' " +
              result.longitude.seconds.toStringAsFixed(3) +
              '"');
      _listAdd(
          targetData,
          latSign(result.latitude.sign) +
              ' ' +
              result.latitude.degrees.toString() +
              '° ' +
              result.latitude.minutes.toStringAsFixed(3) +
              "' " +
              result.latitude.seconds.toStringAsFixed(3) +
              '"');
      _listAdd(targetData, latSign(result.latitude.sign));
      _listAdd(targetData, result.latitude.degrees);
      _listAdd(targetData, result.latitude.minutes);
      _listAdd(targetData, result.latitude.seconds);
      _listAdd(
          targetData,
          lonSign(result.longitude.sign) +
              ' ' +
              result.longitude.degrees.toString() +
              '° ' +
              result.longitude.minutes.toStringAsFixed(3) +
              "' " +
              result.longitude.seconds.toStringAsFixed(3) +
              '"');
      _listAdd(targetData, lonSign(result.longitude.sign));
      _listAdd(targetData, result.longitude.degrees);
      _listAdd(targetData, result.longitude.minutes);
      _listAdd(targetData, result.longitude.seconds);
      break;

    case _COORD_UTM: //= 3;
      UTMREF result = latLonToUTM(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(
          targetData,
          result.zone.lonZoneRegular.toString() +
              result.zone.latZone +
              ' ' +
              result.easting.toString() +
              ' ' +
              result.northing.toString());
      _listAdd(targetData, result.zone.lonZoneRegular);
      _listAdd(targetData, result.zone.latZone);
      _listAdd(targetData, result.easting);
      _listAdd(targetData, result.northing);
      break;

    case _COORD_MGRS: //= 4;
      MGRS result = latLonToMGRS(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(
          targetData,
          result.utmZone.lonZoneRegular.toString() +
              result.utmZone.latZone +
              ' ' +
              result.digraph +
              ' ' +
              result.easting.toString() +
              ' ' +
              result.northing.toString());
      _listAdd(targetData, result.utmZone.lonZoneRegular);
      _listAdd(targetData, result.utmZone.latZone);
      _listAdd(targetData, result.digraph);
      _listAdd(targetData, result.easting);
      _listAdd(targetData, result.northing);
      break;

    case _COORD_XYZ: //= 5;
      XYZ result = latLonToXYZ(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(targetData, 'X: ' + result.x.toString() + '\nY: ' + result.y.toString() + '\nZ: ' + result.z.toString());
      _listAdd(targetData, result.x);
      _listAdd(targetData, result.y);
      _listAdd(targetData, result.z);
      break;

    case _COORD_SWISS_GRID: //= 6;
    case _COORD_SWISS_GRID_PLUS: //= 7;
      SwissGrid result = latLonToSwissGrid(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(targetData, result.easting.toString() + result.northing.toString());
      _listAdd(targetData, result.easting);
      _listAdd(targetData, result.northing);
      break;

    case _COORD_DUTCH_GRID: //= 8;
      DutchGrid result = latLonToDutchGrid(coord);
      _listAdd(targetData, 'X: ' + result.x.toString() + '\nY: ' + result.y.toString());
      _listAdd(targetData, result.x);
      _listAdd(targetData, result.y);
      break;

    case _COORD_MAIDENHEAD: //= 11;
      Maidenhead result = latLonToMaidenhead(coord);
      _listAdd(targetData, result.text);
      break;

    case _COORD_MERCATOR: //= 12;
      Mercator result = latLonToMercator(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(targetData, result.easting.toString() + result.northing.toString());
      _listAdd(targetData, result.easting);
      _listAdd(targetData, result.northing);
      break;

    case _COORD_NATURAL_AREA_CODE: //= 13;
      NaturalAreaCode result = latLonToNaturalAreaCode(coord);
      _listAdd(targetData, 'X: ' + result.x.toString() + '\nY: ' + result.y.toString());
      _listAdd(targetData, result.x);
      _listAdd(targetData, result.y);
      break;

    case _COORD_GEOHASH: //= 15;
      Geohash result = latLonToGeohash(coord, 14);
      _listAdd(targetData, result.text);
      break;

    case _COORD_GEO3X3: //= 16;
      Geo3x3 result = latLonToGeo3x3(coord, 20);
      _listAdd(targetData, result.text);
      break;

    case _COORD_GEOHEX: //= 17;
      GeoHex result = latLonToGeoHex(coord, 20);
      _listAdd(targetData, result.text);
      break;

    case _COORD_OPEN_LOCATION_CODE: //= 18;
      OpenLocationCode result = latLonToOpenLocationCode(coord);
      _listAdd(targetData, result.text);
      break;

    case _COORD_MAKANEY: //= 19;
      Makaney result = latLonToMakaney(coord);
      _listAdd(targetData, result.text);
      break;

    case _COORD_QUADTREE: //= 20;
      Quadtree result = latLonToQuadtree(coord);
      _listAdd(targetData, result.coords.join(' '));
      break;

    case _COORD_REVERSE_WIG_WALDMEISTER: //= 21;
      ReverseWherigoWaldmeister result = latLonToReverseWIGWaldmeister(coord);
      _listAdd(targetData, result.a.toString() + ' ' + result.b.toString() + ' ' + result.c.toString());
      _listAdd(targetData, result.a);
      _listAdd(targetData, result.b);
      _listAdd(targetData, result.c);
     break;

    case _COORD_REVERSE_WIG_DAY1976: //= 22;
      ReverseWherigoDay1976 result = latLonToReverseWIGDay1976(coord);
      _listAdd(targetData, result.s.toString() + ' ' + result.t.toString());
      _listAdd(targetData, result.s);
      _listAdd(targetData, result.t);
      break;



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
      UTMREF utm = UTMREF(UTMZone(parameter_1 as int, parameter_1, parameter_2 as String), parameter_3 as double,
          parameter_4 as double);
      coord = UTMREFtoLatLon(utm, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
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
  return distanceBearing(LatLng(x1 as double, y1 as double), LatLng(x2 as double, y2 as double),
          getEllipsoidByName(ELLIPSOID_NAME_WGS84)!)
      .bearingAToB;
}

void _projection(Object x1, Object y1, Object dist, Object angle) {
  if (_isString(x1) || _isString(y1) || _isString(dist) || _isString(angle)) {
    _handleError(_INVALIDTYPECAST);
  }
  LatLng _currentValues = projection(
      LatLng(x1 as double, y1 as double), angle as double, dist as double, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
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
  CenterPointDistance coord = centerPointTwoPoints(LatLng(lat1 as double, lon1 as double),
      LatLng(lat2 as double, lon2 as double), getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
  _state.GCWizardScript_LAT = coord.centerPoint.latitude;
  _state.GCWizardScript_LON = coord.centerPoint.longitude;
}

double _dmmtodec(Object? dec, Object? min) {
  if (_isNotInt(dec)) _handleError(_INVALIDTYPECAST);
  if (_isNotNumber(min)) _handleError(_INVALIDTYPECAST);
  return (dec as int) + (min as double) / 60;
}

double _dmstodec(Object? dec, Object? min, Object? sec) {
  if (_isNotInt(dec)) _handleError(_INVALIDTYPECAST);
  if (_isNotInt(min)) _handleError(_INVALIDTYPECAST);
  if (_isNotNumber(sec)) _handleError(_INVALIDTYPECAST);
  return (dec as int) + (min as int) / 60 + (sec as double) / 3600;
}

String _dectodmm(Object? dec) {
  if (_isNotNumber(dec)) _handleError(_INVALIDTYPECAST);
  String result = '';
  double ms = 0.0;

  result = ((dec as double).truncate()).toString() + '° ';
  ms = (dec - dec.truncate()) * 60;
  result = result + ms.toStringAsFixed(3) + "' ";

  return result;
}

String _dectodms(Object? dec) {
  if (_isNotNumber(dec)) _handleError(_INVALIDTYPECAST);
  String result = '';
  double ms = 0.0;

  result = ((dec as double).truncate()).toString() + '° ';
  ms = (dec - dec.truncate()) * 60;
  result = result + ms.truncate().toString() + "' ";

  ms = (ms - ms.truncate()) * 60;
  result = result + ms.toStringAsFixed(3) + '"';

  return result;
}

String _dmmtodms(Object? dec, Object? min) {
  if (_isNotInt(dec)) _handleError(_INVALIDTYPECAST);
  if (_isNotNumber(min)) _handleError(_INVALIDTYPECAST);
  return (_dectodms(_dmmtodec(dec as int, min as double)));
}

String _dmstodmm(Object? dec, Object? min, Object? sec) {
  if (_isNotInt(dec)) _handleError(_INVALIDTYPECAST);
  if (_isNotInt(min)) _handleError(_INVALIDTYPECAST);
  if (_isNotNumber(sec)) _handleError(_INVALIDTYPECAST);

  return (_dectodmm(_dmstodec(dec as int, min as int, sec as double)));
}

String latSign(int sign) {
  if (sign == 1) {
    return 'N';
  }
  return 'S';
}

String lonSign(int sign) {
  if (sign == 1) {
    return 'E';
  }
  return 'W';
}
