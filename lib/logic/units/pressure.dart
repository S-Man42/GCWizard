import 'package:gc_wizard/logic/units/unit.dart';

class Pressure extends Unit {
  Function toPascal;
  Function fromPascal;

  Pressure({
    String name,
    String symbol,
    bool isReference: false,
    double inPascal
  }): super(name, symbol, isReference, (e) => e * inPascal, (e) => e / inPascal) {
    toPascal = this.toReference;
    fromPascal = this.fromReference;
  }
}

final PRESSURE_PASCAL = Pressure(
  name: 'common_unit_pressure_pa_name',
  symbol: 'Pa',
  isReference: true,
);

final PRESSURE_BAR = Pressure(
  name: 'common_unit_pressure_bar_name',
  symbol: 'bar',
  inPascal: 100000.0
);

final PRESSURE_POUNDSPERSQUAREINCH = Pressure(
  name: 'common_unit_pressure_psi_name',
  symbol: 'psi, lbf/in\u00B2',
  inPascal: 6894.75729
);

final PRESSURE_ATMOSPHERE = Pressure(
  name: 'common_unit_pressure_atm_name',
  symbol: 'atm',
  inPascal: 101325.0
);

final PRESSURE_TECHNICALATMOSPHERE = Pressure(
  name: 'common_unit_pressure_at_name',
  symbol: 'at',
  inPascal: 98066.5
);

final PRESSURE_MILLIMETEROFMERCURY = Pressure(
  name: 'common_unit_pressure_mmhg_name',
  symbol: 'mmHg',
  inPascal: 133.322387415
);

final PRESSURE_INCHOFMERCURY = Pressure(
  name: 'common_unit_pressure_inhg_name',
  symbol: 'inHg',
  inPascal: 3386.39
);

final PRESSURE_TORR = Pressure(
  name: 'common_unit_pressure_torr_name',
  symbol: 'Torr',
  inPascal: 101325.0 / 760.0
);

final List<Unit> pressures = [
  PRESSURE_PASCAL,
  PRESSURE_BAR,
  PRESSURE_POUNDSPERSQUAREINCH,
  PRESSURE_ATMOSPHERE,
  PRESSURE_TECHNICALATMOSPHERE,
  PRESSURE_MILLIMETEROFMERCURY,
  PRESSURE_INCHOFMERCURY,
  PRESSURE_TORR
];

final defaultPressure = PRESSURE_PASCAL;