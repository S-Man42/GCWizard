part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

String _wgs84(Object x, Object y) {
  if (_isNotANumber(x) || _isNotANumber(y)) {
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
  if (_isNotANumber(x)) {
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
  if (_isNotANumber(x)) {
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
  if (_isNotAInt(target)) {
    _handleError(_INVALIDTYPECAST);
  }

  LatLng coord = LatLng(_getLat(), _getLon());

  if (_GCW_SCRIPT_COORD_CONVERTER[target as int] == null) {
    _handleError(_INVALIDCOORDINATEFORMAT);
  }

  _GCWList targetData = _GCWList();

  switch (target) {
    case _COORD_DMM: //= 1;
      DMM result = DMM.fromLatLon(coord);

      _listAdd(
          targetData,
          _latSign(result.dmmLatitude.sign) +
              ' ' +
              result.dmmLatitude.degrees.toString() +
              '° ' +
              result.dmmLatitude.minutes.toStringAsFixed(3) +
              "' " +
              _latSign(result.dmmLongitude.sign) +
              ' ' +
              result.dmmLongitude.degrees.toString() +
              '° ' +
              result.dmmLatitude.minutes.toStringAsFixed(3) +
              "'");
      _listAdd(
          targetData,
          _latSign(result.dmmLatitude.sign) +
              ' ' +
              result.dmmLatitude.degrees.toString() +
              '° ' +
              result.dmmLatitude.minutes.toStringAsFixed(3) +
              "'");
      _listAdd(targetData, _latSign(result.dmmLatitude.sign));
      _listAdd(targetData, result.dmmLatitude.degrees);
      _listAdd(targetData, result.dmmLatitude.minutes);
      _listAdd(
          targetData,
          _lonSign(result.dmmLongitude.sign) +
              ' ' +
              result.dmmLongitude.degrees.toString() +
              '° ' +
              result.dmmLongitude.minutes.toStringAsFixed(3) +
              "'");
      _listAdd(targetData, _lonSign(result.dmmLongitude.sign));
      _listAdd(targetData, result.dmmLongitude.degrees);
      _listAdd(targetData, result.dmmLongitude.minutes);
      break;

    case _COORD_DMS: //= 2;
      DMS result = DMS.fromLatLon(coord);

      _listAdd(
          targetData,
          _latSign(result.dmsLatitude.sign) +
              ' ' +
              result.dmsLatitude.degrees.toString() +
              '° ' +
              result.dmsLatitude.minutes.toStringAsFixed(3) +
              "' " +
              result.dmsLatitude.seconds.toStringAsFixed(3) +
              _latSign(result.dmsLongitude.sign) +
              ' ' +
              result.dmsLongitude.degrees.toString() +
              '° ' +
              result.dmsLatitude.minutes.toStringAsFixed(3) +
              "' " +
              result.dmsLongitude.seconds.toStringAsFixed(3) +
              '"');
      _listAdd(
          targetData,
          _latSign(result.dmsLatitude.sign) +
              ' ' +
              result.dmsLatitude.degrees.toString() +
              '° ' +
              result.dmsLatitude.minutes.toStringAsFixed(3) +
              "' " +
              result.dmsLatitude.seconds.toStringAsFixed(3) +
              '"');
      _listAdd(targetData, _latSign(result.dmsLatitude.sign));
      _listAdd(targetData, result.dmsLatitude.degrees);
      _listAdd(targetData, result.dmsLatitude.minutes);
      _listAdd(targetData, result.dmsLatitude.seconds);
      _listAdd(
          targetData,
          _lonSign(result.dmsLongitude.sign) +
              ' ' +
              result.dmsLongitude.degrees.toString() +
              '° ' +
              result.dmsLongitude.minutes.toStringAsFixed(3) +
              "' " +
              result.dmsLongitude.seconds.toStringAsFixed(3) +
              '"');
      _listAdd(targetData, _lonSign(result.dmsLongitude.sign));
      _listAdd(targetData, result.dmsLongitude.degrees);
      _listAdd(targetData, result.dmsLongitude.minutes);
      _listAdd(targetData, result.dmsLongitude.seconds);
      break;

    case _COORD_UTM: //= 3;
      UTMREF result = UTMREF.fromLatLon(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
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
      MGRS result = MGRS.fromLatLon(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
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
      XYZ result = XYZ.fromLatLon(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(targetData, 'X: ' + result.x.toString() + '\nY: ' + result.y.toString() + '\nZ: ' + result.z.toString());
      _listAdd(targetData, result.x);
      _listAdd(targetData, result.y);
      _listAdd(targetData, result.z);
      break;

    case _COORD_SWISS_GRID: //= 6;
    case _COORD_SWISS_GRID_PLUS: //= 7;
      SwissGrid result = SwissGrid.fromLatLon(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(targetData, result.easting.toString() + ' ' + result.northing.toString());
      _listAdd(targetData, result.easting);
      _listAdd(targetData, result.northing);
      break;

    case _COORD_DUTCH_GRID: //= 8;
      DutchGrid result = DutchGrid.fromLatLon(coord);
      _listAdd(targetData, 'X: ' + result.x.toString() + '\nY: ' + result.y.toString());
      _listAdd(targetData, result.x);
      _listAdd(targetData, result.y);
      break;

    case _COORD_GAUSS_KRUEGER_GK1: //= 901;
    case _COORD_GAUSS_KRUEGER_GK2: //= 902;
    case _COORD_GAUSS_KRUEGER_GK3: //= 903;
    case _COORD_GAUSS_KRUEGER_GK4: //= 904;
    case _COORD_GAUSS_KRUEGER_GK5: //= 905;
      GaussKrueger result = GaussKrueger.fromLatLon(
          coord, _GCW_SCRIPT_COORD_CONVERTER[target]!, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(targetData, result.easting.toString() + ' ' + result.northing.toString());
      _listAdd(targetData, result.easting);
      _listAdd(targetData, result.northing);
      break;

    case _COORD_LAMBERT2008: //= 1008;
    case _COORD_LAMBERT93: //= 1093;
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
      Lambert result =
          Lambert.fromLatLon(coord, _GCW_SCRIPT_COORD_CONVERTER[target]!, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(targetData, result.easting.toString() + ' ' + result.northing.toString());
      _listAdd(targetData, result.easting);
      _listAdd(targetData, result.northing);
      break;

    case _COORD_MAIDENHEAD: //= 11;
      Maidenhead result = Maidenhead.fromLatLon(coord);
      _listAdd(targetData, result.text);
      break;

    case _COORD_MERCATOR: //= 12;
      Mercator result = Mercator.fromLatLon(coord, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      _listAdd(targetData, result.easting.toString() + result.northing.toString());
      _listAdd(targetData, result.easting);
      _listAdd(targetData, result.northing);
      break;

    case _COORD_NATURAL_AREA_CODE: //= 13;
      NaturalAreaCode result = NaturalAreaCode.fromLatLon(coord);
      _listAdd(targetData, 'X: ' + result.x.toString() + '\nY: ' + result.y.toString());
      _listAdd(targetData, result.x);
      _listAdd(targetData, result.y);
      break;

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
      SlippyMap result = SlippyMap.fromLatLon(coord, _GCW_SCRIPT_COORD_CONVERTER[target]!);
      _listAdd(targetData, result.x.toString() + ' ' + result.y.toString());
      _listAdd(targetData, result.x);
      _listAdd(targetData, result.y);
      break;

    case _COORD_GEOHASH: //= 15;
      Geohash result = Geohash.fromLatLon(coord, 14);
      _listAdd(targetData, result.text);
      break;

    case _COORD_GEO3X3: //= 16;
      Geo3x3 result = Geo3x3.fromLatLon(coord, 20);
      _listAdd(targetData, result.text);
      break;

    case _COORD_GEOHEX: //= 17;
      GeoHex result = GeoHex.fromLatLon(coord, 20);
      _listAdd(targetData, result.text);
      break;

    case _COORD_OPEN_LOCATION_CODE: //= 18;
      OpenLocationCode result = OpenLocationCode.fromLatLon(coord);
      _listAdd(targetData, result.text);
      break;

    case _COORD_MAKANEY: //= 19;
      Makaney result = Makaney.fromLatLon(coord);
      _listAdd(targetData, result.text);
      break;

    case _COORD_QUADTREE: //= 20;
      Quadtree result = Quadtree.fromLatLon(coord);
      _listAdd(targetData, result.coords.join(' '));
      break;

    case _COORD_REVERSE_WIG_WALDMEISTER: //= 21;
      ReverseWherigoWaldmeister result = ReverseWherigoWaldmeister.fromLatLon(coord);
      _listAdd(targetData, result.a.toString() + ' ' + result.b.toString() + ' ' + result.c.toString());
      _listAdd(targetData, result.a);
      _listAdd(targetData, result.b);
      _listAdd(targetData, result.c);
      break;

    case _COORD_REVERSE_WIG_DAY1976: //= 22;
      ReverseWherigoDay1976 result = ReverseWherigoDay1976.fromLatLon(coord);
      _listAdd(targetData, result.s.toString() + ' ' + result.t.toString());
      _listAdd(targetData, result.s);
      _listAdd(targetData, result.t);
      break;

    default:
      _handleError(_INVALIDCOORDINATEFORMAT);
  }

  return targetData;
}

void _convertFrom(Object source, _GCWList parameter) {
  if (_isNotANumber(source)) {
    _handleError(_INVALIDTYPECAST);
  }
  late LatLng? coord;
  late Object parameter_1;
  late Object parameter_2;
  late Object parameter_3;
  late Object parameter_4;
  late Object parameter_5;
  late Object parameter_6;
  late Object parameter_7;
  late Object parameter_8;

  switch (source as num) {
    case _COORD_DMM: //= 1;
      if (_listLength(parameter) != 6) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if ((parameter_1 as String).toUpperCase() == 'N') {
        parameter_1 = 1;
      } else {
        parameter_1 = -1;
      }
      parameter_2 = _listGet(parameter, 1)!;
      parameter_3 = _listGet(parameter, 2)!;
      parameter_4 = _listGet(parameter, 3)!;
      if ((parameter_4 as String).toUpperCase() == 'E') {
        parameter_4 = 1;
      } else {
        parameter_4 = -1;
      }
      parameter_5 = _listGet(parameter, 4)!;
      parameter_6 = _listGet(parameter, 5)!;
      if (_isNotAString(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotAInt(parameter_2)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_3)) _handleError(_INVALIDTYPECAST);
      if (_isNotAString(parameter_4)) _handleError(_INVALIDTYPECAST);
      if (_isNotAInt(parameter_5)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_6)) _handleError(_INVALIDTYPECAST);
      DMM result = DMM(
        DMMLatitude(parameter_1 as int, parameter_2 as int, parameter_3 as double),
        DMMLongitude(parameter_4 as int, parameter_5 as int, parameter_6 as double),
      );
      coord = result.toLatLng();
      break;

    case _COORD_DMS: //= 2;
      if (_listLength(parameter) != 8) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if ((parameter_1 as String).toUpperCase() == 'N') {
        parameter_1 = 1;
      } else {
        parameter_1 = -1;
      }
      parameter_2 = _listGet(parameter, 1)!;
      parameter_3 = _listGet(parameter, 2)!;
      parameter_4 = _listGet(parameter, 3)!;
      parameter_5 = _listGet(parameter, 4)!;
      if ((parameter_5 as String).toUpperCase() == 'E') {
        parameter_5 = 1;
      } else {
        parameter_5 = -1;
      }
      parameter_6 = _listGet(parameter, 5)!;
      parameter_7 = _listGet(parameter, 6)!;
      parameter_8 = _listGet(parameter, 7)!;
      if (_isNotAString(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotAInt(parameter_2)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_3)) _handleError(_INVALIDTYPECAST);
      if (_isNotAString(parameter_4)) _handleError(_INVALIDTYPECAST);
      if (_isNotAInt(parameter_5)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_6)) _handleError(_INVALIDTYPECAST);
      DMS result = DMS(
        DMSLatitude(parameter_1 as int, parameter_2 as int, parameter_3 as int, parameter_7 as double),
        DMSLongitude(parameter_5 as int, parameter_6 as int, parameter_7 as int, parameter_8 as double),
      );
      coord = result.toLatLng();
      break;

    case _COORD_UTM: //= 3;
      if (_listLength(parameter) != 4) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      parameter_3 = _listGet(parameter, 2)!;
      parameter_4 = _listGet(parameter, 3)!;
      if (_isNotAInt(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotAString(parameter_2)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_3)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_4)) _handleError(_INVALIDTYPECAST);
      UTMREF result = UTMREF(UTMZone(parameter_1 as int, parameter_1, parameter_2.toString()), parameter_3 as double,
          parameter_4 as double);
      coord = result.toLatLng(ells: getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      break;

    case _COORD_MGRS: //= 4;
      if (_listLength(parameter) != 5) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      parameter_3 = _listGet(parameter, 2)!;
      parameter_4 = _listGet(parameter, 3)!;
      parameter_5 = _listGet(parameter, 4)!;
      if (_isNotAInt(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotAString(parameter_2)) _handleError(_INVALIDTYPECAST);
      if (_isNotAString(parameter_3)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_4)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_5)) _handleError(_INVALIDTYPECAST);
      MGRS result = MGRS(UTMZone(parameter_1 as int, parameter_1, parameter_2 as String), parameter_3 as String,
          parameter_4 as double, parameter_5 as double);
      coord = result.toLatLng(ells: getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      break;

    case _COORD_XYZ: //= 5;
      if (_listLength(parameter) != 3) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      parameter_3 = _listGet(parameter, 2)!;
      if (_isNotANumber(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_2)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_3)) _handleError(_INVALIDTYPECAST);
      XYZ result = XYZ(
        parameter_1 as double,
        parameter_2 as double,
        parameter_3 as double,
      );
      coord = result.toLatLng(ells: getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      break;

    case _COORD_SWISS_GRID: //= 6;
    case _COORD_SWISS_GRID_PLUS: //= 7;
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isNotANumber(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_2)) _handleError(_INVALIDTYPECAST);
      SwissGrid result = SwissGrid(
        parameter_1 as double,
        parameter_2 as double,
      );
      coord = result.toLatLng(ells: getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      break;

    case _COORD_DUTCH_GRID: //= 8;
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isNotANumber(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_2)) _handleError(_INVALIDTYPECAST);
      DutchGrid result = DutchGrid(
        parameter_1 as double,
        parameter_2 as double,
      );
      coord = result.toLatLng();
      break;

    case _COORD_GAUSS_KRUEGER_GK1: //= 901;
    case _COORD_GAUSS_KRUEGER_GK2: //= 902;
    case _COORD_GAUSS_KRUEGER_GK3: //= 903;
    case _COORD_GAUSS_KRUEGER_GK4: //= 904;
    case _COORD_GAUSS_KRUEGER_GK5: //= 905;
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isNotANumber(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_2)) _handleError(_INVALIDTYPECAST);
      GaussKrueger result = GaussKrueger(
        parameter_1 as double,
        parameter_2 as double,
        _GCW_SCRIPT_COORD_CONVERTER[source]!
      );
      coord = result.toLatLng(ells: getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      break;

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
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isNotANumber(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_2)) _handleError(_INVALIDTYPECAST);
      Lambert result = Lambert(
        parameter_1 as double,
        parameter_2 as double,
        _GCW_SCRIPT_COORD_CONVERTER[source]!
      );
      coord = result.toLatLng(ells: getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      break;

    case _COORD_MAIDENHEAD: //= 11;
      if (_listLength(parameter) != 1) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if (_isAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      Maidenhead result = Maidenhead(parameter_1 as String);
      coord = result.toLatLng();
      break;

    case _COORD_MERCATOR: //= 12;
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isNotANumber(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_2)) _handleError(_INVALIDTYPECAST);
      Mercator result = Mercator(
        parameter_1 as double,
        parameter_2 as double,
      );
      coord = result.toLatLng(ells: getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
      break;

    case _COORD_NATURAL_AREA_CODE: //= 13;
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isAList(parameter_2)) _handleError(_INVALIDTYPECAST);
      NaturalAreaCode result = NaturalAreaCode(
        parameter_1 as String,
        parameter_2 as String,
      );
      coord = result.toLatLng();
      break;

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
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isNotANumber(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotANumber(parameter_2)) _handleError(_INVALIDTYPECAST);
      SlippyMap result = SlippyMap(parameter_1 as double, parameter_2 as double, _GCW_SCRIPT_COORD_CONVERTER[source]!);
      coord = result.toLatLng();
      break;

    case _COORD_GEOHASH: //= 15;
      if (_listLength(parameter) != 1) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if (_isAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      Geohash result = Geohash(parameter_1 as String);
      coord = result.toLatLng();
      break;

    case _COORD_GEO3X3: //= 16;
      if (_listLength(parameter) != 1) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if (_isAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      Geo3x3 result = Geo3x3(parameter_1 as String);
      coord = result.toLatLng();
      break;

    case _COORD_GEOHEX: //= 17;
      if (_listLength(parameter) != 1) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if (_isAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      GeoHex result = GeoHex(parameter_1 as String);
      coord = result.toLatLng();
      break;

    case _COORD_OPEN_LOCATION_CODE: //= 18;
      if (_listLength(parameter) != 1) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if (_isAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      OpenLocationCode result = OpenLocationCode(parameter_1 as String);
      coord = result.toLatLng();
      break;

    case _COORD_MAKANEY: //= 19;
      if (_listLength(parameter) != 1) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if (_isAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      Makaney result = Makaney(parameter_1 as String);
      coord = result.toLatLng();
      break;

    case _COORD_QUADTREE: //= 20;
      if (_listLength(parameter) != 1) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      if (_isNotAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      Quadtree result = Quadtree(parameter_1 as List<int>);
      coord = result.toLatLng();
      break;

    case _COORD_REVERSE_WIG_WALDMEISTER: //= 21;
      if (_listLength(parameter) != 3) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      parameter_3 = _listGet(parameter, 2)!;
      if (_isNotAInt(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isNotAInt(parameter_2)) _handleError(_INVALIDTYPECAST);
      if (_isNotAInt(parameter_3)) _handleError(_INVALIDTYPECAST);
      ReverseWherigoWaldmeister result =
          ReverseWherigoWaldmeister(parameter_1 as int, parameter_2 as int, parameter_3 as int);
      coord = result.toLatLng();
      break;

    case _COORD_REVERSE_WIG_DAY1976: //= 22;
      if (_listLength(parameter) != 2) _handleError(_INVALIDNUMBEROFPARAMETER);
      parameter_1 = _listGet(parameter, 0)!;
      parameter_2 = _listGet(parameter, 1)!;
      if (_isAList(parameter_1)) _handleError(_INVALIDTYPECAST);
      if (_isAList(parameter_2)) _handleError(_INVALIDTYPECAST);
      ReverseWherigoDay1976 result = ReverseWherigoDay1976(parameter_1 as String, parameter_2 as String);
      coord = result.toLatLng();
      break;

    default:
      _handleError(_INVALIDCOORDINATEFORMAT);
      coord = const LatLng(0.0, 0.0);
  }

  _setLat(coord!.latitude);
  _setLon(coord.longitude);
}

double _distance(Object lat1, Object lon1, Object lat2, Object lon2) {
  if (_isNotANumber(lat1) || _isNotANumber(lon1) || _isNotANumber(lat2) || _isNotANumber(lon2)) {
    _handleError(_INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(lat1 as double, lon1 as double), LatLng(lat2 as double, lon2 as double),
          const Ellipsoid(ELLIPSOID_NAME_WGS84, 6378137.0, 298.257223563))
      .distance;
}

double _bearing(Object lat1, Object lon1, Object lat2, Object lon2) {
  if (_isNotANumber(lat1) || _isNotANumber(lon1) || _isNotANumber(lat2) || _isNotANumber(lon2)) {
    _handleError(_INVALIDTYPECAST);
  }
  return distanceBearing(LatLng(lat1 as double, lon1 as double), LatLng(lat2 as double, lon2 as double),
          getEllipsoidByName(ELLIPSOID_NAME_WGS84)!)
      .bearingAToB;
}

void _projection(Object lat, Object lon, Object distance, Object bearing) {
  if (_isNotANumber(lat) || _isNotANumber(lon) || _isNotANumber(distance) || _isNotANumber(bearing)) {
    _handleError(_INVALIDTYPECAST);
  } else {
    lat = lat as double;
    lon = lon as double;
    if (_isAInt(bearing)) bearing = (bearing as int).toDouble();
    bearing = bearing as double;
    if (_isAInt(distance)) distance = (distance as int).toDouble();
    distance = distance as double;
    distanceBearing(LatLng(lat, lon), LatLng(lat, lon), getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
    LatLng _currentValues = projection(LatLng(lat, lon), bearing, distance, getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
    _state.GCWizardScript_LAT = _currentValues.latitude;
    _state.GCWizardScript_LON = _currentValues.longitude;
  }
}

void _centerThreePoints(Object lat1, Object lon1, Object lat2, Object lon2, Object lat3, Object lon3) {
  if (_isNotANumber(lat1) ||
      _isNotANumber(lon1) ||
      _isNotANumber(lat2) ||
      _isNotANumber(lon2) ||
      _isNotANumber(lat3) ||
      _isNotANumber(lon3)) {
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
  if (_isNotANumber(lat1) || _isNotANumber(lon1) || _isNotANumber(lat2) || _isNotANumber(lon2)) {
    _handleError(_INVALIDTYPECAST);
    return;
  }
  CenterPointDistance coord = centerPointTwoPoints(LatLng(lat1 as double, lon1 as double),
      LatLng(lat2 as double, lon2 as double), getEllipsoidByName(ELLIPSOID_NAME_WGS84)!);
  _state.GCWizardScript_LAT = coord.centerPoint.latitude;
  _state.GCWizardScript_LON = coord.centerPoint.longitude;
}

double _dmmtodec(Object? dec, Object? min) {
  if (_isNotAInt(dec)) {
    _handleError(_INVALIDTYPECAST);
  }
  if (_isNotANumber(min)) {
    _handleError(_INVALIDTYPECAST);
  }
  return (dec as int) + (min as num).toDouble() / 60;
}

double _dmstodec(Object? dec, Object? min, Object? sec) {
  if (_isNotAInt(dec)) {
    _handleError(_INVALIDTYPECAST);
  }
  if (_isNotAInt(min)) {
    _handleError(_INVALIDTYPECAST);
  }
  if (_isNotANumber(sec)) {
    _handleError(_INVALIDTYPECAST);
  }
  return (dec as int) + (min as int) / 60 + (sec as num).toDouble() / 3600;
}

String _dectodmm(Object? dec) {
  if (_isNotANumber(dec)) _handleError(_INVALIDTYPECAST);
  String result = '';
  double ms = 0.0;

  result = ((dec as double).truncate()).toString() + '° ';
  ms = (dec - dec.truncate()) * 60;
  result = result + ms.toStringAsFixed(3) + "' ";

  return result;
}

String _dectodms(Object? dec) {
  if (_isNotANumber(dec)) _handleError(_INVALIDTYPECAST);
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
  if (_isNotAInt(dec)) _handleError(_INVALIDTYPECAST);
  if (_isNotANumber(min)) _handleError(_INVALIDTYPECAST);
  return (_dectodms(_dmmtodec(dec as int, min as double)));
}

String _dmstodmm(Object? dec, Object? min, Object? sec) {
  if (_isNotAInt(dec)) _handleError(_INVALIDTYPECAST);
  if (_isNotAInt(min)) _handleError(_INVALIDTYPECAST);
  if (_isNotANumber(sec)) _handleError(_INVALIDTYPECAST);

  return (_dectodmm(_dmstodec(dec as int, min as int, sec as double)));
}

String _latSign(int sign) {
  if (sign == 1) {
    return 'N';
  }
  return 'S';
}

String _lonSign(int sign) {
  if (sign == 1) {
    return 'E';
  }
  return 'W';
}
