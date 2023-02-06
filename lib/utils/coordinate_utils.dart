import 'package:latlong2/latlong.dart';

bool equalsLatLng(LatLng a, LatLng b) {
  final _tolerance = 1e-5;

  if ((a.latitude.abs() - 90.0) <= _tolerance &&
      (b.latitude.abs() - 90.0) <= _tolerance &&
      a.latitude.sign == b.latitude.sign) return true;

  if ((a.latitude - b.latitude).abs() <= _tolerance) {
    if ((a.longitude - b.longitude).abs() <= _tolerance) return true;

    if ((a.longitude.abs() - 180.0) <= _tolerance && (b.longitude.abs() - 180.0) <= _tolerance) return true;
  }

  return false;
}