import 'dart:math';

import 'package:gc_wizard/utils/units/unit.dart';

class Angle extends Unit {
  Function toDegree;
  Function fromDegree;

  Angle({
    String name,
    String symbol,
    bool isReference: false,
    double inDegree
  }): super(name, symbol, isReference, (e) => e * inDegree, (e) => e / inDegree) {
    toDegree = this.toReference;
    fromDegree = this.fromReference;
  }
}

final ANGLE_DEGREE = Angle(
  name: 'common_unit_angle_deg_name',
  symbol: '°',
  isReference: true,
);

final ANGLE_RADIAN = Angle(
  name: 'common_unit_angle_rad_name',
  symbol: 'rad',
  inDegree: 180.0 / pi
);

final List<Unit> angles = [
  ANGLE_DEGREE,
  ANGLE_RADIAN
];

final defaultAngle = ANGLE_DEGREE;