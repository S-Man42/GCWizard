import 'package:gc_wizard/utils/data_type_utils/double_type_utils.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:latlong2/latlong.dart';

bool equalsLatLng(LatLng a, LatLng b, {double tolerance = 1e-10}) {
  if (doubleEquals(a.latitude.abs(), 90.0) && doubleEquals(b.latitude.abs(), 90.0) && a.latitude.sign == b.latitude.sign) {
    return true;
  }

  if ((a.latitude - b.latitude).abs() <= tolerance) {
    if (doubleEquals(a.longitude.abs(), 180.0) && doubleEquals(b.longitude.abs(), 180.0)) return true;

    if ((a.longitude - b.longitude).abs() <= tolerance) return true;

    if ((180.0 - a.longitude.abs()) <= tolerance && (180.0 - b.longitude.abs()) <= tolerance) return true;
  }

  return false;
}

double normalizeBearing(double bearing) {
  return modulo360(bearing).toDouble();
}

double normalizeLat(double lat) {
  while (lat > 90.0 || lat < -90) {
    if (lat > 90.0) {
      lat = 180.0 - lat;
    } else {
      lat = -180.0 + -lat;
    }

    lat += 180.0;
  }

  return lat;
}

double normalizeLon(double lon) {
  if (lon > 180.0) return normalizeLon(lon - 360.0);
  if (lon < -180.0) return normalizeLon(360.0 + lon);

  return lon;
}

bool equalsBearing(double a, double b, {double tolerance = 1e-10}) {
  a = normalizeBearing(a);
  b = normalizeBearing(b);

  if (doubleEquals(a, b, tolerance: tolerance)) {
    return true;
  }

  if (360.0 - a <= tolerance && b <= tolerance) {
    return 360.0 - a + b <= tolerance;
  }

  if (360.0 - b <= tolerance && a <= tolerance) {
    return 360.0 - b + a <= tolerance;
  }

  return false;
}