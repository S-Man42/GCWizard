import 'package:gc_wizard/tools/coords/_common/logic/distance_bearing.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/_common/logic/external_libs/net.sf.geographic_lib/geographic_lib.dart';
import 'package:latlong2/latlong.dart';

DistanceBearingData distanceBearing(LatLng coords1, LatLng coords2, Ellipsoid ellipsoid) {
  RhumbInverseReturn data = Rhumb(ellipsoid.a, ellipsoid.f)
      .inverse(coords1.latitude, coords1.longitude, coords2.latitude, coords2.longitude);

  DistanceBearingData result = DistanceBearingData();
  result.distance = data.s12;
  result.bearingAToB = normalizeBearing(data.azi12);
  result.bearingBToA = normalizeBearing(data.azi12 + 180.0);

  return result;
}

LatLng projection(LatLng coord, double bearingDeg, double distance, Ellipsoid ellipsoid) {
  if (distance == 0.0) return coord;

  bearingDeg = normalizeBearing(bearingDeg);

  RhumbDirectReturn projected = Rhumb(ellipsoid.a, ellipsoid.f).direct(coord.latitude, coord.longitude, bearingDeg, distance);

  return LatLng(projected.lat2, projected.lon2);
}

LatLng _antipodes(LatLng coord) {
  var lat = coord.latitude;
  var lon = coord.longitude;
  lat *= -1;
  if (lon > 0) {
    lon += -180;
  } else {
    lon += 180;
  }

  return LatLng(lat, lon);
}

void main() {
  var ellipsoid = Ellipsoid.WGS84;

  // var coords1 = LatLng(40.6, -73.8);
  // var coords2 = LatLng(49.01666666666666666667, 2.55);
  // print(DateTime.now());
  // var db = distanceBearing(coords1, coords2, ellipsoid);
  // print(DateTime.now());
  // print(db.bearingAToB);
  // print(db.bearingBToA);
  // print(db.distance);
  //
  // print('======');
  //
  // var coord = LatLng(0, 0);
  // var bearingDeg = 270.0;
  // var distance = 20037508.0;
  // print(DateTime.now());
  // var pro = projection(coord, bearingDeg, distance, ellipsoid);
  // print(DateTime.now());
  // print(pro.latitude);
  // print(pro.longitude);

  var coords = [LatLng(-42, -173), LatLng(52, 13), LatLng(0,0), LatLng(90,0), LatLng(-90,-180)];
  // var coords = [LatLng(0,0)];
  for (LatLng coord in coords) {
    void _do(LatLng coords1, LatLng coords2) {
      print('');
      print('NEXT ==============');
      print(coords1);
      print(coords2);

      print('======');

      var db = distanceBearing(coords1, coords2, ellipsoid);
      print(db.bearingAToB);
      print(db.bearingBToA);
      print(db.distance);

      print('======');

      var pro = projection(coords1, db.bearingAToB, db.distance, ellipsoid);
      print(pro.latitude);
      print(pro.longitude);

      pro = projection(coords2, db.bearingBToA, db.distance, ellipsoid);
      print(pro.latitude);
      print(pro.longitude);
    }

    _do(coord, _antipodes(coord));
    // _do(coord, coord);
  }
}