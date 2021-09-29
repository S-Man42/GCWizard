import 'dart:math';

import 'package:latlong2/latlong.dart';

// https://carto.com/blog/center-of-points/
LatLng centroid(List<LatLng> coords) {
  if (coords == null || coords.isEmpty) return null;

  if (coords.length == 1) return coords.first;

  var centroidLat = coords.map((coord) => coord.latitude).reduce((a, b) => a + b) / coords.length;

  var lonZetaSum = 0.0;
  var lonXiSum = 0.0;
  for (LatLng coord in coords) {
    lonZetaSum += sin(coord.longitudeInRad);
    lonXiSum += cos(coord.longitudeInRad);
  }
  lonZetaSum = lonZetaSum / coords.length;
  lonXiSum = lonXiSum / coords.length;
  var centroidLon = 180.0 * atan2(lonZetaSum, lonXiSum) / pi;

  return LatLng(centroidLat, centroidLon);
}
