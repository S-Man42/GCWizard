import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library.dart';
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
  List<LatLng> output = geodesicArcIntercept(startGeodetic, bearingGeodetic, centerPoint, radiusCircle, ells);

  return output;
}