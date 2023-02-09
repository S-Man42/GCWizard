import 'dart:math';

import 'package:gc_wizard/tools/coords/format_converter/logic/dec.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/dmm.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/dms.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/dutchgrid.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/gauss_krueger.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/geo3x3.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/geohash.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/geohex.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/lambert.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/maidenhead.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/makaney.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/mercator.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/mgrs.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/natural_area_code.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/open_location_code.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/quadtree.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/reverse_wherigo_day1976.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/reverse_wherigo_waldmeister.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/slippy_map.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/swissgrid.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/utm.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/xyz.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:collection/collection.dart';

abstract class BaseCoordFormatKey{}

enum CoordFormatKey {DEC, DMM, DMS, UTM, MGRS, XYZ, SWISS_GRID, SWISS_GRID_PLUS, DUTCH_GRID,
  GAUSS_KRUEGER, LAMBERT, MAIDENHEAD, MERCATOR, NATURAL_AREA_CODE, SLIPPY_MAP, GEOHASH, GEO3X3, 
  GEOHEX, OPEN_LOCATION_CODE, MAKANEY, QUADTREE, REVERSE_WIG_WALDMEISTER, REVERSE_WIG_DAY1976, 
  //GaussKrueger Subtypes
  GAUSS_KRUEGER_GK1, GAUSS_KRUEGER_GK2, GAUSS_KRUEGER_GK3, GAUSS_KRUEGER_GK4, GAUSS_KRUEGER_GK5,
  //Lambert Subtypes
  LAMBERT93, LAMBERT2008, ETRS89LCC, LAMBERT72, LAMBERT93_CC42, LAMBERT93_CC43,
  LAMBERT93_CC44, LAMBERT93_CC45, LAMBERT93_CC46, LAMBERT93_CC47, LAMBERT93_CC48, LAMBERT93_CC49, LAMBERT93_CC50,
  //SlippyMap Subtypes
  SLIPPYMAP_0, SLIPPYMAP_1, SLIPPYMAP_2, SLIPPYMAP_3, SLIPPYMAP_4, SLIPPYMAP_5, SLIPPYMAP_6, SLIPPYMAP_7, SLIPPYMAP_8
  , SLIPPYMAP_9, SLIPPYMAP_10, SLIPPYMAP_11, SLIPPYMAP_12, SLIPPYMAP_13, SLIPPYMAP_14, SLIPPYMAP_15, SLIPPYMAP_16, SLIPPYMAP_17
  , SLIPPYMAP_18, SLIPPYMAP_19, SLIPPYMAP_20, SLIPPYMAP_21, SLIPPYMAP_22, SLIPPYMAP_23, SLIPPYMAP_24, SLIPPYMAP_25, SLIPPYMAP_26
  , SLIPPYMAP_27, SLIPPYMAP_28, SLIPPYMAP_29, SLIPPYMAP_30
}

const keyCoordsALL = 'coords_all';

class CoordinateFormat {
  final CoordFormatKey key;
  String persistenceKey;
  String name;
  List<CoordinateFormat>? subtypes;
  String example;

  CoordinateFormat(this.key, this.persistenceKey, this.name, this.example, {this.subtypes});
}

List<CoordinateFormat> allCoordFormats = [
  CoordinateFormat(CoordFormatKey.DEC, 'coords_dec', 'DEC: DD.DDD°', '45.29100, -122.41333'),
  CoordinateFormat(CoordFormatKey.DMM, 'coords_dmm', 'DMM: DD° MM.MMM\'', 'N 45° 17.460\' W 122° 24.800\''),
  CoordinateFormat(CoordFormatKey.DMS, 'coords_dms', 'DMS: DD° MM\' SS.SSS"', 'N 45° 17\' 27.60" W 122° 24\' 48.00"'),
  CoordinateFormat(CoordFormatKey.UTM, 'coords_utm', 'UTM', '10 N 546003.6 5015445.0'),
  CoordinateFormat(CoordFormatKey.MGRS, 'coords_mgrs', 'MGRS', '10T ER 46003.6 15445.0'),
  CoordinateFormat(CoordFormatKey.XYZ, 'coords_xyz', 'XYZ (ECEF)', 'X: -2409244, Y: -3794410, Z: 4510158'),
  CoordinateFormat(CoordFormatKey.SWISS_GRID, 'coords_swissgrid', 'SwissGrid (CH1903/LV03)', 'Y: 720660.2, X: 167765.3'),
  CoordinateFormat(CoordFormatKey.SWISS_GRID_PLUS, 'coords_swissgridplus', 'SwissGrid (CH1903+/LV95)', 'Y: 2720660.2, X: 1167765.3'),
  CoordinateFormat(CoordFormatKey.GAUSS_KRUEGER, 'coords_gausskrueger', 'coords_formatconverter_gausskrueger', 'R: 8837763.4, H: 5978799.1',
      subtypes: [
        CoordinateFormat(
            CoordFormatKey.GAUSS_KRUEGER_GK1, 'coords_gausskrueger_gk1', 'coords_formatconverter_gausskrueger_gk1', 'R: 8837763.4, H: 5978799.1'),
        CoordinateFormat(
            CoordFormatKey.GAUSS_KRUEGER_GK2, 'coords_gausskrueger_gk2', 'coords_formatconverter_gausskrueger_gk2', 'R: 8837739.4, H: 5978774.5'),
        CoordinateFormat(
            CoordFormatKey.GAUSS_KRUEGER_GK3, 'coords_gausskrueger_gk3', 'coords_formatconverter_gausskrueger_gk3', 'R: 8837734.7, H: 5978798.2'),
        CoordinateFormat(
            CoordFormatKey.GAUSS_KRUEGER_GK4, 'coords_gausskrueger_gk4', 'coords_formatconverter_gausskrueger_gk4', 'R: 8837790.8, H: 5978787.4'),
        CoordinateFormat(
            CoordFormatKey.GAUSS_KRUEGER_GK5, 'coords_gausskrueger_gk5', 'coords_formatconverter_gausskrueger_gk5', 'R: 8837696.4, H: 5978779.5'),
      ]),
  CoordinateFormat(CoordFormatKey.LAMBERT, 'coords_lambert', 'coords_formatconverter_lambert', 'X: 8837763.4, Y: 5978799.1', subtypes: [
    CoordinateFormat(CoordFormatKey.LAMBERT93, 'coords_lambert_93', 'coords_formatconverter_lambert_93', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT2008, 'coords_lambert_2008', 'coords_formatconverter_lambert_2008', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.ETRS89LCC, 'coords_lambert_etrs89lcc', 'coords_formatconverter_lambert_etrs89lcc', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT72, 'coords_lambert_72', 'coords_formatconverter_lambert_72', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC42, 'coords_lambert_93_cc42', 'coords_formatconverter_lambert_l93cc42', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC43, 'coords_lambert_93_cc43', 'coords_formatconverter_lambert_l93cc43', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC44, 'coords_lambert_93_cc44', 'coords_formatconverter_lambert_l93cc44', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC45, 'coords_lambert_93_cc45', 'coords_formatconverter_lambert_l93cc45', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC46, 'coords_lambert_93_cc46', 'coords_formatconverter_lambert_l93cc46', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC47, 'coords_lambert_93_cc47', 'coords_formatconverter_lambert_l93cc47', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC48, 'coords_lambert_93_cc48', 'coords_formatconverter_lambert_l93cc48', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC49, 'coords_lambert_93_cc49', 'coords_formatconverter_lambert_l93cc49', 'X: 8837763.4, Y: 5978799.1'),
    CoordinateFormat(CoordFormatKey.LAMBERT93_CC50, 'coords_lambert_93_cc50', 'coords_formatconverter_lambert_l93cc50', 'X: 8837763.4, Y: 5978799.1'),
  ]),
  CoordinateFormat(CoordFormatKey.DUTCH_GRID, 'coords_dutchgrid', 'RD (Rijksdriehoeks, DutchGrid)', 'X: 221216.7, Y: 550826.2'),
  CoordinateFormat(CoordFormatKey.MAIDENHEAD, 'coords_maidenhead', 'Maidenhead Locator (QTH)', 'CN85TG09JU'),
  CoordinateFormat(CoordFormatKey.MERCATOR, 'coords_mercator', 'Mercator', 'Y: 5667450.4, X: -13626989.9'),
  CoordinateFormat(CoordFormatKey.NATURAL_AREA_CODE, 'coords_naturalareacode', 'Natural Area Code (NAC)', 'X: 4RZ000, Y: QJFMGZ'),
  CoordinateFormat(CoordFormatKey.OPEN_LOCATION_CODE, 'coords_openlocationcode', 'OpenLocationCode (OLC, PlusCode)', '84QV7HRP+CM3'),
  CoordinateFormat(CoordFormatKey.SLIPPY_MAP, 'coords_slippymap', 'Slippy Map Tiles', 'Z: 15, X: 5241, Y: 11749', subtypes: [
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_0, '', '0', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_1, '', '1', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_2, '', '2', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_3, '', '3', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_4, '', '4', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_5, '', '5', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_6, '', '6', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_7, '', '7', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_8, '', '8', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_9, '', '9', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_10, '', '10', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_11, '', '11', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_12, '', '12', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_13, '', '13', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_14, '', '14', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_15, '', '15', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_16, '', '16', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_17, '', '17', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_18, '', '18', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_19, '', '19', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_20, '', '20', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_21, '', '21', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_22, '', '22', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_23, '', '23', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_24, '', '24', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_25, '', '25', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_26, '', '26', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_27, '', '27', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_28, '', '28', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_29, '', '29', ''),
    CoordinateFormat(CoordFormatKey.SLIPPYMAP_30, '', '30', ''),
  ]),
  CoordinateFormat(CoordFormatKey.REVERSE_WIG_WALDMEISTER, 'coords_reversewhereigo_waldmeister' /* typo known. DO NOT change!*/, 'Reverse Wherigo (Waldmeister)', '042325, 436113, 935102'),
  CoordinateFormat(CoordFormatKey.REVERSE_WIG_DAY1976, 'coords_reversewhereigo_day1976', 'Reverse Wherigo (Day1976)', '3f8f1, z4ee4'),
  CoordinateFormat(CoordFormatKey.GEOHASH, 'coords_geohash', 'Geohash', 'c20cwkvr4'),
  CoordinateFormat(CoordFormatKey.QUADTREE, 'coords_quadtree', 'Quadtree', '021230223311203323'),
  CoordinateFormat(CoordFormatKey.MAKANEY, 'coords_makaney', 'Makaney (MKC)', 'M97F-BBOOI'),
  CoordinateFormat(CoordFormatKey.GEOHEX, 'coords_geohex', 'GeoHex', 'RU568425483853568'),
  CoordinateFormat(CoordFormatKey.GEO3X3, 'coords_geo3x3', 'Geo3x3', 'W7392967941169'),
];

CoordinateFormat getCoordinateFormatByKey(CoordFormatKey key) {
  return allCoordFormats.firstWhere((format) => format.key == key);
}

CoordinateFormat? getCoordinateFormatByPersistenceKey(String key) {
  return allCoordFormats.firstWhereOrNull((format) => format.persistenceKey == key);
}

CoordinateFormat? getCoordinateFormatSubtypeByPersistenceKey(String key) {
  var subtypeFormats = allCoordFormats.where((format) => format.subtypes != null && format.subtypes!.isNotEmpty).toList();

  return subtypeFormats
      .fold(<CoordinateFormat>[], (List<CoordinateFormat> value, CoordinateFormat element) {
          value.addAll(element.subtypes!);
          return value;
      })
      .firstWhereOrNull((format) => format.persistenceKey == key);
}

bool isSubtypeOfCoordFormat(CoordFormatKey baseFormat, CoordFormatKey typeToCheck) {
  var coordFormat = getCoordinateFormatByKey(baseFormat);
  if (coordFormat == null || coordFormat.subtypes == null)
    return false;

  return coordFormat.subtypes!.map((CoordinateFormat _format) => _format.key).contains(typeToCheck);
}

final defaultCoordinate = LatLng(0.0, 0.0);

abstract class BaseCoordinates {
  CoordFormatKey get key;

  LatLng toLatLng();

  bool isDefault() {
    var latlon = toLatLng();
    return latlon.latitude == 0.0 && latlon.longitude == 0.0;
  }
}

String _dmmAndDMSNumberFormat([int precision = 6]) {
  var formatString = '00.';
  if (precision < 0) precision = 0;

  if (precision <= 3) formatString += '0' * precision;
  if (precision > 3) formatString += '000' + '#' * (precision - 3);

  return formatString;
}

String _getCoordinateSignString(int sign, bool isLatitude) {
  var _sign = '';

  if (isLatitude) {
    _sign = (sign >= 0) ? 'N' : 'S';
  } else {
    _sign = (sign >= 0) ? 'E' : 'W';
  }

  return _sign;
}

int getCoordinateSignFromString(String text, bool isLatitude) {
  int _sign = 0;

  if (isLatitude) {
    _sign = (text == 'N') ? 1 : -1;
  } else {
    _sign = (text == 'E') ? 1 : -1;
  }

  return _sign;
}

class DEC extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.DEC;
  double latitude;
  double longitude;

  DEC(this.latitude, this.longitude);

  LatLng toLatLng() {
    return decToLatLon(this);
  }

  static DEC fromLatLon(LatLng coord) {
    return latLonToDEC(coord);
  }

  static DEC parse(String input, {wholeString = false}) {
    return parseDEC(input, wholeString: wholeString);
  }

  @override
  String toString([int precision = 10]) {
    if (precision < 1) precision = 1;

    String fixedDigits = '0' * min(precision, 3);
    String variableDigits = precision > 3 ? '#' * (precision - 3) : '';

    return '${NumberFormat('00.' + fixedDigits + variableDigits).format(latitude)}\n${NumberFormat('000.' + fixedDigits + variableDigits).format(longitude)}';
  }
}

class DMMPart {
  CoordFormatKey get key => CoordFormatKey.DMM;
  int sign;
  int degrees;
  double minutes;

  DMMPart(this.sign, this.degrees, this.minutes);

  Map<String, Object> _formatParts(bool isLatitude, [int precision = 10]) {
    var _minutesStr = NumberFormat(_dmmAndDMSNumberFormat(precision)).format(minutes);
    var _degrees = degrees;
    var _sign = _getCoordinateSignString(sign, isLatitude);

    //Values like 59.999999999' may be rounded to 60.0. So in that case,
    //the degree has to be increased while minutes should be set to 0.0
    if (_minutesStr.startsWith('60')) {
      _minutesStr = '00.000';
      _degrees += 1;
    }

    String _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3, '0');

    return {
      'sign': {'value': sign, 'formatted': _sign},
      'degrees': _degreesStr,
      'minutes': _minutesStr
    };
  }

  String _format(bool isLatitude, [int precision = 10]) {
    var formattedParts = _formatParts(isLatitude, precision);

    return ((formattedParts['sign'] as Map<String, Object>)['formatted'] as String) +
        ' ' +
        (formattedParts['degrees'] as String) +
        '° ' +
        (formattedParts['minutes'] as String) +
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

  Map<String, Object> formatParts([int precision = 10]) {
    return super._formatParts(true, precision);
  }

  String format([int precision = 10]) {
    return super._format(true, precision);
  }
}

class DMMLongitude extends DMMPart {
  DMMLongitude(sign, degrees, minutes) : super(sign, degrees, minutes);

  static DMMLongitude from(DMMPart dmmPart) {
    return DMMLongitude(dmmPart.sign, dmmPart.degrees, dmmPart.minutes);
  }

  Map<String, dynamic> formatParts([int precision = 10]) {
    return super._formatParts(false, precision);
  }

  String format([int precision = 10]) {
    return super._format(false, precision);
  }
}

class DMM extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.DMM;
  DMMLatitude latitude;
  DMMLongitude longitude;

  DMM(this.latitude, this.longitude);

  LatLng toLatLng() {
    return dmmToLatLon(this);
  }

  static DMM fromLatLon(LatLng coord) {
    return latLonToDMM(coord);
  }

  static DMM parse(String text, {leftPadMilliMinutes: false, wholeString: false}) {
    return parseDMM(text, leftPadMilliMinutes: leftPadMilliMinutes, wholeString: wholeString);
  }

  @override
  String toString([int precision = 10]) {
    return '${latitude.format(precision)}\n${longitude.format(precision)}';
  }
}

class DMSPart {
  int sign;
  int degrees;
  int minutes;
  double seconds;

  DMSPart(this.sign, this.degrees, this.minutes, this.seconds);

  Map<String, dynamic> _formatParts(bool isLatitude, [int precision = 10]) {
    var _sign = _getCoordinateSignString(sign, isLatitude);
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

  String _format(bool isLatitude, [int precision = 10]) {
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

  Map<String, dynamic> formatParts([int precision = 10]) {
    return super._formatParts(true, precision);
  }

  String format([int precision = 10]) {
    return super._format(true, precision);
  }
}

class DMSLongitude extends DMSPart {
  DMSLongitude(sign, degrees, minutes, seconds) : super(sign, degrees, minutes, seconds);

  static DMSLongitude from(DMSPart dmsPart) {
    return DMSLongitude(dmsPart.sign, dmsPart.degrees, dmsPart.minutes, dmsPart.seconds);
  }

  Map<String, dynamic> formatParts([int precision = 10]) {
    return super._formatParts(false, precision);
  }

  String format([int precision = 10]) {
    return super._format(false, precision);
  }
}

class DMS extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.DMS;
  DMSLatitude latitude;
  DMSLongitude longitude;

  DMS(this.latitude, this.longitude);

  LatLng toLatLng() {
    return dmsToLatLon(this);
  }

  static DMS fromLatLon(LatLng coord) {
    return latLonToDMS(coord);
  }

  static DMS parse(String input, {wholeString = false}) {
    return parseDMS(input, wholeString: wholeString);
  }

  @override
  String toString([int precision = 10]) {
    return '${latitude.format(precision)}\n${longitude.format(precision)}';
  }
}

enum HemisphereLatitude { North, South }

enum HemisphereLongitude { East, West }

// UTM with latitude Zones; Normal UTM is only separated into Hemispheres N and S
class UTMREF extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.UTM;
  UTMZone zone;
  double easting;
  double northing;

  UTMREF(this.zone, this.easting, this.northing);

  get hemisphere {
    return 'NPQRSTUVWXYZ'.contains(zone.latZone) ? HemisphereLatitude.North : HemisphereLatitude.South;
  }

  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return UTMREFtoLatLon(this, ells);
  }

  static UTMREF fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToUTM(coord, ells);
  }

  static UTMREF parse(String input) {
    return parseUTM(input);
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
  CoordFormatKey get key => CoordFormatKey.MGRS;
  UTMZone utmZone;
  String digraph;
  double easting;
  double northing;

  MGRS(this.utmZone, this.digraph, this.easting, this.northing);

  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return mgrsToLatLon(this, ells);
  }

  static MGRS fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToMGRS(coord, ells);
  }

  static MGRS parse(String text) {
    return parseMGRS(text);
  }

  @override
  String toString() {
    return '${utmZone.lonZone}${utmZone.latZone} $digraph ${doubleFormat.format(easting)} ${doubleFormat.format(northing)}';
  }
}

class SwissGrid extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.SWISS_GRID;
  double easting;
  double northing;

  SwissGrid(this.easting, this.northing);

  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return swissGridToLatLon(this, ells);
  }

  static SwissGrid fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToSwissGrid(coord, ells);
  }

  static SwissGrid parse(String input) {
    return parseSwissGrid(input);
  }

  @override
  String toString() {
    return 'Y: $easting\nX: $northing';
  }
}

class SwissGridPlus extends SwissGrid {
  CoordFormatKey get key => CoordFormatKey.SWISS_GRID_PLUS;

  SwissGridPlus(easting, northing) : super(easting, northing);

  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return swissGridPlusToLatLon(this, ells);
  }

  @override
  static SwissGridPlus fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToSwissGridPlus(coord, ells);
  }

  @override
  static SwissGridPlus parse(String input) {
    return parseSwissGridPlus(input);
  }
}

class DutchGrid extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.DUTCH_GRID;
  double x;
  double y;

  DutchGrid(this.x, this.y);

  LatLng toLatLng() {
    return dutchGridToLatLon(this);
  }

  static DutchGrid fromLatLon(LatLng coord) {
    return latLonToDutchGrid(coord);
  }

  static DutchGrid parse(String input) {
    return parseDutchGrid(input);
  }

  @override
  String toString() {
    return 'X: $x\nY: $y';
  }
}

class GaussKrueger extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.GAUSS_KRUEGER;
  CoordFormatKey subtype;
  double easting;
  double northing;

  GaussKrueger(this.subtype, this.easting, this.northing) {
    if (!isSubtypeOfCoordFormat(CoordFormatKey.GAUSS_KRUEGER, this.subtype))
      throw Exception('No valid GaussKrueger subtype given');
  }

  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return gaussKruegerToLatLon(this, ells);
  }

  static GaussKrueger fromLatLon(LatLng coord, CoordFormatKey subtype, Ellipsoid ells) {
    return latLonToGaussKrueger(coord, subtype, ells);
  }

  static GaussKrueger parse(String input, {CoordFormatKey gaussKruegerCode: defaultGaussKruegerType}) {
    return parseGaussKrueger(input, gaussKruegerCode: gaussKruegerCode);
  }

  @override
  String toString() {
    return 'R: $easting\nH: $northing';
  }
}

class Lambert extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.LAMBERT;
  CoordFormatKey subtype;
  double easting;
  double northing;

  Lambert(this.subtype, this.easting, this.northing) {
    if (!isSubtypeOfCoordFormat(CoordFormatKey.LAMBERT, this.subtype))
      throw Exception('No valid Lambert subtype given.');
  }

  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return lambertToLatLon(this, ells);
  }

  static Lambert fromLatLon(LatLng coord, CoordFormatKey subtype, Ellipsoid ells) {
    return latLonToLambert(coord, subtype, ells);
  }

  static Lambert parse(String input, {type: defaultLambertType}) {
    return parseLambert(input, type: type);
  }

  @override
  String toString() {
    return 'X: $easting\nY: $northing';
  }
}

class Mercator extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.MERCATOR;
  double easting;
  double northing;

  Mercator(this.easting, this.northing);

  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return mercatorToLatLon(this, ells);
  }

  static Mercator fromLatLon(LatLng coord, Ellipsoid ells) {
    return latLonToMercator(coord, ells);
  }

  static Mercator parse(String input) {
    return parseMercator(input);
  }

  @override
  String toString() {
    return 'Y: $easting\nX: $northing';
  }
}

class NaturalAreaCode extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.NATURAL_AREA_CODE;
  String x; //east
  String y; //north

  NaturalAreaCode(this.x, this.y);

  LatLng toLatLng() {
    return naturalAreaCodeToLatLon(this);
  }

  static NaturalAreaCode fromLatLon(LatLng coord, {int precision = 8}) {
    return latLonToNaturalAreaCode(coord, precision: precision);
  }

  static NaturalAreaCode parse(String input) {
    return parseNaturalAreaCode(input);
  }

  @override
  String toString() {
    return 'X: $x\nY: $y';
  }
}

class SlippyMap extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.SLIPPY_MAP;
  double x;
  double y;
  double zoom;

  SlippyMap(this.x, this.y, this.zoom);

  LatLng toLatLng() {
    return slippyMapToLatLon(this);
  }

  static SlippyMap fromLatLon(LatLng coord, double zoom) {
    return latLonToSlippyMap(coord, zoom);
  }

  static SlippyMap parse(String input, {zoom: defaultSlippyZoom}) {
    return parseSlippyMap(input, zoom: zoom);
  }

  @override
  String toString() {
    return 'X: $x\nY: $y\nZoom: $zoom';
  }
}

class ReverseWherigoWaldmeister extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.REVERSE_WIG_WALDMEISTER;
  String a, b, c;

  ReverseWherigoWaldmeister(this.a, this.b, this.c);

  LatLng toLatLng() {
    return reverseWIGWaldmeisterToLatLon(this);
  }

  static ReverseWherigoWaldmeister fromLatLon(LatLng coord) {
    return latLonToReverseWIGWaldmeister(coord);
  }

  static ReverseWherigoWaldmeister parse(String input) {
    return parseReverseWherigoWaldmeister(input);
  }

  @override
  String toString() {
    return '$a\n$b\n$c';
  }
}

class ReverseWherigoDay1976 extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.REVERSE_WIG_DAY1976;
  String s, t;

  ReverseWherigoDay1976(this.s, this.t);

  LatLng toLatLng() {
    return reverseWIGDay1976ToLatLon(this);
  }

  static ReverseWherigoDay1976 fromLatLon(LatLng coord) {
    return latLonToReverseWIGDay1976(coord);
  }

  static ReverseWherigoDay1976 parse(String input) {
    return parseReverseWherigoDay1976(input);
  }

  @override
  String toString() {
    return '$s\n$t';
  }
}

class XYZ extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.XYZ;
  double x, y, z;

  XYZ(this.x, this.y, this.z);

  LatLng toLatLng({Ellipsoid? ells}) {
    if (ells == null) ells = defaultEllipsoid();
    return xyzToLatLon(this, ells);
  }

  static XYZ fromLatLon(LatLng coord, Ellipsoid ells, {double h: 0.0}) {
    return latLonToXYZ(coord, ells, h: h);
  }

  static XYZ parse(String input) {
    return parseXYZ(input);
  }

  @override
  String toString() {
    var numberFormat = NumberFormat('0.######');
    return 'X: ${numberFormat.format(x)}\nY: ${numberFormat.format(y)}\nZ: ${numberFormat.format(z)}';
  }
}

class Maidenhead extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.MAIDENHEAD;
  String text;

  Maidenhead(this.text);

  LatLng toLatLng() {
    return maidenheadToLatLon(this);
  }

  static Maidenhead fromLatLon(LatLng coord) {
    return latLonToMaidenhead(coord);
  }

  static Maidenhead parse(String input) {
    return parseMaidenhead(input);
  }

  @override
  String toString() {
    return text;
  }
}

class Makaney extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.MAKANEY;
  String text;

  Makaney(this.text);

  LatLng toLatLng() {
    return makaneyToLatLon(this);
  }

  static Makaney fromLatLon(LatLng coord) {
    return latLonToMakaney(coord);
  }

  static Makaney parse(String input) {
    return parseMakaney(input);
  }

  @override
  String toString() {
    return text;
  }
}

class Geohash extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.GEOHASH;
  String text;

  Geohash(this.text);

  LatLng toLatLng() {
    return geohashToLatLon(this);
  }

  static Geohash fromLatLon(LatLng coord, int geohashLength) {
    return latLonToGeohash(coord, geohashLength);
  }

  static Geohash parse(String input) {
    return parseGeohash(input);
  }

  @override
  String toString() {
    return text;
  }
}

class GeoHex extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.GEOHEX;
  String text;

  GeoHex(this.text);

  LatLng toLatLng() {
    return geoHexToLatLon(this);
  }

  static GeoHex fromLatLon(LatLng coord, int precision) {
    return latLonToGeoHex(coord, precision);
  }

  static GeoHex parse(String input) {
    return parseGeoHex(input);
  }

  @override
  String toString() {
    return text;
  }
}

class Geo3x3 extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.GEO3X3;
  String text;

  Geo3x3(this.text);

  LatLng toLatLng() {
    return geo3x3ToLatLon(this);
  }

  static Geo3x3 fromLatLon(LatLng coord, int level) {
    return latLonToGeo3x3(coord, level);
  }

  static Geo3x3 parse(String input) {
    return parseGeo3x3(input);
  }

  @override
  String toString() {
    return text.toUpperCase();
  }
}

class OpenLocationCode extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.OPEN_LOCATION_CODE;
  String text;

  OpenLocationCode(this.text);

  LatLng toLatLng() {
    return openLocationCodeToLatLon(this);
  }

  static OpenLocationCode fromLatLon(LatLng coord, {int codeLength = 14}) {
    return latLonToOpenLocationCode(coord, codeLength: codeLength);
  }

  static OpenLocationCode parse(String input) {
    return parseOpenLocationCode(input);
  }

  @override
  String toString() {
    return text;
  }
}

class Quadtree extends BaseCoordinates {
  CoordFormatKey get key => CoordFormatKey.QUADTREE;
  List<int> coords;

  Quadtree(this.coords);

  LatLng toLatLng() {
    return quadtreeToLatLon(this);
  }

  static Quadtree parse(String input) {
    return parseQuadtree(input);
  }

  static Quadtree fromLatLon(LatLng coord, {int precision = 40}) {
    return latLonToQuadtree(coord, precision: precision);
  }

  @override
  String toString() {
    return coords.join();
  }
}
