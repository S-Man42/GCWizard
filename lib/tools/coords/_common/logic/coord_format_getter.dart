import 'package:gc_wizard/tools/coords/format_converter/logic/lambert.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/utils/data_type_utils/double_type_utils.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:latlong2/latlong.dart';

String formatCoordOutput(LatLng _coords, Map<String, String> _outputFormat, Ellipsoid ells, [int precision]) {
  switch (_outputFormat['format']) {
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
      return GaussKrueger.fromLatLon(_coords, getCodeFromGaussKruegerSubType(_outputFormat['subtype'], defaultValue: 0), ells)
          .toString();
    case CoordFormatKey.LAMBERT:
      return Lambert.fromLatLon(_coords, getLambertType(_outputFormat['subtype'], defaultValue: null), ells).toString();
    case CoordFormatKey.DUTCH_GRID:
      return DutchGrid.fromLatLon(_coords).toString();
    case CoordFormatKey.MAIDENHEAD:
      return Maidenhead.fromLatLon(_coords).toString();
    case CoordFormatKey.MERCATOR:
      return Mercator.fromLatLon(_coords, ells).toString();
    case CoordFormatKey.NATURAL_AREA_CODE:
      return NaturalAreaCode.fromLatLon(_coords, precision: 8).toString();
    case CoordFormatKey.SLIPPY_MAP:
      return SlippyMap.fromLatLon(_coords, double.tryParse(_outputFormat['subtype'])).toString();
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
  return modulo360(bearing);
}

LambertType getLambertType(String subtype, {defaultValue: defaultLambertType}) {
  switch (subtype) {
    case CoordFormatKey.LAMBERT93:
      return LambertType.LAMBERT_93;
    case CoordFormatKey.LAMBERT2008:
      return LambertType.LAMBERT_2008;
    case CoordFormatKey.ETRS89LCC:
      return LambertType.ETRS89_LCC;
    case CoordFormatKey.LAMBERT72:
      return LambertType.LAMBERT_72;
    case CoordFormatKey.LAMBERT93_CC42:
      return LambertType.L93_CC42;
    case CoordFormatKey.LAMBERT93_CC43:
      return LambertType.L93_CC43;
    case CoordFormatKey.LAMBERT93_CC44:
      return LambertType.L93_CC44;
    case CoordFormatKey.LAMBERT93_CC45:
      return LambertType.L93_CC45;
    case CoordFormatKey.LAMBERT93_CC46:
      return LambertType.L93_CC46;
    case CoordFormatKey.LAMBERT93_CC47:
      return LambertType.L93_CC47;
    case CoordFormatKey.LAMBERT93_CC48:
      return LambertType.L93_CC48;
    case CoordFormatKey.LAMBERT93_CC49:
      return LambertType.L93_CC49;
    case CoordFormatKey.LAMBERT93_CC50:
      return LambertType.L93_CC50;
    default:
      return defaultValue;
  }
}

String getLambertKey({LambertType lambertType: defaultLambertType}) {
  switch (lambertType) {
    case LambertType.LAMBERT_93:
      return CoordFormatKey.LAMBERT93;
    case LambertType.LAMBERT_2008:
      return CoordFormatKey.LAMBERT2008;
    case LambertType.ETRS89_LCC:
      return CoordFormatKey.ETRS89LCC;
    case LambertType.LAMBERT_72:
      return CoordFormatKey.LAMBERT72;
    case LambertType.L93_CC42:
      return CoordFormatKey.LAMBERT93_CC42;
    case LambertType.L93_CC43:
      return CoordFormatKey.LAMBERT93_CC43;
    case LambertType.L93_CC44:
      return CoordFormatKey.LAMBERT93_CC44;
    case LambertType.L93_CC45:
      return CoordFormatKey.LAMBERT93_CC45;
    case LambertType.L93_CC46:
      return CoordFormatKey.LAMBERT93_CC46;
    case LambertType.L93_CC47:
      return CoordFormatKey.LAMBERT93_CC47;
    case LambertType.L93_CC48:
      return CoordFormatKey.LAMBERT93_CC48;
    case LambertType.L93_CC49:
      return CoordFormatKey.LAMBERT93_CC49;
    case LambertType.L93_CC50:
      return CoordFormatKey.LAMBERT93_CC50;
  }
}

int getCodeFromGaussKruegerSubType(CoordFormatKey subtype) {
  switch (subtype) {
    case CoordFormatKey.GAUSS_KRUEGER_GK1:
      return 1;
    case CoordFormatKey.GAUSS_KRUEGER_GK2:
      return 2;
    case CoordFormatKey.GAUSS_KRUEGER_GK3:
      return 3;
    case CoordFormatKey.GAUSS_KRUEGER_GK4:
      return 4;
    case CoordFormatKey.GAUSS_KRUEGER_GK5:
      return 5;
    default:
      return 1;
  }
}

CoordFormatKey getGaussKruegerTypKeyFromCode(int gaussKruegerCode) {
  switch (gaussKruegerCode) {
    case 1:
      return CoordFormatKey.GAUSS_KRUEGER_GK1;
    case 2:
      return CoordFormatKey.GAUSS_KRUEGER_GK2;
    case 3:
      return CoordFormatKey.GAUSS_KRUEGER_GK3;
    case 4:
      return CoordFormatKey.GAUSS_KRUEGER_GK4;
    case 5:
      return CoordFormatKey.GAUSS_KRUEGER_GK5;
    default:
      return defaultGaussKruegerType;
  }
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
  30: CoordFormatKey.SLIPPYMAP_30,
}