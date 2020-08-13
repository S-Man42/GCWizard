import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_lines.dart';
import 'package:latlong/latlong.dart';

List<LatLng> intersection (LatLng coord1, double alpha, LatLng coord2, double beta, Ellipsoid ells) {
  DistanceBearingData crs = distanceBearing(coord1, coord2, ells);

  LatLng i1 = intersectBearings(coord1, crs.bearingAToB + alpha, coord2, crs.bearingBToA - beta, ells, false);
  LatLng i2 = intersectBearings(coord1, crs.bearingAToB - alpha, coord2, crs.bearingBToA + beta, ells, false);

  return [i1, i2];
}