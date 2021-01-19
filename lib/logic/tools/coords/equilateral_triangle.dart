import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_two_circles.dart';
import 'package:latlong/latlong.dart';

class EquilateralTriangleJobData {
  final LatLng coord1;
  final LatLng coord2;
  final Ellipsoid ells;

  EquilateralTriangleJobData({
      this.coord1 = null,
      this.coord2 = null,
      this.ells = null
  });
}

void equilateralTriangleAsync(dynamic jobData) async {
  if (jobData == null) {
    jobData.sendAsyncPort.send(null);
    return;
  }

  var output = equilateralTriangle(
      jobData.parameters.coord1,
      jobData.parameters.coord2,
      jobData.parameters.ells
  );

  jobData.sendAsyncPort.send(output);
}

List<LatLng> equilateralTriangle(LatLng coord1, LatLng coord2, Ellipsoid ells) {
  var distance = distanceBearing(coord1, coord2, ells).distance;

  return intersectTwoCircles(coord1, distance, coord2, distance, ells);
}