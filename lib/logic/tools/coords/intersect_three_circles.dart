import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_two_circles.dart';
import 'package:latlong/latlong.dart';

//TODO: REFACTORING

class IntersectThreeCirclesJobData {
  final LatLng coord1;
  final double dist14;
  final LatLng coord2;
  final double dist24;
  final LatLng coord3;
  final double dist34;
  final double accuracy;
  final Ellipsoid ells;

  IntersectThreeCirclesJobData({
      this.coord1 = null,
      this.dist14 = 0.0,
      this.coord2 = null,
      this.dist24 = 0.0,
      this.coord3 = null,
      this.dist34 = 0.0,
      this.accuracy = 0.0,
      this.ells = null
  });
}

class Intersect {
  LatLng coords;
  double accuracy;

  Intersect({this.coords, this.accuracy});
}

List<Intersect> _distIntersection(LatLng coord1, double dist14,
    LatLng coord2, double dist24,
    LatLng coord3, double dist34,
    Ellipsoid ells) {

  List<LatLng> intersects = intersectTwoCircles(coord1, dist14, coord2, dist24, ells);

  if (intersects.isEmpty) {
    return [];
  }

  var distBear = distanceBearing(intersects[0], coord3, ells);

  var _output = [Intersect(
    coords: intersects[0],
    accuracy: (dist34 - distBear.distance).abs()
  )];

  if (intersects.length == 2) {
    distBear = distanceBearing(intersects[1], coord3, ells);

    _output.add(Intersect(
      coords: intersects[1],
      accuracy: (dist34 - distBear.distance).abs()
    ));
  }

  return _output;
}

void intersectThreeCirclesAsync(dynamic jobData) async {
  if (jobData == null) {
    jobData.sendAsyncPort.send(null);
    return;
  }

  var output = intersectThreeCircles(
      jobData.parameters.coord1,
      jobData.parameters.dist14,
      jobData.parameters.coord2,
      jobData.parameters.dist24,
      jobData.parameters.coord3,
      jobData.parameters.dist34,
      jobData.parameters.accuracy,
      jobData.parameters.ells
  );

  jobData.sendAsyncPort.send(output);
}

List<Intersect> intersectThreeCircles(LatLng coord1, double dist14,
    LatLng coord2, double dist24,
    LatLng coord3, double dist34,
    double accuracy, Ellipsoid ells) {

  List<Intersect> intersections = _distIntersection(coord1, dist14, coord2,dist24, coord3, dist34, ells);
  intersections.addAll(_distIntersection(coord1, dist14, coord3,dist34, coord2, dist24, ells));
  intersections.addAll(_distIntersection(coord2, dist24, coord3,dist34, coord1, dist14, ells));

  intersections.sort((a, b) {
    return a.accuracy.compareTo(b.accuracy);
  });

  return intersections;
}