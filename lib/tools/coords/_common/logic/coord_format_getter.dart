import 'package:gc_wizard/tools/coords/_common/logic/coords_return_types.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/utils/data_type_utils/double_type_utils.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:latlong2/latlong.dart';

String formatCoordOutput(LatLng _coords, CoordsFormatValue _outputFormat, Ellipsoid ells, [int precision = 10]) {
  switch (_outputFormat.type) {
    case CoordFormatKey.DEC:
      return DEC.fromLatLon(_coords).toString(precision);
    case CoordFormatKey.DMM:
      return DMM.fromLatLon(_coords).toString(precision);
    case CoordFormatKey.DMS:
      return DMS.fromLatLon(_coords).toString(precision);
    case CoordFormatKey.UTM:
      return UTMREF.fromLatLon(_coords, ells).toString();
    case CoordFormatKey.MGRS:
      return MGRS.fromLatLon(_coords, ells).toString();
    case CoordFormatKey.XYZ:
      return XYZ.fromLatLon(_coords, ells).toString();
    case CoordFormatKey.SWISS_GRID:
      return SwissGrid.fromLatLon(_coords, ells).toString();
    case CoordFormatKey.SWISS_GRID_PLUS:
      return SwissGridPlus.fromLatLon(_coords, ells).toString();
    case CoordFormatKey.GAUSS_KRUEGER:
      return GaussKrueger.fromLatLon(_coords, _outputFormat.subtype ?? defaultGaussKruegerType, ells)
          .toString();
    case CoordFormatKey.LAMBERT:
      return Lambert.fromLatLon(_coords, _outputFormat.subtype ?? defaultLambertType, ells).toString();
    case CoordFormatKey.DUTCH_GRID:
      return DutchGrid.fromLatLon(_coords).toString();
    case CoordFormatKey.MAIDENHEAD:
      return Maidenhead.fromLatLon(_coords).toString();
    case CoordFormatKey.MERCATOR:
      return Mercator.fromLatLon(_coords, ells).toString();
    case CoordFormatKey.NATURAL_AREA_CODE:
      return NaturalAreaCode.fromLatLon(_coords, precision: 8).toString();
    case CoordFormatKey.SLIPPY_MAP:
      return SlippyMap.fromLatLon(_coords, _outputFormat.subtype ?? defaultSlippyMapType).toString();
    case CoordFormatKey.GEOHASH:
      return Geohash.fromLatLon(_coords, 14).toString();
    case CoordFormatKey.GEOHEX:
      return GeoHex.fromLatLon(_coords, 20).toString();
    case CoordFormatKey.GEO3X3:
      return Geo3x3.fromLatLon(_coords, 20).toString();
    case CoordFormatKey.OPEN_LOCATION_CODE:
      return OpenLocationCode.fromLatLon(_coords, codeLength: 14).toString();
    case CoordFormatKey.QUADTREE:
      return Quadtree.fromLatLon(_coords, precision: 40).toString();
    case CoordFormatKey.MAKANEY:
      return Makaney.fromLatLon(_coords).toString();
    case CoordFormatKey.REVERSE_WIG_WALDMEISTER:
      return ReverseWherigoWaldmeister.fromLatLon(_coords).toString();
    case CoordFormatKey.REVERSE_WIG_DAY1976:
      return ReverseWherigoDay1976.fromLatLon(_coords).toString();
    default:
      return DEC.fromLatLon(_coords).toString();
  }
}

int coordinateSign(double value) {
  return value == 0 ? 1 : value.sign.toInt();
}

bool coordEquals(LatLng coords1, LatLng coords2, {tolerance: 1e-10}) {
  return doubleEquals(coords1.latitude, coords2.latitude) && doubleEquals(coords1.longitude, coords2.longitude);
}

double normalizeBearing(double bearing) {
  return modulo360(bearing).toDouble();
}

const Map<int, CoordFormatKey> SLIPPY_MAP_ZOOM = {
  0: CoordFormatKey.SLIPPYMAP_0,
  1: CoordFormatKey.SLIPPYMAP_1,
  2: CoordFormatKey.SLIPPYMAP_2,
  3: CoordFormatKey.SLIPPYMAP_3,
  4: CoordFormatKey.SLIPPYMAP_4,
  5: CoordFormatKey.SLIPPYMAP_5,
  6: CoordFormatKey.SLIPPYMAP_6,
  7: CoordFormatKey.SLIPPYMAP_7,
  8: CoordFormatKey.SLIPPYMAP_8,
  9: CoordFormatKey.SLIPPYMAP_9,
  10: CoordFormatKey.SLIPPYMAP_10,
  11: CoordFormatKey.SLIPPYMAP_11,
  12: CoordFormatKey.SLIPPYMAP_12,
  13: CoordFormatKey.SLIPPYMAP_13,
  14: CoordFormatKey.SLIPPYMAP_14,
  15: CoordFormatKey.SLIPPYMAP_15,
  16: CoordFormatKey.SLIPPYMAP_16,
  17: CoordFormatKey.SLIPPYMAP_17,
  18: CoordFormatKey.SLIPPYMAP_18,
  19: CoordFormatKey.SLIPPYMAP_19,
  20: CoordFormatKey.SLIPPYMAP_20,
  21: CoordFormatKey.SLIPPYMAP_21,
  22: CoordFormatKey.SLIPPYMAP_22,
  23: CoordFormatKey.SLIPPYMAP_23,
  24: CoordFormatKey.SLIPPYMAP_24,
  25: CoordFormatKey.SLIPPYMAP_25,
  26: CoordFormatKey.SLIPPYMAP_26,
  27: CoordFormatKey.SLIPPYMAP_27,
  28: CoordFormatKey.SLIPPYMAP_28,
  29: CoordFormatKey.SLIPPYMAP_29,
  30: CoordFormatKey.SLIPPYMAP_30
};