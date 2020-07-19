import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

// Source: https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames

LatLng slippyMapToLatLon(SlippyMap slippyMap) {
  var lon = slippyMap.x / pow(2.0, slippyMap.zoom) * 360.0 - 180.0;
  
  var n = pi - 2.0 * pi * slippyMap.y / pow(2.0, slippyMap.zoom);
  var lat = 180.0 / pi * atan(0.5 * (exp(n) - exp(-n)));

  return LatLng(lat, lon);
}


SlippyMap latLonToSlippyMap(LatLng coords, double zoom) {
  var x = (coords.longitude + 180.0) / 360.0 * pow(2.0, zoom);
  var y = (1 - log(tan(coords.latitude * pi / 180.0) + 1.0 / cos(coords.latitude * pi / 180.0)) / pi) / 2.0 * pow(2.0, zoom);

  return SlippyMap(x, y, zoom);
}

String latLonToSlippyMapString(LatLng coords, double zoom) {
  var slippyMap = latLonToSlippyMap(coords, zoom);

  var numberFormat = NumberFormat('0.######');
  return 'X: ${numberFormat.format(slippyMap.x)}\nY: ${numberFormat.format(slippyMap.y)}';
}