import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/geoarc_intercept.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:latlong/latlong.dart';

List<LatLng> intersectGeodeticAndCircle(LatLng startGeodetic, double bearingGeodetic, LatLng centerPoint, double radiusCircle, Ellipsoid ells) {
  bearingGeodetic = degToRadian(bearingGeodetic);

  var help = distanceBearing(startGeodetic, centerPoint, ells);

   // If start point is in circle, move it out
  bool isInCircle = false;
  if (help.distance < radiusCircle) {
    isInCircle = true;
    LatLng pointOut = projectionRadian(startGeodetic, bearingGeodetic, radiusCircle * 2.1, ells);
    help = distanceBearing(startGeodetic, pointOut, ells);
    startGeodetic = pointOut;
    bearingGeodetic = help.bearingBToAInRadian;
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