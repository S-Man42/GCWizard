import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/vincenty/projection_vincenty.dart';
import 'package:latlong/latlong.dart';

LatLng projection(LatLng coords,  double crs12, double d12, Ellipsoid ellipsoid) {
  return projectionRadian(coords, degToRadian(crs12), d12, ellipsoid);
}

LatLng projectionRadian(LatLng coords, double crs12, double d12, Ellipsoid ellipsoid) {
  return projectionVincenty(coords, crs12, d12, ellipsoid);
}
