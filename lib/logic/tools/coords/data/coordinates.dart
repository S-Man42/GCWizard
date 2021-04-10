import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

import 'package:gc_wizard/logic/tools/coords/converter/dec.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dmm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dms.dart';
import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geo3x3.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohash.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohex.dart';
import 'package:gc_wizard/logic/tools/coords/converter/maidenhead.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mercator.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mgrs.dart';
import 'package:gc_wizard/logic/tools/coords/converter/natural_area_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/open_location_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/logic/tools/coords/converter/reverse_whereigo_waldmeister.dart';
import 'package:gc_wizard/logic/tools/coords/converter/slippy_map.dart';
import 'package:gc_wizard/logic/tools/coords/converter/swissgrid.dart';
import 'package:gc_wizard/logic/tools/coords/converter/utm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/xyz.dart';

const keyCoordsDEC = 'coords_dec';
const keyCoordsDMM = 'coords_dmm';
const keyCoordsDMS = 'coords_dms';
const keyCoordsUTM = 'coords_utm';
const keyCoordsMGRS = 'coords_mgrs';
const keyCoordsXYZ = 'coords_xyz';
const keyCoordsSwissGrid = 'coords_swissgrid';
const keyCoordsSwissGridPlus = 'coords_swissgridplus';
const keyCoordsGaussKrueger = 'coords_gausskrueger';
const keyCoordsGaussKruegerGK1 = 'coords_gausskrueger_gk1';
const keyCoordsGaussKruegerGK2 = 'coords_gausskrueger_gk2';
const keyCoordsGaussKruegerGK3 = 'coords_gausskrueger_gk3';
const keyCoordsGaussKruegerGK4 = 'coords_gausskrueger_gk4';
const keyCoordsGaussKruegerGK5 = 'coords_gausskrueger_gk5';
const keyCoordsMaidenhead = 'coords_maidenhead';
const keyCoordsMercator = 'coords_mercator';
const keyCoordsNaturalAreaCode = 'coords_naturalareacode';
const keyCoordsSlippyMap = 'coords_slippymap';
const keyCoordsGeohash = 'coords_geohash';
const keyCoordsGeoHex = 'coords_geohex';
const keyCoordsGeo3x3 = 'coords_geo3x3';
const keyCoordsOpenLocationCode = 'coords_openlocationcode';
const keyCoordsQuadtree = 'coords_quadtree';
const keyCoordsReverseWhereIGoWaldmeister = 'coords_reversewhereigo_waldmeister';

class CoordinateFormat {
  final key;
  String name;
  List<CoordinateFormat> subtypes;
  String example;

  CoordinateFormat(this.key, this.name, this.example, {this.subtypes});
}

List<CoordinateFormat> allCoordFormats = [
  CoordinateFormat(keyCoordsDEC, 'DEC: DD.DDD°', '45.29100, -122.41333'),
  CoordinateFormat(keyCoordsDMM, 'DMM: DD° MM.MMM\'', 'N 45° 17.460\' W 122° 24.800\''),
  CoordinateFormat(keyCoordsDMS, 'DMS: DD° MM\' SS.SSS"', 'N 45° 17\' 27.60" W 122° 24\' 48.00"'),
  CoordinateFormat(keyCoordsUTM, 'UTM', '10 N 546003.6 5015445.0'),
  CoordinateFormat(keyCoordsMGRS, 'MGRS', '10T ER 46003.6 15445.0'),
  CoordinateFormat(keyCoordsXYZ, 'XYZ (ECEF)', 'X: -2409244, Y: -3794410, Z: 4510158'),
  CoordinateFormat(keyCoordsSwissGrid, 'SwissGrid (CH1903)', 'Y: 4295317.7, X: 1202252.3'),
  CoordinateFormat(keyCoordsSwissGridPlus, 'SwissGrid (CH1903+)', 'Y: 6295317.7, X: 2202252.3'),
  CoordinateFormat(keyCoordsGaussKrueger, 'coords_formatconverter_gausskrueger', 'R: 8837763.4, H: 5978799.1',
      subtypes: [
        CoordinateFormat(
            keyCoordsGaussKruegerGK1, 'coords_formatconverter_gausskrueger_gk1', 'R: 8837763.4, H: 5978799.1'),
        CoordinateFormat(
            keyCoordsGaussKruegerGK2, 'coords_formatconverter_gausskrueger_gk2', 'R: 8837739.4, H: 5978774.5'),
        CoordinateFormat(
            keyCoordsGaussKruegerGK3, 'coords_formatconverter_gausskrueger_gk3', 'R: 8837734.7, H: 5978798.2'),
        CoordinateFormat(
            keyCoordsGaussKruegerGK4, 'coords_formatconverter_gausskrueger_gk4', 'R: 8837790.8, H: 5978787.4'),
        CoordinateFormat(
            keyCoordsGaussKruegerGK5, 'coords_formatconverter_gausskrueger_gk5', 'R: 8837696.4, H: 5978779.5'),
      ]),
  CoordinateFormat(keyCoordsMaidenhead, 'Maidenhead Locator (QTH)', 'CN85TG09JU'),
  CoordinateFormat(keyCoordsMercator, 'Mercator', 'Y: 5667450.4, X: -13626989.9'),
  CoordinateFormat(keyCoordsNaturalAreaCode, 'Natural Area Code (NAC)', 'X: 4RZ000, Y: QJFMGZ'),
  CoordinateFormat(keyCoordsOpenLocationCode, 'OpenLocationCode (OLC, PlusCode)', '84QV7HRP+CM3'),
  CoordinateFormat(keyCoordsSlippyMap, 'Slippy Map Tiles', 'Z: 15, X: 5241, Y: 11749'),
  CoordinateFormat(keyCoordsReverseWhereIGoWaldmeister, 'Reverse WhereIGo (Waldmeister)', '042325, 436113, 935102'),
  CoordinateFormat(keyCoordsGeohash, 'Geohash', 'c20cwkvr4'),
  CoordinateFormat(keyCoordsQuadtree, 'Quadtree', '021230223311203323'),
  CoordinateFormat(keyCoordsGeoHex, 'GeoHex', 'RU568425483853568'),
  CoordinateFormat(keyCoordsGeo3x3, 'Geo3x3', 'W7392967941169'),
];

CoordinateFormat getCoordinateFormatByKey(String key) {
  return allCoordFormats.firstWhere((format) => format.key == key);
}

final defaultCoordinate = LatLng(0.0, 0.0);

abstract class BaseCoordinates {
  BaseCoordinates();

  LatLng toLatLng();
}

String _dmmAndDMSNumberFormat([int precision = 6]) {
  var formatString = '00.';
  if (precision == null) precision = 6;
  if (precision < 0) precision = 0;

  if (precision <= 3) formatString += '0' * precision;
  if (precision > 3) formatString += '000' + '#' * (precision - 3);

  return formatString;
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

class DEC extends BaseCoordinates {
  double latitude;
  double longitude;

  DEC(this.latitude, this.longitude);

  LatLng toLatLng() {
    return decToLatLon(this);
  }

  @override
  String toString([int precision]) {
    if (precision == null) precision = 10;
    if (precision < 1) precision = 1;

    String fixedDigits = '0' * min(precision, 3);
    String variableDigits = precision > 3 ? '#' * (precision - 3) : '';

    return '${NumberFormat('00.' + fixedDigits + variableDigits).format(latitude)}\n${NumberFormat('000.' + fixedDigits + variableDigits).format(longitude)}';
  }
}

class DMMPart {
  int sign;
  int degrees;
  double minutes;

  DMMPart(this.sign, this.degrees, this.minutes);

  Map<String, dynamic> _formatParts(bool isLatitude, [int precision]) {
    var _minutesStr = NumberFormat(_dmmAndDMSNumberFormat(precision)).format(minutes);
    var _degrees = degrees;
    var _sign = _getSignString(sign, isLatitude);

    //Values like 59.999999999' may be rounded to 60.0. So in that case,
    //the degree has to be increased while minutes should be set to 0.0
    if (_minutesStr.startsWith('60')) {
      _minutesStr = '00.000';
      _degrees += 1;
    }

    var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3, '0');

    return {
      'sign': {'value': sign, 'formatted': _sign},
      'degrees': _degreesStr,
      'minutes': _minutesStr
    };
  }

  String _format(bool isLatitude, [int precision]) {
    var formattedParts = _formatParts(isLatitude, precision);

    return formattedParts['sign']['formatted'] +
        ' ' +
        formattedParts['degrees'] +
        '° ' +
        formattedParts['minutes'] +
        '\'';
  }

  @override
  String toString() {
    return 'sign: $sign, degrees: $degrees, minutes: $minutes';
  }
}

class DMMLatitude extends DMMPart {
  DMMLatitude(sign, degrees, minutes) : super(sign, degrees, minutes);

  static DMMLatitude from(DMMPart dmmPart) {
    return DMMLatitude(dmmPart.sign, dmmPart.degrees, dmmPart.minutes);
  }

  Map<String, dynamic> formatParts([int precision]) {
    return super._formatParts(true, precision);
  }

  String format([int precision]) {
    return super._format(true, precision);
  }
}

class DMMLongitude extends DMMPart {
  DMMLongitude(sign, degrees, minutes) : super(sign, degrees, minutes);

  static DMMLongitude from(DMMPart dmmPart) {
    return DMMLongitude(dmmPart.sign, dmmPart.degrees, dmmPart.minutes);
  }

  Map<String, dynamic> formatParts([int precision]) {
    return super._formatParts(false, precision);
  }

  String format([int precision]) {
    return super._format(false, precision);
  }
}

class DMM extends BaseCoordinates {
  DMMLatitude latitude;
  DMMLongitude longitude;

  DMM(this.latitude, this.longitude);

  LatLng toLatLng() {
    return dmmToLatLon(this);
  }

  @override
  String toString([int precision]) {
    return '${latitude.format(precision)}\n${longitude.format(precision)}';
  }
}

class DMSPart {
  int sign;
  int degrees;
  int minutes;
  double seconds;

  DMSPart(this.sign, this.degrees, this.minutes, this.seconds);

  Map<String, dynamic> _formatParts(bool isLatitude, [int precision]) {
    var _sign = _getSignString(sign, isLatitude);
    var _secondsStr = NumberFormat(_dmmAndDMSNumberFormat(precision)).format(seconds);
    var _minutes = minutes;

    //Values like 59.999999999 may be rounded to 60.0. So in that case,
    //the greater unit (minutes or degrees) has to be increased instead
    if (_secondsStr.startsWith('60')) {
      _secondsStr = '00.000';
      _minutes += 1;
    }

    var _degrees = degrees;

    var _minutesStr = _minutes.toString().padLeft(2, '0');
    if (_minutesStr.startsWith('60')) {
      _minutesStr = '00';
      _degrees += 1;
    }

    var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3, '0');

    return {
      'sign': {'value': sign, 'formatted': _sign},
      'degrees': _degreesStr,
      'minutes': _minutesStr,
      'seconds': _secondsStr
    };
  }

  String _format(bool isLatitude, [int precision]) {
    var formattedParts = _formatParts(isLatitude, precision);

    return formattedParts['sign']['formatted'] +
        ' ' +
        formattedParts['degrees'] +
        '° ' +
        formattedParts['minutes'] +
        '\' ' +
        formattedParts['seconds'] +
        '"';
  }

  @override
  String toString() {
    return 'sign: $sign, degrees: $degrees, minutes: $minutes, seconds: $seconds';
  }
}

class DMSLatitude extends DMSPart {
  DMSLatitude(sign, degrees, minutes, seconds) : super(sign, degrees, minutes, seconds);

  static DMSLatitude from(DMSPart dmsPart) {
    return DMSLatitude(dmsPart.sign, dmsPart.degrees, dmsPart.minutes, dmsPart.seconds);
  }

  Map<String, dynamic> formatParts([int precision]) {
    return super._formatParts(true, precision);
  }

  String format([int precision]) {
    return super._format(true, precision);
  }
}

class DMSLongitude extends DMSPart {
  DMSLongitude(sign, degrees, minutes, seconds) : super(sign, degrees, minutes, seconds);

  static DMSLongitude from(DMSPart dmsPart) {
    return DMSLongitude(dmsPart.sign, dmsPart.degrees, dmsPart.minutes, dmsPart.seconds);
  }

  Map<String, dynamic> formatParts([int precision]) {
    return super._formatParts(false, precision);
  }

  String format([int precision]) {
    return super._format(false, precision);
  }
}

class DMS extends BaseCoordinates {
  DMSLatitude latitude;
  DMSLongitude longitude;

  DMS(this.latitude, this.longitude);

  LatLng toLatLng() {
    return dmsToLatLon(this);
  }

  @override
  String toString([int precision]) {
    return '${latitude.format(precision)}\n${longitude.format(precision)}';
  }
}

enum HemisphereLatitude { North, South }
enum HemisphereLongitude { East, West }

// UTM with latitude Zones; Normal UTM is only separated into Hemispheres N and S
class UTMREF extends BaseCoordinates {
  UTMZone zone;
  double easting;
  double northing;

  UTMREF(this.zone, this.easting, this.northing);

  get hemisphere {
    return 'NPQRSTUVWXYZ'.contains(zone.latZone) ? HemisphereLatitude.North : HemisphereLatitude.South;
  }

  LatLng toLatLng({Ellipsoid ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return UTMREFtoLatLon(this, ells);
  }

  @override
  String toString() {
    return '${zone.lonZone} ${zone.latZone} ${doubleFormat.format(easting)} ${doubleFormat.format(northing)}';
  }
}

class UTMZone {
  int lonZone;
  int lonZoneRegular; //the real lonZone differs from mathematical because of two special zones around norway
  String latZone;

  UTMZone(this.lonZoneRegular, this.lonZone, this.latZone);
}

class MGRS extends BaseCoordinates {
  UTMZone utmZone;
  String digraph;
  double easting;
  double northing;

  MGRS(this.utmZone, this.digraph, this.easting, this.northing);

  LatLng toLatLng({Ellipsoid ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return mgrsToLatLon(this, ells);
  }

  @override
  String toString() {
    return '${utmZone.lonZone}${utmZone.latZone} ${digraph} ${doubleFormat.format(easting)} ${doubleFormat.format(northing)}';
  }
}

class SwissGrid extends BaseCoordinates {
  double easting;
  double northing;
  bool isSwissGridPlus;

  SwissGrid(this.easting, this.northing, {this.isSwissGridPlus: false});

  LatLng toLatLng({Ellipsoid ells}) {
    if (ells == null) ells = defaultEllipsoid();
    if (isSwissGridPlus)
      return swissGridPlusToLatLon(this, ells);
    else
      return swissGridToLatLon(this, ells);
  }

  @override
  String toString() {
    return 'Y: ${easting}\nX: ${northing}';
  }
}

class GaussKrueger extends BaseCoordinates {
  int code;
  double easting;
  double northing;

  GaussKrueger(this.code, this.easting, this.northing);

  LatLng toLatLng({Ellipsoid ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return gaussKruegerToLatLon(this, ells);
  }

  @override
  String toString() {
    return 'R: ${easting}\nH: ${northing}';
  }
}

class Mercator extends BaseCoordinates {
  double easting;
  double northing;

  Mercator(this.easting, this.northing);

  LatLng toLatLng({Ellipsoid ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return mercatorToLatLon(this, ells);
  }

  @override
  String toString() {
    return 'Y: $easting\nX: $northing';
  }
}

class NaturalAreaCode extends BaseCoordinates {
  String x; //east
  String y; //north

  NaturalAreaCode(this.x, this.y);

  LatLng toLatLng() {
    return naturalAreaCodeToLatLon(this);
  }

  @override
  String toString() {
    return 'X: $x\nY: $y';
  }
}

class SlippyMap extends BaseCoordinates {
  double x;
  double y;
  double zoom;

  SlippyMap(this.x, this.y, this.zoom);

  LatLng toLatLng() {
    return slippyMapToLatLon(this);
  }

  @override
  String toString() {
    return 'X: $x\nY: $y\nZoom: $zoom';
  }
}

class Waldmeister extends BaseCoordinates {
  String a, b, c;

  Waldmeister(this.a, this.b, this.c);

  LatLng toLatLng() {
    return waldmeisterToLatLon(this);
  }

  @override
  String toString() {
    return '$a\n$b\n$c';
  }
}

class XYZ extends BaseCoordinates {
  double x, y, z;

  XYZ(this.x, this.y, this.z);

  LatLng toLatLng({Ellipsoid ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return xyzToLatLon(this, ells);
  }

  @override
  String toString() {
    var numberFormat = NumberFormat('0.######');
    return 'X: ${numberFormat.format(x)}\nY: ${numberFormat.format(y)}\nZ: ${numberFormat.format(z)}';
  }
}

class Maidenhead extends BaseCoordinates {
  String text;

  Maidenhead(this.text);

  LatLng toLatLng() {
    return maidenheadToLatLon(this);
  }

  @override
  String toString() {
    return text;
  }
}

class Geohash extends BaseCoordinates {
  String text;

  Geohash(this.text);

  LatLng toLatLng() {
    return geohashToLatLon(this);
  }

  @override
  String toString() {
    return text;
  }
}

class GeoHex extends BaseCoordinates {
  String text;

  GeoHex(this.text);

  LatLng toLatLng() {
    return geoHexToLatLon(this);
  }

  @override
  String toString() {
    return text;
  }
}

class Geo3x3 extends BaseCoordinates {
  String text;

  Geo3x3(this.text);

  LatLng toLatLng() {
    return geo3x3ToLatLon(this);
  }

  @override
  String toString() {
    return text.toUpperCase();
  }
}

class OpenLocationCode extends BaseCoordinates {
  String text;

  OpenLocationCode(this.text);

  LatLng toLatLng() {
    return openLocationCodeToLatLon(this);
  }

  @override
  String toString() {
    return text;
  }
}

class Quadtree extends BaseCoordinates {
  List<int> coords;

  Quadtree(this.coords);

  LatLng toLatLng() {
    return quadtreeToLatLon(this);
  }

  @override
  String toString() {
    return coords.join();
  }
}
