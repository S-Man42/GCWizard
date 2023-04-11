import 'package:gc_wizard/utils/math_utils.dart';
import 'package:latlong2/latlong.dart';

bool equalsLatLng(LatLng a, LatLng b, {double tolerance = 1e-10}) {
  if ((a.latitude - b.latitude).abs() <= tolerance) {
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