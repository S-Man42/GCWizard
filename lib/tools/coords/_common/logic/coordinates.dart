import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dec/logic/dec.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dmm/logic/dmm.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dms/logic/dms.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dutchgrid/logic/dutchgrid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/gausskrueger/logic/gauss_krueger.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geo3x3/logic/geo3x3.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geohash/logic/geohash.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geohex/logic/geohex.dart';
import 'package:gc_wizard/tools/coords/_common/formats/lambert/logic/lambert.dart';
import 'package:gc_wizard/tools/coords/_common/formats/maidenhead/logic/maidenhead.dart';
import 'package:gc_wizard/tools/coords/_common/formats/makaney/logic/makaney.dart';
import 'package:gc_wizard/tools/coords/_common/formats/mercator/logic/mercator.dart';
import 'package:gc_wizard/tools/coords/_common/formats/mgrs_utm/logic/mgrs.dart';
import 'package:gc_wizard/tools/coords/_common/formats/natural_area_code/logic/natural_area_code.dart';
import 'package:gc_wizard/tools/coords/_common/formats/openlocationcode/logic/open_location_code.dart';
import 'package:gc_wizard/tools/coords/_common/formats/quadtree/logic/quadtree.dart';
import 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_day1976/logic/reverse_wherigo_day1976.dart';
import 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_waldmeister/logic/reverse_wherigo_waldmeister.dart';
import 'package:gc_wizard/tools/coords/_common/formats/slippymap/logic/slippy_map.dart';
import 'package:gc_wizard/tools/coords/_common/formats/swissgrid/logic/swissgrid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/utm/logic/utm.dart';
import 'package:gc_wizard/tools/coords/_common/formats/xyz/logic/xyz.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

abstract class BaseCoordFormatKey {}

int getCoordinateSignFromString(String text, bool isLatitude) {
  int _sign = 0;

  if (isLatitude) {
    _sign = (text == 'N') ? 1 : -1;
  } else {
    _sign = (text == 'E') ? 1 : -1;
  }

  return _sign;
}

abstract class BaseCoordinate {
  CoordinateFormat get format;
  late double latitude;
  late double longitude;

  BaseCoordinate([double? latitude, double? longitude]) {
    this.latitude = latitude ?? defaultCoordinate.latitude;
    this.longitude = longitude ?? defaultCoordinate.longitude;
  }

  // TODO: Make this null-safe. Some inheriting CoordFormats may return null here. This shall be avoided.
  LatLng? toLatLng() {
    return LatLng(latitude, longitude);
  }

  @override
  String toString([int? precision]) {
    return LatLng(latitude, longitude).toString();
  }
}

abstract class BaseCoordinateWithSubtypes extends BaseCoordinate {}

enum HemisphereLatitude { North, South }

enum HemisphereLongitude { East, West }



class Makaney extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.MAKANEY);
  String text;

  Makaney(this.text);

  @override
  LatLng? toLatLng() {
    return makaneyToLatLon(this);
  }

  static Makaney fromLatLon(LatLng coord) {
    return latLonToMakaney(coord);
  }

  static Makaney? parse(String input) {
    return parseMakaney(input);
  }

  @override
  String toString([int? precision]) {
    return text;
  }
}

class Geohash extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.GEOHASH);
  String text;

  Geohash(this.text);

  @override
  LatLng? toLatLng() {
    return geohashToLatLon(this);
  }

  static Geohash fromLatLon(LatLng coord, [int geohashLength = 14]) {
    return latLonToGeohash(coord, geohashLength);
  }

  static Geohash? parse(String input) {
    return parseGeohash(input);
  }

  @override
  String toString([int? precision]) {
    return text;
  }
}

class GeoHex extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.GEOHEX);
  String text;

  GeoHex(this.text);

  @override
  LatLng? toLatLng() {
    return geoHexToLatLon(this);
  }

  static GeoHex fromLatLon(LatLng coord, [int precision = 20]) {
    return latLonToGeoHex(coord, precision);
  }

  static GeoHex? parse(String input) {
    return parseGeoHex(input);
  }

  @override
  String toString([int? precision]) {
    return text;
  }
}

class Geo3x3 extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.GEO3X3);
  String text;

  Geo3x3(this.text);

  @override
  LatLng? toLatLng() {
    return geo3x3ToLatLon(this);
  }

  static Geo3x3 fromLatLon(LatLng coord, [int level = 20]) {
    return latLonToGeo3x3(coord, level);
  }

  static Geo3x3? parse(String input) {
    return parseGeo3x3(input);
  }

  @override
  String toString([int? precision]) {
    return text.toUpperCase();
  }
}

class OpenLocationCode extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.OPEN_LOCATION_CODE);
  String text;

  OpenLocationCode(this.text);

  @override
  LatLng? toLatLng() {
    return openLocationCodeToLatLon(this);
  }

  static OpenLocationCode fromLatLon(LatLng coord, [int codeLength = 14]) {
    return latLonToOpenLocationCode(coord, codeLength: codeLength);
  }

  static OpenLocationCode? parse(String input) {
    return parseOpenLocationCode(input);
  }

  @override
  String toString([int? precision]) {
    return text;
  }
}

class Quadtree extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.QUADTREE);
  List<int> coords;

  Quadtree(this.coords);

  @override
  LatLng toLatLng() {
    return quadtreeToLatLon(this);
  }

  static Quadtree? parse(String input) {
    return parseQuadtree(input);
  }

  static Quadtree fromLatLon(LatLng coord, [int precision = 40]) {
    return latLonToQuadtree(coord, precision: precision);
  }

  @override
  String toString([int? precision]) {
    return coords.join();
  }
}

BaseCoordinate buildUninitializedCoordinateByFormat(CoordinateFormat format) {
  if (isCoordinateFormatWithSubtype(format.type)) {
    if (format.subtype == null || !isSubtypeOfCoordinateFormat(format.type, format.subtype!)) {
      format.subtype = defaultCoordinateFormatSubtypeForFormat(format.type);
    }
  }

  switch (format.type) {
    case CoordinateFormatKey.DEC:
      return DEC(0.0, 0.0);
    case CoordinateFormatKey.DMM:
      return DMM(DMMLatitude(0, 0, 0), DMMLongitude(0, 0, 0));
    case CoordinateFormatKey.DMS:
      return DMS(DMSLatitude(0, 0, 0, 0), DMSLongitude(0, 0, 0, 0));
    case CoordinateFormatKey.UTM:
      return UTMREF(UTMZone(0, 0, 'U'), 0, 0);
    case CoordinateFormatKey.MGRS:
      return MGRS(UTMZone(0, 0, 'A'), 'AA', 0, 0);
    case CoordinateFormatKey.XYZ:
      return XYZ(0, 0, 0);
    case CoordinateFormatKey.SWISS_GRID:
      return SwissGrid(0, 0);
    case CoordinateFormatKey.SWISS_GRID_PLUS:
      return SwissGridPlus(0, 0);
    case CoordinateFormatKey.DUTCH_GRID:
      return DutchGrid(0, 0);
    case CoordinateFormatKey.GAUSS_KRUEGER:
      return GaussKrueger(defaultGaussKruegerType, 0, 0);
    case CoordinateFormatKey.LAMBERT:
      return Lambert(defaultLambertType, 0, 0);
    case CoordinateFormatKey.MAIDENHEAD:
      return Maidenhead('');
    case CoordinateFormatKey.MERCATOR:
      return Mercator(0, 0);
    case CoordinateFormatKey.NATURAL_AREA_CODE:
      return NaturalAreaCode('', '');
    case CoordinateFormatKey.SLIPPY_MAP:
      return SlippyMap(0, 0, defaultSlippyMapType);
    case CoordinateFormatKey.GEOHASH:
      return Geohash('');
    case CoordinateFormatKey.GEO3X3:
      return Geo3x3('');
    case CoordinateFormatKey.GEOHEX:
      return GeoHex('');
    case CoordinateFormatKey.OPEN_LOCATION_CODE:
      return OpenLocationCode('');
    case CoordinateFormatKey.MAKANEY:
      return Makaney('');
    case CoordinateFormatKey.QUADTREE:
      return Quadtree([]);
    case CoordinateFormatKey.REVERSE_WIG_WALDMEISTER:
      return ReverseWherigoWaldmeister(0, 0, 0);
    case CoordinateFormatKey.REVERSE_WIG_DAY1976:
      return ReverseWherigoDay1976('00000', '00000');
    default:
      return buildDefaultCoordinateByCoordinates(defaultCoordinate);
  }
}

BaseCoordinate buildDefaultCoordinateByCoordinates(LatLng coords) {
  return buildCoordinate(defaultCoordinateFormat, coords, defaultEllipsoid);
}

BaseCoordinate buildCoordinate(CoordinateFormat format, LatLng coords, [Ellipsoid? ellipsoid]) {
  if (isCoordinateFormatWithSubtype(format.type)) {
    if (format.subtype == null || !isSubtypeOfCoordinateFormat(format.type, format.subtype!)) {
      format.subtype = defaultCoordinateFormatSubtypeForFormat(format.type);
    }
  }

  ellipsoid ??= defaultEllipsoid;

  switch (format.type) {
    case CoordinateFormatKey.DEC:
      return DEC.fromLatLon(coords);
    case CoordinateFormatKey.DMM:
      return DMM.fromLatLon(coords);
    case CoordinateFormatKey.DMS:
      return DMS.fromLatLon(coords);
    case CoordinateFormatKey.UTM:
      return UTMREF.fromLatLon(coords, ellipsoid);
    case CoordinateFormatKey.MGRS:
      return MGRS.fromLatLon(coords, ellipsoid);
    case CoordinateFormatKey.XYZ:
      return XYZ.fromLatLon(coords, ellipsoid);
    case CoordinateFormatKey.SWISS_GRID:
      return SwissGrid.fromLatLon(coords, ellipsoid);
    case CoordinateFormatKey.SWISS_GRID_PLUS:
      return SwissGridPlus.fromLatLon(coords, ellipsoid);
    case CoordinateFormatKey.DUTCH_GRID:
      return DutchGrid.fromLatLon(coords);
    case CoordinateFormatKey.GAUSS_KRUEGER:
      return GaussKrueger.fromLatLon(coords, format.subtype!, ellipsoid);
    case CoordinateFormatKey.LAMBERT:
      return Lambert.fromLatLon(coords, format.subtype!, ellipsoid);
    case CoordinateFormatKey.MAIDENHEAD:
      return Maidenhead.fromLatLon(coords);
    case CoordinateFormatKey.MERCATOR:
      return Mercator.fromLatLon(coords, ellipsoid);
    case CoordinateFormatKey.NATURAL_AREA_CODE:
      return NaturalAreaCode.fromLatLon(coords);
    case CoordinateFormatKey.SLIPPY_MAP:
      return SlippyMap.fromLatLon(coords, format.subtype!);
    case CoordinateFormatKey.GEOHASH:
      return Geohash.fromLatLon(coords);
    case CoordinateFormatKey.GEO3X3:
      return Geo3x3.fromLatLon(coords);
    case CoordinateFormatKey.GEOHEX:
      return GeoHex.fromLatLon(coords);
    case CoordinateFormatKey.OPEN_LOCATION_CODE:
      return OpenLocationCode.fromLatLon(coords);
    case CoordinateFormatKey.MAKANEY:
      return Makaney.fromLatLon(coords);
    case CoordinateFormatKey.QUADTREE:
      return Quadtree.fromLatLon(coords);
    case CoordinateFormatKey.REVERSE_WIG_WALDMEISTER:
      return ReverseWherigoWaldmeister.fromLatLon(coords);
    case CoordinateFormatKey.REVERSE_WIG_DAY1976:
      return ReverseWherigoDay1976.fromLatLon(coords);
    default:
      return buildDefaultCoordinateByCoordinates(coords);
  }
}
