import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_two_circles.dart';
import 'package:latlong/latlong.dart';

List<LatLng> equilateralTriangle(LatLng coord1, LatLng coord2, Ellipsoid ellipsoid) {
  var distance = distanceBearing(coord1, coord2, ellipsoid).distance;

  return intersectTwoCircles(coord1, distance, coord2, distance, ellipsoid);
}