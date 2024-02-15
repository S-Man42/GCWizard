import 'package:gc_wizard/tools/coords/_common/logic/distance_bearing.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/_common/logic/external_libs/net.sf.geographic_lib/geographic_lib.dart';
import 'package:latlong2/latlong.dart';

bool _isNearPole(double lat) {
  return lat.abs() > 90 - 1e-5;
}

DistanceBearingData distanceBearing(LatLng coords1, LatLng coords2, Ellipsoid ellipsoid) {
  RhumbInverseReturn data = Rhumb(ellipsoid.a, ellipsoid.f)
      .inverse(coords1.latitude, coords1.longitude, coords2.latitude, coords2.longitude);

  var distance = data.s12;
  var bearing = data.azi12;

  if (distance == 0.0 || (_isNearPole(coords1.latitude) && _isNearPole(coords2.latitude))) {
    if (bearing.isNaN) {
      bearing = 0.0;
    }
  }

  DistanceBearingData result = DistanceBearingData();
  result.distance = distance;
  result.bearingAToB = normalizeBearing(bearing);
  result.bearingBToA = normalizeBearing(bearing + 180.0);

  return result;
}

LatLng projection(LatLng coord, double bearingDeg, double distance, Ellipsoid ellipsoid) {
  if (distance == 0.0) return coord;

  bearingDeg = normalizeBearing(bearingDeg);

  RhumbDirectReturn projected = Rhumb(ellipsoid.a, ellipsoid.f).direct(coord.latitude, coord.longitude, bearingDeg, distance);

  var lat = projected.lat2;
  var lon = projected.lon2;
  if (_isNearPole(lat) && lon.isNaN) {
    lon = 0.0;
  }

  return LatLng(lat, lon);
}

// LatLng _antipodes(LatLng coord) {
//   var lat = coord.latitude;
//   var lon = coord.longitude;
//   lat *= -1;
//   if (lon > 0) {
//     lon += -180;
//   } else {
//     lon += 180;
//   }
//
//   return LatLng(lat, lon);
// }
//
// void main() {
//   var ellipsoid = Ellipsoid.WGS84;
//
//   // var coords2 = LatLng(53, 12);
//   // var coords1 = LatLng(52, 13);
//   // print(DateTime.now());
//   // var db = distanceBearing(coords1, coords2, ellipsoid);
//   // print(DateTime.now());
//   // print(db.bearingAToB);
//   // print(db.bearingBToA);
//   // print(db.distance);
//   //
//   // print('======');
//   //
//   // var coord = LatLng(0, 0);
//   // var bearingDeg = 270.0;
//   // var distance = 20037508.0;
//   // print(DateTime.now());
//   // var pro = projection(coord, bearingDeg, distance, ellipsoid);
//   // print(DateTime.now());
//   // print(pro.latitude);
//   // print(pro.longitude);
//
//   var coords = [LatLng(-42, -173), LatLng(52, 13), LatLng(0,0), LatLng(90,0), LatLng(-90,-180)];
//   // var coords = [LatLng(52,13)];
//   for (LatLng coord in coords) {
//     void _do(LatLng coords1, LatLng coords2) {
//       print('');
//       print('NEXT ==============');
//       print(coords1);
//       print(coords2);
//
//       print('======');
//
//       var db = distanceBearing(coords1, coords2, ellipsoid);
//       print(db.bearingAToB);
//       print(db.bearingBToA);
//       print(db.distance);
//
//       print('======');
//
//       var pro = projection(coords1, db.bearingAToB, db.distance, ellipsoid);
//       print(pro.latitude);
//       print(pro.longitude);
//
//       pro = projection(coords2, db.bearingBToA, db.distance, ellipsoid);
//       print(pro.latitude);
//       print(pro.longitude);
//     }
//
//     _do(coord, _antipodes(coord));
//     _do(coord, coord);
//   }
// }