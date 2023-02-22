import 'package:latlong/latlong.dart';

bool equalsLatLng(LatLng a, LatLng b) {
  return  (a.latitude - b.latitude).abs() <= 1e-5 && (a.longitude - b.longitude).abs() <= 1e-5;
}