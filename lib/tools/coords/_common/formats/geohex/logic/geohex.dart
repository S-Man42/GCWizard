import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:latlong2/latlong.dart';

part 'package:gc_wizard/tools/coords/_common/formats/geohex/logic/external_libs/chsh.geohex4j/geohex.dart';

class GeoHex extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.GEOHEX);
  String text;

  GeoHex(this.text);

  @override
  LatLng? toLatLng() {
    return _geoHexToLatLon(this);
  }

  static GeoHex fromLatLon(LatLng coord, [int precision = 20]) {
    return _latLonToGeoHex(coord, precision);
  }

  static GeoHex? parse(String input) {
    return _parseGeoHex(input);
  }

  static GeoHex get emptyCoordinate => GeoHex('');

  @override
  String toString([int? precision]) {
    return text;
  }
}

LatLng? _geoHexToLatLon(GeoHex geoHex) {
  try {
    _Zone zone = _getZoneByCode(geoHex.text);
    return LatLng(zone.lat, zone.lon);
  } catch (e) {}

  return null;
}

GeoHex? _parseGeoHex(String input) {
  input = input.trim();
  if (input == '') return null;

  var _geoHex = GeoHex(input);
  return _geoHexToLatLon(_geoHex) == null ? null : _geoHex;
}

GeoHex _latLonToGeoHex(LatLng coord, int precision) {
  _Zone zone = _getZoneByLocation(coord.latitude, coord.longitude, precision);
  return GeoHex(zone.code);
}
