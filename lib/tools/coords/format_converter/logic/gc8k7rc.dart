import 'dart:math';

import 'package:gc_wizard/tools/coords/format_converter/logic/dec.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:latlong2/latlong.dart';

const rEarth = 6378.90594503519;
const vEquator = 464;

LatLng GC8K7RCToLatLon(GC8K7RC coordsGC8K7RC) {
  double u = coordsGC8K7RC.velocity * 24 * 60 * 60;
  double r = u / 2 / pi;
  double lat = acos(r / rEarth);

  double long = 360 * coordsGC8K7RC.distance / u;
  return decToLatLon(DEC(lat, long));
}

GC8K7RC latLonToGC8K7RC(LatLng coord) {

  return GC8K7RC(0.0, 0.0);
}

GC8K7RC? parseGC8K7RC(String input) {
  input = input.toLowerCase();
  RegExp regExp = RegExp(r'^\s*([\d.]+)(\s*,\s*|\s+)([\d.]+)\s*$');
  var matches = regExp.allMatches(input);
  if (matches.isEmpty) return null;

  var match = matches.elementAt(0);

  var a = match.group(1);
  var b = match.group(3);

  if (a == null || b == null) return null;

  return GC8K7RC(double.parse(a), double.parse(b));
}
