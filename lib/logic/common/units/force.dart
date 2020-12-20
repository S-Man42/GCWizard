import 'package:gc_wizard/logic/common/units/unit.dart';

class Force extends Unit {
  Function toNewton;
  Function fromNewton;

  Force({
    String name,
    String symbol,
    bool isReference: false,
    double inNewton
  }): super(name, symbol, isReference, (e) => e * inNewton, (e) => e / inNewton) {
    toNewton = this.toReference;
    fromNewton = this.fromReference;
  }
}

final FORCE_NEWTON = Force(
  name: 'common_unit_force_n_name',
  symbol: 'N',
  isReference: true,
);

final FORCE_POUND = Force(
  name: 'common_unit_force_lbf_name',
  symbol: 'lbf',
  inNewton: 0.45359237 * 9.80665
);

final FORCE_POUNDAL = Force(
  name: 'common_unit_force_pdl_name',
  symbol: 'pdl',
  inNewton: 0.138254954376
);

final FORCE_POND = Force(
  name: 'common_unit_force_p_name',
  symbol: 'p',
  inNewton: 0.00980665
);

final FORCE_DYNE = Force(
  name: 'common_unit_force_dyn_name',
  symbol: 'dyn',
  inNewton: 1e-5
);

final List<Unit> forces = [
  FORCE_NEWTON,
  FORCE_POUND,
  FORCE_POUNDAL,
  FORCE_POND,
  FORCE_DYNE
];