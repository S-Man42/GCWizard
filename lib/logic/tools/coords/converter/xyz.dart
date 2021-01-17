import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

LatLng xyzToLatLon (XYZ xyz, Ellipsoid ells) {
  var x = xyz.x;
  var y = xyz.y;
  var z = xyz.z;

  var p = sqrt(x * x + y * y);
  var r = sqrt(p * p + z * z);
  var m = atan((z / p) * ((1 - ells.f) + (ells.e2 * ells.a) / r));

  var lon = atan(y / x);
  if (lon < 0)
    lon = pi + lon;

  var lat_top = z * (1 - ells.f) + ells.e2 * ells.a * sin(m) * sin(m) * sin(m);
  var lat_bottom = (1 - ells.f) * (p - ells.e2 * ells.a * cos(m) * cos(m) * cos(m));
  var lat = atan(lat_top / lat_bottom);

  var h = p * cos(lat) + z * sin(lat) - ells.a * sqrt(1 - ells.e2 * sin(lat) * sin(lat));

  return LatLng(radianToDeg(lat), radianToDeg(lon));
}

XYZ latLonToXYZ (LatLng coord, Ellipsoid ells, {double h: 0.0}) {
  var lat = coord.latitudeInRad;
  var lon = coord.longitudeInRad;
  var v = ells.a / sqrt(1 - ells.e2 * sin(lat) * sin(lat));

  var x = (v + h) * cos(lat) * cos(lon);
  var y = (v + h) * cos(lat) * sin(lon);
  var z =((1 - ells.e2) * v + h) * sin(lat);

  return XYZ(x, y, z);
}

String latLonToXYZString(LatLng coord, Ellipsoid ells, {double h: 0.0}) {
  XYZ xyz = latLonToXYZ(coord, ells, h: h);

  var numberFormat = NumberFormat('0.######');
  return 'X: ${numberFormat.format(xyz.x)}\nY: ${numberFormat.format(xyz.y)}\nZ: ${numberFormat.format(xyz.z)}';
}

LatLng parseXYZ(String input, Ellipsoid ells) {
  RegExp regExp = RegExp(r'^\s*([\-0-9\.]+)(\s*,\s*|\s+)([\-0-9\.]+)(\s*,\s*|\s+)([\-0-9\.]+)\s*$');
  var matches = regExp.allMatches(input);
  if (matches.length == 0)
    return null;

  var match = matches.elementAt(0);

  var x = double.tryParse(match.group(1));
  var y = double.tryParse(match.group(3));
  var z = double.tryParse(match.group(5));

  if (x == null || y == null || z == null)
    return null;

  return xyzToLatLon(XYZ(x, y, z), ells);
}