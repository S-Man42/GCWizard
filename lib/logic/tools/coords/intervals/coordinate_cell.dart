import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:latlong/latlong.dart';

class Interval {
  final double a;
  final double b;

  Interval({this.a, this.b});

  bool equals(Interval i, {double accuracy: 0.0}) {
    return (i.a - a).abs() <= accuracy && (i.b - b).abs() <= accuracy;
  }

  @override
  String toString() {
    return '[a: $a; b: $b]';
  }
}

class CoordinateCell {
  Interval latInterval, lonInterval;
  Ellipsoid ellipsoid;

  CoordinateCell({this.latInterval, this.lonInterval, this.ellipsoid});

  @override
  String toString() {
    return '[LatMin: ${radianToDeg(latInterval.a)}, LatMax: ${radianToDeg(latInterval.b)}; LonMin: ${radianToDeg(lonInterval.a)}, LonMax: ${radianToDeg(lonInterval.b)}]';
  }

  LatLng get cellCenter {
    return LatLng(radianToDeg((latInterval.a + latInterval.b) / 2), radianToDeg((lonInterval.a + lonInterval.b) / 2));
  }

  double get maxHeight {
    return distanceBearing(LatLng(radianToDeg(latInterval.a), radianToDeg(lonInterval.a)),
            LatLng(radianToDeg(latInterval.b), radianToDeg(lonInterval.a)), ellipsoid)
        .distance;
  }

  double get maxWidth {
    var widthTop = distanceBearing(LatLng(radianToDeg(latInterval.a), radianToDeg(lonInterval.a)),
            LatLng(radianToDeg(latInterval.a), radianToDeg(lonInterval.b)), ellipsoid)
        .distance;
    var widthBottom = distanceBearing(LatLng(radianToDeg(latInterval.b), radianToDeg(lonInterval.a)),
            LatLng(radianToDeg(latInterval.b), radianToDeg(lonInterval.b)), ellipsoid)
        .distance;
    return max(widthTop, widthBottom);
  }

  //upper approximated bound for max radius (maximum distance from cell center(half width, half height) to corners or center of edges)
  double get approxMaxRadius {
    var distances = [];
    distances.add(distanceBearing(cellCenter, LatLng(radianToDeg(latInterval.a), radianToDeg(lonInterval.a)), ellipsoid)
        .distance);
    distances.add(distanceBearing(cellCenter, LatLng(radianToDeg(latInterval.a), radianToDeg(lonInterval.b)), ellipsoid)
        .distance);
    distances.add(distanceBearing(cellCenter, LatLng(radianToDeg(latInterval.b), radianToDeg(lonInterval.a)), ellipsoid)
        .distance);
    distances.add(distanceBearing(cellCenter, LatLng(radianToDeg(latInterval.a), radianToDeg(lonInterval.b)), ellipsoid)
        .distance);
    distances.add(distanceBearing(
            cellCenter, LatLng(radianToDeg((latInterval.a + latInterval.b) / 2), radianToDeg(lonInterval.a)), ellipsoid)
        .distance);
    distances.add(distanceBearing(
            cellCenter, LatLng(radianToDeg((latInterval.a + latInterval.b) / 2), radianToDeg(lonInterval.b)), ellipsoid)
        .distance);
    distances.add(distanceBearing(
            cellCenter, LatLng(radianToDeg(latInterval.a), radianToDeg((lonInterval.a + lonInterval.b) / 2)), ellipsoid)
        .distance);
    distances.add(distanceBearing(
            cellCenter, LatLng(radianToDeg(latInterval.b), radianToDeg((lonInterval.a + lonInterval.b) / 2)), ellipsoid)
        .distance);
    distances.sort();

    return distances[distances.length - 1];
  }

  //Calculates an approx. upper bound of the distance from point P to any point within the cell
  //That means: All points of a cell are within a circle around the cell's center point M
  //with a radius, which is the approx. max distance to any point on the cell edges
  //--> The distances to P is the interval of distance(P, M) +- the radius.
  Interval distanceTo(LatLng point) {
    //distance from point P to the cell center
    double distanceToCellCenter = distanceBearing(point, cellCenter, ellipsoid).distance;

    return Interval(a: distanceToCellCenter - approxMaxRadius, b: distanceToCellCenter + approxMaxRadius);
  }

  //Calculates a range of bearings any point within the cell to a point P
  //That means: The bearing from each cell corner to P is calculated. This is the basis
  //to get a range, which has to be interpreted clockwise.
  // Important: The range from 350° to 10° != range from 10° to 350°.
  // Ranges are not normalized, so the range [350, 10] in fact will be [350, 370]
  // If P is in the cell, than the resulting range is [0, 360]
  Interval bearingTo(LatLng point) {
    //if point is in cell
    if (point.latitudeInRad > latInterval.a &&
        point.latitudeInRad < latInterval.b &&
        point.longitudeInRad > lonInterval.a &&
        point.longitudeInRad < lonInterval.b) return Interval(a: 0.0, b: 360.0);

    var cornerAA = LatLng(radianToDeg(latInterval.a), radianToDeg(lonInterval.a));
    var cornerAB = LatLng(radianToDeg(latInterval.a), radianToDeg(lonInterval.b));
    var cornerBA = LatLng(radianToDeg(latInterval.b), radianToDeg(lonInterval.a));
    var cornerBB = LatLng(radianToDeg(latInterval.b), radianToDeg(lonInterval.b));

    var bearings = [];

    if (point != cornerAA) bearings.add(distanceBearing(point, cornerAA, ellipsoid).bearingBToA);
    if (point != cornerAB) bearings.add(distanceBearing(point, cornerAB, ellipsoid).bearingBToA);
    if (point != cornerBA) bearings.add(distanceBearing(point, cornerBA, ellipsoid).bearingBToA);
    if (point != cornerBB) bearings.add(distanceBearing(point, cornerBB, ellipsoid).bearingBToA);

    var maxAngle = 0.0;
    var lower;
    var upper;

    //Finding the right thresholds of the bounds, to define whether the bearing range
    //is [350,10] or [10,350]
    // The idea is: Usually it is not possible to find an angle > 180° between
    // an outside P to any two cell corners (in fact, this is only a nearing,
    // because of the ellipsoid shape, in some special cases this could be, nevertheless...)
    for (double bearingA in bearings) {
      for (double bearingB in bearings) {
        if (bearingA == bearingB) continue;

        var angle = bearingA - bearingB;
        var normalizedAngle = normalizeBearing(angle);

        if (normalizedAngle <= 180.0 && normalizedAngle > maxAngle) {
          maxAngle = normalizedAngle;
          lower = min(bearingA, bearingB);
          upper = max(bearingA, bearingB);
        }
      }
    }

    // Create the unnormalized bearings: [350, 10] -> [350, 370]
    for (double bearing in bearings) {
      if (bearing < lower || bearing > upper) return Interval(a: upper, b: lower + 360.0);
    }

    return Interval(a: lower, b: upper);
  }
}
