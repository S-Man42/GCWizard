import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/intervals/coordinate_cell.dart';
import 'package:gc_wizard/logic/tools/coords/intervals/interval_calculator.dart';
import 'package:gc_wizard/logic/tools/coords/vincenty/projection_vincenty.dart';
import 'package:latlong/latlong.dart';

LatLng projection(LatLng coord, double bearing, double distance, Ellipsoid ellipsoid) {
  return projectionRadian(coord, degToRadian(bearing), distance, ellipsoid);
}

LatLng projectionRadian(LatLng coord, double bearing, double distance, Ellipsoid ellipsoid) {
  if (distance == 0.0)
    return coord;

  return projectionVincenty(coord, bearing, distance, ellipsoid);
}

class _ReverseProjectionCalculator extends IntervalCalculator {

  _ReverseProjectionCalculator(Map<String, dynamic> parameters, Ellipsoid ells)
      : super(parameters, ells) {
    eps = 1e-9;
  }

  @override
  bool checkCell(CoordinateCell cell, Map<String, dynamic> parameters) {
    Interval distanceToCoord = cell.distanceTo(parameters['coord']);
    Interval bearingToCoord = cell.bearingTo(parameters['coord']);

    var distance = parameters['distance'];
    var bearing = parameters['bearing'];

    return (distanceToCoord.a <= distance) && (distance <= distanceToCoord.b) &&
      (
          (bearingToCoord.a <= bearing) && (bearing <= bearingToCoord.b)
          || (bearingToCoord.a <= bearing + 360.0) && (bearing + 360.0 <= bearingToCoord.b)
      );
  }
}

List<LatLng> reverseProjection(LatLng coord, double bearing, double distance, Ellipsoid ellipsoid) {
  return _ReverseProjectionCalculator({'coord': coord, 'bearing': bearing, 'distance': distance}, ellipsoid).check();
}