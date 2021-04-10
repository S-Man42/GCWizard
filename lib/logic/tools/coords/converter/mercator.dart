import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:latlong/latlong.dart';

LatLng mercatorToLatLon(Mercator mercator, Ellipsoid ells) {
  var y = mercator.easting;
  var x = mercator.northing;

  var lat = 180 / PI * (2 * atan(exp(((y / (2 * PI * ells.a / 2.0)) * 180.0) * PI / 180.0)) - PI / 2.0);
  var lon = (x / (2 * PI * ells.a / 2.0)) * 180.0;

  return LatLng(lat, lon);
}

Mercator latLonToMercator(LatLng coord, Ellipsoid ells) {
  var x = coord.longitude * (2 * PI * ells.a / 2.0) / 180.0;
  var y = (log(tan((90 + coord.latitude) * PI / 360.0)) / (PI / 180.0)) * (2 * PI * ells.a / 2.0) / 180.0;

  return Mercator(y, x);
}

String latLonToMercatorString(LatLng coord, Ellipsoid ells) {
  Mercator mercator = latLonToMercator(coord, ells);

  return 'Y: ${mercator.easting}\nX: ${mercator.northing}';
}

LatLng parseMercatorToLatLon(String mercator, Ellipsoid ells) {
  var coords = parseMercator(mercator);
  return coords == null ? null : mercatorToLatLon(coords, ells);
}

Mercator parseMercator(String input) {
  RegExp regExp = RegExp(r'^\s*([\-0-9\.]+)(\s*,\s*|\s+)([\-0-9\.]+)\s*$');
  var matches = regExp.allMatches(input);

  var _eastingString = '';
  var _northingString = '';

  if (matches.length > 0) {
    var match = matches.elementAt(0);
    _eastingString = match.group(1);
    _northingString = match.group(3);
  }
  if (matches.length == 0) {
    regExp = RegExp(r'^\s*(Y|y)\:?\s*([\-0-9\.]+)(\s*\,?\s*)(X|x)\:?\s*([\-0-9\.]+)\s*$');
    matches = regExp.allMatches(input);
    if (matches.length > 0) {
      var match = matches.elementAt(0);
      _eastingString = match.group(2);
      _northingString = match.group(5);
    }
  }

  if (matches.length == 0) return null;

  var _easting = double.tryParse(_eastingString);
  if (_easting == null) return null;

  var _northing = double.tryParse(_northingString);
  if (_northing == null) return null;

  return Mercator(_easting, _northing);
}
