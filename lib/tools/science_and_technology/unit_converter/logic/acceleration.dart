import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';

class Acceleration extends Unit {
  late double Function (double) toMeterPerSquareSecondes;
  late double Function (double) fromMeterPerSquareSecondes;

  Acceleration({
    required String name,
    required String symbol,
    bool isReference = false,
    required double inMeterPerSquereSecond,
  }) : super(name, symbol, isReference, (e) => e * inMeterPerSquereSecond, (e) => e / inMeterPerSquereSecond) {
    toMeterPerSquareSecondes = toReference;
    fromMeterPerSquareSecondes = fromReference;
  }
}

final ACCELERATION_METERPERSQUARESECOND = Acceleration(name: 'common_unit_acceleration_ms2_name', symbol: 'm/s\u00B2', inMeterPerSquereSecond: 1.0, isReference: true);

final ACCELERATION_CENTIMETERPERSQUARESECOND =
Acceleration(name: 'common_unit_acceleration_cms2_name', symbol: 'cm/s\u00B2', inMeterPerSquereSecond: 0.01);



final List<Acceleration> accelerations = [
  ACCELERATION_METERPERSQUARESECOND,
  ACCELERATION_CENTIMETERPERSQUARESECOND,
];