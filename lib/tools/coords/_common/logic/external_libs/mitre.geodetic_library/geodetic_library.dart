import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/logic/distance_and_bearing.dart';
import 'package:gc_wizard/tools/coords/waypoint_projection/logic/projection.dart';
import 'package:latlong2/latlong.dart';

part 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library/shape.dart';
part 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library/constants.dart';
part 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library/util.dart';
part 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library/projections.dart';
part 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library/llpoint.dart';
part 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library/vincenty_algorithms.dart';
part 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library/intersections.dart';
part 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library/arc.dart';

List<LatLng> geodesicArcIntercept(LatLng pt1, double crs1, LatLng center, double radius, Ellipsoid ellipsoid) {
  var out = <LatLng>[];

  var result = _geoArcIntx(LLPoint.fromLatLng(pt1), degToRadian(crs1), LLPoint.fromLatLng(center), radius, _TOL, ellipsoid);
  for (LLPoint pt in result) {
    out.add(pt.toLatLng());
  }

  return out;
}