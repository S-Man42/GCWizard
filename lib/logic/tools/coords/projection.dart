import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/vincenty/projection_vincenty.dart';
import 'package:latlong/latlong.dart';

LatLng projection(LatLng coords,  double bearing, double distance, Ellipsoid ellipsoid) {
  return projectionRadian(coords, degToRadian(bearing), distance, ellipsoid);
}

LatLng projectionRadian(LatLng coords, double crs12, double d12, Ellipsoid ellipsoid) {
  return projectionVincenty(coords, crs12, d12, ellipsoid);
}
