import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:latlong2/latlong.dart';

String formatCoordOutput(LatLng _coords, CoordinateFormat _outputFormat, Ellipsoid ells, [int precision = 10]) {
  switch (_outputFormat.type) {
    case CoordinateFormatKey.DEC:
      return DEC.fromLatLon(_coords).toString(precision);
    case CoordinateFormatKey.DMM:
      return DMM.fromLatLon(_coords).toString(precision);
    case CoordinateFormatKey.DMS:
      return DMS.fromLatLon(_coords).toString(precision);
    case CoordinateFormatKey.UTM:
      return UTMREF.fromLatLon(_coords, ells).toString();
    case CoordinateFormatKey.MGRS:
      return MGRS.fromLatLon(_coords, ells).toString();
    case CoordinateFormatKey.XYZ:
      return XYZ.fromLatLon(_coords, ells).toString();
    case CoordinateFormatKey.SWISS_GRID:
      return SwissGrid.fromLatLon(_coords, ells).toString();
    case CoordinateFormatKey.SWISS_GRID_PLUS:
      return SwissGridPlus.fromLatLon(_coords, ells).toString();
    case CoordinateFormatKey.GAUSS_KRUEGER:
      return GaussKrueger.fromLatLon(_coords, _outputFormat.subtype ?? defaultGaussKruegerType, ells)
          .toString();
    case CoordinateFormatKey.LAMBERT:
      return Lambert.fromLatLon(_coords, _outputFormat.subtype ?? defaultLambertType, ells).toString();
    case CoordinateFormatKey.DUTCH_GRID:
      return DutchGrid.fromLatLon(_coords).toString();
    case CoordinateFormatKey.MAIDENHEAD:
      return Maidenhead.fromLatLon(_coords).toString();
    case CoordinateFormatKey.MERCATOR:
      return Mercator.fromLatLon(_coords, ells).toString();
    case CoordinateFormatKey.NATURAL_AREA_CODE:
      return NaturalAreaCode.fromLatLon(_coords, precision: 8).toString();
    case CoordinateFormatKey.SLIPPY_MAP:
      return SlippyMap.fromLatLon(_coords, _outputFormat.subtype ?? defaultSlippyMapType).toString();
    case CoordinateFormatKey.GEOHASH:
      return Geohash.fromLatLon(_coords, 14).toString();
    case CoordinateFormatKey.GEOHEX:
      return GeoHex.fromLatLon(_coords, 20).toString();
    case CoordinateFormatKey.GEO3X3:
      return Geo3x3.fromLatLon(_coords, 20).toString();
    case CoordinateFormatKey.OPEN_LOCATION_CODE:
      return OpenLocationCode.fromLatLon(_coords, codeLength: 14).toString();
    case CoordinateFormatKey.QUADTREE:
      return Quadtree.fromLatLon(_coords, precision: 40).toString();
    case CoordinateFormatKey.MAKANEY:
      return Makaney.fromLatLon(_coords).toString();
    case CoordinateFormatKey.REVERSE_WIG_WALDMEISTER:
      return ReverseWherigoWaldmeister.fromLatLon(_coords).toString();
    case CoordinateFormatKey.REVERSE_WIG_DAY1976:
      return ReverseWherigoDay1976.fromLatLon(_coords).toString();
    default:
      return DEC.fromLatLon(_coords).toString();
  }
}