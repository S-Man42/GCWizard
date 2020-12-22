import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:latlong/latlong.dart';

LatLng mercatorToLatLon (Mercator mercator, Ellipsoid ells) {
  var y = mercator.easting;
  var x = mercator.northing;
  
  var lat = 180 / PI * (2 * atan( exp( ((y / (2 * PI * ells.a / 2.0)) * 180.0) * PI / 180.0)) - PI / 2.0);
  var lon = (x / (2 * PI * ells.a / 2.0)) * 180.0;

  return LatLng(lat, lon);
}

Mercator latLonToMercator (LatLng coord, Ellipsoid ells) {
  var x = coord.longitude * (2 * PI * ells.a / 2.0) / 180.0;
  var y = (log( tan((90 + coord.latitude) * PI / 360.0 )) / (PI / 180.0)) * (2 * PI * ells.a / 2.0) / 180.0;

  return Mercator(y, x);
}

String latLonToMercatorString(LatLng coord, Ellipsoid ells) {
  Mercator mercator = latLonToMercator(coord, ells);

  return 'Y: ${mercator.easting}\nX: ${mercator.northing}';
}

LatLng parseMercator(String input, Ellipsoid ells) {
  RegExp regExp = RegExp(r'^\s*([\-0-9\.]+)(\s*,\s*|\s+)([\-0-9\.]+)\s*$');
  var matches = regExp.allMatches(input);
  if (matches.length == 0)
    return null;

  var match = matches.elementAt(0);

  var _easting = double.tryParse(match.group(1));
  if (_easting == null)
    return null;

  var _northing = double.tryParse(match.group(3));
  if (_northing == null)
    return null;

  return mercatorToLatLon(Mercator(_easting, _northing), ells);
}