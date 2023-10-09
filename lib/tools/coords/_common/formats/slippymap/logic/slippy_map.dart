import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/coordinate_utils.dart';
import 'package:latlong2/latlong.dart';

// Source: https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames


class SlippyMap extends BaseCoordinateWithSubtypes {
  late CoordinateFormat _format;
  @override
  CoordinateFormat get format => _format;
  double x;
  double y;

  static const String _ERROR_INVALID_SUBTYPE = 'No valid SlippyMap subtype given.';

  SlippyMap(this.x, this.y, CoordinateFormatKey subtypeKey) {
    if (!isSubtypeOfCoordinateFormat(CoordinateFormatKey.SLIPPY_MAP, subtypeKey)) {
      throw Exception(_ERROR_INVALID_SUBTYPE);
    }

    _format = CoordinateFormat(CoordinateFormatKey.SLIPPY_MAP, subtypeKey);
  }

  @override
  LatLng toLatLng() {
    return _slippyMapToLatLon(this);
  }

  static SlippyMap fromLatLon(LatLng coord, CoordinateFormatKey subtype) {
    if (!isSubtypeOfCoordinateFormat(CoordinateFormatKey.SLIPPY_MAP, subtype)) {
      throw Exception(_ERROR_INVALID_SUBTYPE);
    }

    return _latLonToSlippyMap(coord, subtype);
  }

  static SlippyMap? parse(String input, {CoordinateFormatKey subtype = defaultSlippyMapType}) {
    if (!isSubtypeOfCoordinateFormat(CoordinateFormatKey.SLIPPY_MAP, subtype)) {
      throw Exception(_ERROR_INVALID_SUBTYPE);
    }

    return _parseSlippyMap(input, subtype: subtype);
  }

  @override
  String toString([int? precision]) {
    return 'X: $x\nY: $y\nZoom: ${switchMapKeyValue(SLIPPY_MAP_ZOOM)[_format.subtype]}';
  }
}

LatLng _slippyMapToLatLon(SlippyMap slippyMap) {
  int subtype = switchMapKeyValue(SLIPPY_MAP_ZOOM)[slippyMap.format.subtype]!;
  var lon = slippyMap.x / pow(2.0, subtype) * 360.0 - 180.0;

  var n = pi - 2.0 * pi * slippyMap.y / pow(2.0, subtype);
  var lat = 180.0 / pi * atan(0.5 * (exp(n) - exp(-n)));

  return normalizeLatLon(lat, lon);
}

SlippyMap _latLonToSlippyMap(LatLng coords, CoordinateFormatKey subtype) {
  if (!isSubtypeOfCoordinateFormat(CoordinateFormatKey.SLIPPY_MAP, subtype)) {
    subtype = defaultSlippyMapType;
  }

  int zoom = switchMapKeyValue(SLIPPY_MAP_ZOOM)[subtype]!;

  var x = (coords.longitude + 180.0) / 360.0 * pow(2.0, zoom);
  var y = (1 - log(tan(coords.latitude * pi / 180.0) + 1.0 / cos(coords.latitude * pi / 180.0)) / pi) /
      2.0 *
      pow(2.0, zoom);

  return SlippyMap(x, y, subtype);
}

SlippyMap? _parseSlippyMap(String input, {CoordinateFormatKey subtype = defaultSlippyMapType}) {
  RegExp regExp = RegExp(r'^\s*([\0-9.]+)(\s*,\s*|\s+)([\0-9.]+)\s*$');
  var matches = regExp.allMatches(input);
  String? xString = '';
  String? yString = '';

  if (matches.isNotEmpty) {
    var match = matches.elementAt(0);
    xString = match.group(1);
    yString = match.group(3);
  }
  if (matches.isEmpty) {
    regExp = RegExp(r'^\s*([Xx]):?\s*([\0-9.]+)(\s*,?\s*)([Yy]):?\s*([\0-9.]+)\s*$');
    matches = regExp.allMatches(input);
    if (matches.isNotEmpty) {
      var match = matches.elementAt(0);
      xString = match.group(2);
      yString = match.group(5);
    }
  }

  if (matches.isEmpty) return null;
  if (xString == null || yString == null) {
    return null;
  }

  var x = double.tryParse(xString);
  if (x == null) return null;

  var y = double.tryParse(yString);
  if (y == null) return null;

  return SlippyMap(x, y, subtype);
}
