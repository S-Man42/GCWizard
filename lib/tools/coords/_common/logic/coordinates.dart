import 'package:gc_wizard/tools/coords/_common/formats/swissgridplus/logic/swissgridplus.dart';
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
import 'package:latlong2/latlong.dart';

//abstract class BaseCoordFormatKey {}

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

  static BaseCoordinate get emptyCoordinate => buildDefaultCoordinateByCoordinates(defaultCoordinate);

  @override
  String toString([int? precision]) {
    return LatLng(latitude, longitude).toString();
  }
}

abstract class BaseCoordinateWithSubtypes extends BaseCoordinate {

  CoordinateFormatKey? get defaultSubtype => null;
}

enum HemisphereLatitude { North, South }

enum HemisphereLongitude { East, West }

int getCoordinateSignFromString(String text, bool isLatitude) {
  int _sign = 0;

  if (isLatitude) {
    _sign = (text == 'N') ? 1 : -1;
  } else {
    _sign = (text == 'E') ? 1 : -1;
  }

  return _sign;
}

BaseCoordinate buildUninitializedCoordinateByFormat(CoordinateFormat format) {

  switch (format.type) {
    case CoordinateFormatKey.DEC:
      return DEC.emptyCoordinate;
    case CoordinateFormatKey.DMM:
      return DMM.emptyCoordinate;
    case CoordinateFormatKey.DMS:
      return DMS.emptyCoordinate;
    case CoordinateFormatKey.UTM:
      return UTMREF.emptyCoordinate;
    case CoordinateFormatKey.MGRS:
      return MGRS.emptyCoordinate;
    case CoordinateFormatKey.XYZ:
      return XYZ.emptyCoordinate;
    case CoordinateFormatKey.SWISS_GRID:
      return SwissGrid.emptyCoordinate;
    case CoordinateFormatKey.SWISS_GRID_PLUS:
      return SwissGridPlus.emptyCoordinate;
    case CoordinateFormatKey.DUTCH_GRID:
      return DutchGrid.emptyCoordinate;
    case CoordinateFormatKey.GAUSS_KRUEGER:
      return GaussKrueger.emptyCoordinate;
    case CoordinateFormatKey.LAMBERT:
      return Lambert.emptyCoordinate;
    case CoordinateFormatKey.MAIDENHEAD:
      return Maidenhead.emptyCoordinate;
    case CoordinateFormatKey.MERCATOR:
      return Mercator.emptyCoordinate;
    case CoordinateFormatKey.NATURAL_AREA_CODE:
      return NaturalAreaCode.emptyCoordinate;
    case CoordinateFormatKey.SLIPPY_MAP:
      return SlippyMap.emptyCoordinate;
    case CoordinateFormatKey.GEOHASH:
      return Geohash.emptyCoordinate;
    case CoordinateFormatKey.GEO3X3:
      return Geo3x3.emptyCoordinate;
    case CoordinateFormatKey.GEOHEX:
      return GeoHex.emptyCoordinate;
    case CoordinateFormatKey.OPEN_LOCATION_CODE:
      return OpenLocationCode.emptyCoordinate;
    case CoordinateFormatKey.MAKANEY:
      return Makaney.emptyCoordinate;
    case CoordinateFormatKey.QUADTREE:
      return Quadtree.emptyCoordinate;
    case CoordinateFormatKey.REVERSE_WIG_WALDMEISTER:
      return ReverseWherigoWaldmeister.emptyCoordinate;
    case CoordinateFormatKey.REVERSE_WIG_DAY1976:
      return ReverseWherigoDay1976.emptyCoordinate;
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
