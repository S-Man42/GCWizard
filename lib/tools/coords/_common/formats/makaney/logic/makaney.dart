import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:latlong2/latlong.dart';

part 'package:gc_wizard/tools/coords/_common/formats/makaney/logic/external_libs/net.makaney/makaney.dart';

class Makaney extends BaseCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.MAKANEY);
  String text;

  Makaney(this.text);

  @override
  LatLng? toLatLng() {
    return __makaneyToLatLon(this);
  }

  static Makaney fromLatLon(LatLng coord) {
    return __latLonToMakaney(coord);
  }

  static Makaney? parse(String input) {
    return _parseMakaney(input);
  }

  @override
  String toString([int? precision]) {
    return text;
  }
}

LatLng? __makaneyToLatLon(Makaney makaney) {
  if (makaney.text.isEmpty) return null;

  var _text = makaney.text.toLowerCase();

  var regexCheck = RegExp(r'^-?[a-z\d]{1,4}([+\-])[a-z\d]{1,5}$');
  if (!regexCheck.hasMatch(_text)) {
    return null;
  }

  var latLon = _makaneyToLatLon(_text);
  if (latLon.contains(null)) return null;

  try {
    return LatLng(latLon[0], latLon[1]);
  } catch (e) {
    return null;
  }
}

Makaney __latLonToMakaney(LatLng latLon) {
  return Makaney(_latLonToMakaney(latLon.latitude, latLon.longitude).toUpperCase());
}

Makaney? _parseMakaney(String input) {
  var makaney = Makaney(input);
  return __makaneyToLatLon(makaney) == null ? null : makaney;
}
