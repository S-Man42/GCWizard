import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/_common/logic/external_libs/pkohut.geoformulas/geoformulas.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/logic/distance_and_bearing.dart';
import 'package:gc_wizard/tools/coords/waypoint_projection/logic/projection.dart';
import 'package:latlong2/latlong.dart';

class IntersectGeodeticAndCircleJobData {
  final LatLng startGeodetic;
  final double bearingGeodetic;
  final LatLng centerPoint;
  final double radiusCircle;
  final Ellipsoid ells;

  IntersectGeodeticAndCircleJobData(
      {required this.startGeodetic,
      this.bearingGeodetic = 0.0,
      required this.centerPoint,
      this.radiusCircle = 0.0,
      required this.ells});
}

Future<List<LatLng>> intersectGeodeticAndCircleAsync(dynamic jobData) async {
  if (jobData?.parameters is! IntersectGeodeticAndCircleJobData) {
    throw Exception('Unexpected data for Intersection Geodetic and Circle');
  }

  var data = jobData!.parameters as IntersectGeodeticAndCircleJobData;

  var output = intersectGeodeticAndCircle(
      data.startGeodetic, data.bearingGeodetic, data.centerPoint, data.radiusCircle, data.ells);

  jobData.sendAsyncPort?.send(output);

  return output;
}

List<LatLng> intersectGeodeticAndCircle(
    LatLng startGeodetic, double bearingGeodetic, LatLng centerPoint, double radiusCircle, Ellipsoid ells) {
  bearingGeodetic = normalizeBearing(bearingGeodetic);

  var help = distanceBearing(startGeodetic, centerPoint, ells);

  // If start point is in circle, move it out
  bool isInCircle = false;
  if (help.distance < radiusCircle) {
    isInCircle = true;
    LatLng pointOut = projection(startGeodetic, bearingGeodetic, radiusCircle * 2.1, ells);
    help = distanceBearing(startGeodetic, pointOut, ells);
    startGeodetic = pointOut;
    bearingGeodetic = help.bearingBToA;
  }

  List<LatLng> output = geodesicArcIntercept(startGeodetic, bearingGeodetic, centerPoint, radiusCircle, ells);

  if (isInCircle) {
    help = distanceBearing(startGeodetic, output[0], ells);
    if (help.distance > radiusCircle * 2.1) {
      output[0] = output[1];
    }

    output.removeLast();
  }

  return output;
}

void main() {
  // var lat1 = 35.8801275809;
  // var lon1 = -024.3479101592;
  // var rad1 = 1100000.0;
  //
  // var lata = 33.633672083;
  // var lona = -041.8190530822;
  // var latb = 44.7377569269;
  // var lonb = -008.7872823648;

  var lat1 = 39.7252664957;
  var lon1 = 1.4551465029;
  var rad1 = 4100000.0;

  var lata = 17.4602726873;
  var lona = -46.2007042135;
  var latb = -0.1499488259;
  var lonb = 122.575110254;

  var distBear = distanceBearing(LatLng(lata, lona), LatLng(latb, lonb), Ellipsoid.WGS84);
  print(distBear);

  var ret = intersectGeodeticAndCircle(
      LatLng(lata, lonb), distBear.bearingAToB, LatLng(lat1, lon1), rad1, Ellipsoid.WGS84);

  print(ret);
  for (var x in ret) {
    print(x.latitude);
    print(x.longitude);
    print('     ');
  }
}