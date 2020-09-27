import 'dart:math';

import 'package:gc_wizard/logic/units/unit.dart';

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

final ANGLE_GON = Angle(
  name: 'common_unit_angle_gon_name',
  symbol: 'gon',
  inDegree: 360.0 / 400.0
);

final ANGLE_MIL = Angle(
  name: 'common_unit_angle_mil_name',
  symbol: '\u00AF',
  inDegree: 360.0 / 6400.0
);

final ANGLE_NAUTICALLINE = Angle(
  name: 'common_unit_angle_nauticalline_name',
  symbol: '"',
  inDegree: 360.0 / 32.0
);

final List<Unit> angles = [
  ANGLE_DEGREE,
  ANGLE_RADIAN,
  ANGLE_GON,
  ANGLE_NAUTICALLINE,
  ANGLE_MIL,
];