import 'package:gc_wizard/utils/math_utils.dart';
import 'package:latlong2/latlong.dart';

bool equalsLatLng(LatLng a, LatLng b) {
  final _tolerance = 1e-10;

  if ((a.latitude - b.latitude).abs() <= _tolerance) {
    if ((a.longitude - b.longitude).abs() <= _tolerance) return true;

    if ((180.0 - a.longitude.abs()) <= _tolerance && (180.0 - b.longitude.abs()) <= _tolerance) return true;
  }

  return false;
}

double normalizeBearing(double bearing) {
  return modulo360(bearing).toDouble();
}