import 'package:gc_wizard/logic/units/unit.dart';

class Energy extends Unit {
  Function toJoule;
  Function fromJoule;

  Energy({
    String name,
    String symbol,
    bool isReference: false,
    double inJoule
  }): super(name, symbol, isReference, (e) => e * inJoule, (e) => e / inJoule) {
    toJoule = this.toReference;
    fromJoule = this.fromReference;
  }
}

final ENERGY_JOULE = Energy(
  name: 'common_unit_energy_j_name',
  symbol: 'J',
  isReference: true,
);

final ENERGY_CALORIE = Energy(
  name: 'common_unit_energy_cal_name',
  symbol: 'cal',
  inJoule: 4.1868
);

final ENERGY_BRITISHTHERMALUNIT = Energy(
  name: 'common_unit_energy_btu_name',
  symbol: 'BTU',
  inJoule: 1055.05585262
);

final ENERGY_ERG = Energy(
  name: 'common_unit_energy_erg_name',
  symbol: 'erg',
  inJoule: 1e-7
);

final List<Unit> energies = [
  ENERGY_JOULE,
  ENERGY_CALORIE,
  ENERGY_BRITISHTHERMALUNIT,
  ENERGY_ERG
];

final defaultEnergy = ENERGY_JOULE;