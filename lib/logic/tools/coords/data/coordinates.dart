import 'package:gc_wizard/logic/tools/coords/converter/latlon.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

const keyCoordsDEC = 'coords_dec';
const keyCoordsDEG = 'coords_deg';
const keyCoordsDMS = 'coords_dms';
const keyCoordsUTM = 'coords_utm';
const keyCoordsMGRS = 'coords_mgrs';
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
const keyCoordsSlippyMap = 'coords_slippymap';
const keyCoordsGeohash = 'coords_geohash';
const keyCoordsOpenLocationCode = 'coords_openlocationcode';
const keyCoordsQuadtree = 'coords_quadtree';
const keyCoordsReverseWhereIGoWaldmeister = 'coords_reversewhereigo_waldmeister';

class CoordinateFormat {
  final key;
  String name;
  List<CoordinateFormat> subtypes;

  CoordinateFormat(this.key, this.name, {this.subtypes});
}

List<CoordinateFormat> allCoordFormats = [
  CoordinateFormat(keyCoordsDEC, 'DEC: DD.DDD°'),
  CoordinateFormat(keyCoordsDEG, 'DEG: DD° MM.MMM\''),
  CoordinateFormat(keyCoordsDMS, 'DMS: DD° MM\' SS.SSS"'),
  CoordinateFormat(keyCoordsUTM, 'UTM'),
  CoordinateFormat(keyCoordsMGRS, 'MGRS'),
  CoordinateFormat(keyCoordsSwissGrid, 'SwissGrid (CH1903)'),
  CoordinateFormat(keyCoordsSwissGridPlus, 'SwissGrid (CH1903+)'),
  CoordinateFormat(keyCoordsGaussKrueger, 'coords_formatconverter_gausskrueger', subtypes: [
    CoordinateFormat(keyCoordsGaussKruegerGK1, 'coords_formatconverter_gausskrueger_gk1'),
    CoordinateFormat(keyCoordsGaussKruegerGK2, 'coords_formatconverter_gausskrueger_gk2'),
    CoordinateFormat(keyCoordsGaussKruegerGK3, 'coords_formatconverter_gausskrueger_gk3'),
    CoordinateFormat(keyCoordsGaussKruegerGK4, 'coords_formatconverter_gausskrueger_gk4'),
    CoordinateFormat(keyCoordsGaussKruegerGK5, 'coords_formatconverter_gausskrueger_gk5'),
  ]),
  CoordinateFormat(keyCoordsMaidenhead, 'Maidenhead Locator (QTH)'),
  CoordinateFormat(keyCoordsMercator, 'Mercator'),
  CoordinateFormat(keyCoordsSlippyMap, 'Slippy Map Tiles'),
  CoordinateFormat(keyCoordsGeohash, 'Geohash'),
  CoordinateFormat(keyCoordsOpenLocationCode, 'OpenLocationCode (OLC, PlusCode)'),
  CoordinateFormat(keyCoordsQuadtree, 'Quadtree'),
  CoordinateFormat(keyCoordsReverseWhereIGoWaldmeister, 'Reverse WhereIGo (Waldmeister)'),
];

CoordinateFormat getCoordinateFormatByKey(String key) {
  return allCoordFormats.firstWhere((format) => format.key == key);
}

final defaultCoordinate = LatLng(0.0, 0.0);

String _degAndDMSNumberFormat([int precision = 6]) {
  var formatString = '00.';
  if (precision == null)
    precision = 6;
  if (precision < 0)
    precision = 0;

  if (precision <= 3)
    formatString += '0' * precision;
  if (precision > 3)
    formatString += '000' + '#' * (precision - 3);

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

class DEC {
  double latitude;
  double longitude;
  
  DEC(this.latitude, this.longitude);

  static DEC from(LatLng coord) {
    return DEC(coord.latitude, coord.longitude);
  }

  LatLng toLatLng() {
    var normalized = this.normalize();
    return LatLng(normalized.latitude, normalized.longitude);
  }

  Map<String, String> format([int precision]) {
    return {
      'latitude': NumberFormat('00.000#######').format(latitude),
      'longitude': NumberFormat('000.000#######').format(longitude)
    };
  }

  DEC normalize() {
    return normalizeDEC(this);
  }

  @override
  String toString() {
    return 'latitude: $latitude, longitude: $longitude';
  }
}

class DEGPart {
  int sign;
  int degrees;
  double minutes;

  DEGPart(this.sign, this.degrees, this.minutes);

  Map<String, dynamic> _formatParts(bool isLatitude, [int precision]) {
    var _minutesStr = NumberFormat(_degAndDMSNumberFormat(precision)).format(minutes);
    var _degrees = degrees;
    var _sign = _getSignString(sign, isLatitude);

    //Values like 59.999999999' may be rounded to 60.0. So in that case,
    //the degree has to be increased while minutes should be set to 0.0
    if (_minutesStr.startsWith('60')) {
      _minutesStr = '00.000';
      _degrees += 1;
    }

    var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3,'0');

    return {'sign': {'value': sign, 'formatted': _sign}, 'degrees': _degreesStr, 'minutes': _minutesStr};
  }

  String _format(bool isLatitude, [int precision]) {
    var formattedParts = _formatParts(isLatitude, precision);

    return
      formattedParts['sign']['formatted']
        + ' ' + formattedParts['degrees'] + '° '
        + formattedParts['minutes'] + '\'';
  }

  @override
  String toString() {
    return 'sign: $sign, degrees: $degrees, minutes: $minutes';
  }
}

class DEGLatitude extends DEGPart {
  DEGLatitude(sign, degrees, minutes) : super(sign, degrees, minutes);

  static DEGLatitude from(DEGPart degPart) {
    return DEGLatitude(degPart.sign, degPart.degrees, degPart.minutes);
  }

  Map<String, dynamic> formatParts([int precision]) {
    return super._formatParts(true, precision);
  }

  String format([int precision]) {
    return super._format(true, precision);
  }
}

class DEGLongitude extends DEGPart {
  DEGLongitude(sign, degrees, minutes) : super(sign, degrees, minutes);

  static DEGLongitude from(DEGPart degPart) {
    return DEGLongitude(degPart.sign, degPart.degrees, degPart.minutes);
  }

  Map<String, dynamic> formatParts([int precision]) {
    return super._formatParts(false, precision);
  }

  String format([int precision]) {
    return super._format(false, precision);
  }
}

class DEG {
  DEGLatitude latitude;
  DEGLongitude longitude;

  DEG(this.latitude, this.longitude);

  static DEG from(LatLng coord) {
    return DECToDEG(DEC.from(coord));
  }

  LatLng toLatLng() {
    return DEGToDEC(this).toLatLng();
  }

  Map<String, String> format([int precision]) {
    return {'latitude': latitude.format(precision), 'longitude': longitude.format(precision)};
  }

  DEG normalize() {
    return DECToDEG(DEGToDEC(this));
  }

  @override
  String toString() {
    return 'latitude: $latitude, longitude: $longitude';
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
    var _secondsStr = NumberFormat(_degAndDMSNumberFormat(precision)).format(seconds);
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

    var _degreesStr = _degrees.toString().padLeft(isLatitude ? 2 : 3,'0');

    return {'sign': {'value': sign, 'formatted': _sign}, 'degrees': _degreesStr, 'minutes': _minutesStr, 'seconds': _secondsStr};
  }

  String _format(bool isLatitude, [int precision]) {
    var formattedParts = _formatParts(isLatitude, precision);

    return
      formattedParts['sign']['formatted']
        + ' ' + formattedParts['degrees'] + '° '
        + formattedParts['minutes'] + '\' '
        + formattedParts['seconds'] + '"';
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

class DMS {
  DMSLatitude latitude;
  DMSLongitude longitude;

  DMS(this.latitude, this.longitude);

  static DMS from(LatLng coord) {
    return DECToDMS(DEC.from(coord));
  }

  LatLng toLatLng() {
    return DMSToDEC(this).toLatLng();
  }

  Map<String, String> format([int precision]) {
    return {'latitude': latitude.format(precision), 'longitude': longitude.format(precision)};
  }

  DMS normalize() {
    return DECToDMS(DMSToDEC(this));
  }

  @override
  String toString() {
    return 'latitude: $latitude, longitude: $longitude';
  }
}

enum HemisphereLatitude {North, South}
enum HemisphereLongitude {East, West}

// UTM with latitude Zones; Normal UTM is only separated into Hemispheres N and S
class UTMREF {
  UTMZone zone;
  double easting;
  double northing;

  UTMREF(this.zone, this.easting, this.northing);

  get hemisphere {
    return 'NPQRSTUVWXYZ'.contains(zone.latZone) ? HemisphereLatitude.North : HemisphereLatitude.South;
  }
}

class UTMZone {
  int lonZone;
  int lonZoneRegular; //the real lonZone differs from mathematical because of two special zones around norway
  String latZone;

  UTMZone(this.lonZoneRegular, this.lonZone, this.latZone);
}

class MGRS {
  UTMZone utmZone;
  String digraph;
  double easting;
  double northing;

  MGRS(this.utmZone, this.digraph, this.easting, this.northing);
}

class SwissGrid {
  double easting;
  double northing;

  SwissGrid(this.easting, this.northing);
}

class GaussKrueger {
  int code;
  double easting;
  double northing;

  GaussKrueger(this.code, this.easting, this.northing);
}

class Mercator {
  double easting;
  double northing;

  Mercator(this.easting, this.northing);

  @override
  String toString() {
    return 'Y: $easting\nX: $northing';
  }
}

class SlippyMap {
  double x;
  double y;
  double zoom;

  SlippyMap(this.x, this.y, this.zoom);

  @override
  String toString() {
    return 'X: $x\nY: $y\nZoom: $zoom';
  }
}