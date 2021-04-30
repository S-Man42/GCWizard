import 'dart:math';

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:latlong/latlong.dart';

var _TILESIZE = 256;
const int _DEFAULT_PRECISION = 40;

List<int> latLonToQuadtree(LatLng coord, {int precision: _DEFAULT_PRECISION}) {
  var x = (_TILESIZE / 2.0) + coord.longitude * (_TILESIZE / 360.0);

  var siny = sin(degreesToRadian(coord.latitude));
  var y = (_TILESIZE / 2.0) + 0.5 * log((1.0 + siny) / (1.0 - siny)) * -(_TILESIZE / (2.0 * PI));

  var countTiles = 1 << precision;

  var tileX = (x * countTiles / _TILESIZE).floor();
  var tileY = (y * countTiles / _TILESIZE).floor();

  var out = <int>[];
  for (int i = 0; i < precision; i++) {
    var quadrant = 2 * (tileY % 2) + tileX % 2;
    out.add(quadrant);

    tileX = (tileX / 2).floor();
    tileY = (tileY / 2).floor();
  }

  return out.reversed.toList();
}

LatLng quadtreeToLatLon(List<int> quadtree) {
  var tileX = 0;
  var tileY = 0;

  for (var i = 0; i < quadtree.length; i++) {
    tileX = 2 * tileX + quadtree[i] % 2;
    tileY = 2 * tileY + (quadtree[i] / 2.0).floor();
  }

  var countTiles = 1 << quadtree.length;

  var x = (tileX) * _TILESIZE / countTiles;
  var y = (tileY) * _TILESIZE / countTiles;

  var lon = (x - _TILESIZE / 2.0) / (_TILESIZE / 360.0);

  var latRadians = (y - _TILESIZE / 2.0) / -(_TILESIZE / (2.0 * PI));
  var lat = radianToDegrees(2 * atan(exp(latRadians)) - PI / 2);
  return LatLng(lat, lon);
}

LatLng parseQuadtree(String input) {
  if (input == null) return null;
  input = input.trim();

  if (input == '') return null;

  if (input.length != input.replaceAll(RegExp(r'[^0123]'), '').length) return null;

  return quadtreeToLatLon(input.split('').map((character) => int.tryParse(character)).toList());
}
