import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/intervals/coordinate_cell.dart';
import 'package:gc_wizard/logic/tools/coords/intervals/interval_calculator.dart';
import 'package:latlong/latlong.dart';

class _IntersectTwoCirclesCalculator extends IntervalCalculator {

  _IntersectTwoCirclesCalculator(Map<String, dynamic> parameters, Ellipsoid ells) : super(parameters, ells);

  @override
  bool checkCell(CoordinateCell cell, Map<String, dynamic> parameters) {
    Interval distanceToCoord1 = cell.distanceTo(parameters['coord1']);
    Interval distanceToCoord2 = cell.distanceTo(parameters['coord2']);

    var r1 = parameters['radius1'];
    var r2 = parameters['radius2'];

    return (distanceToCoord1.a <= r1) && (r1 <= distanceToCoord1.b) && (distanceToCoord2.a <= r2) && (r2 <= distanceToCoord2.b);
  }
}

List<LatLng> intersectTwoCircles(LatLng coord1, double radius1, LatLng coord2, double radius2, Ellipsoid ells) {
  return _IntersectTwoCirclesCalculator({'coord1': coord1, 'radius1': radius1, 'coord2': coord2, 'radius2': radius2}, ells).check();
}