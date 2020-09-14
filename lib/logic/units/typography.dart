import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/unit_category.dart';

class Typography extends Unit {
  Function toPt;
  Function fromPt;

  Typography({
    String name,
    String symbol,
    bool isReference: false,
    double inPt: 1.0,
  }): super(name, symbol, isReference, (e) => e * inPt, (e) => e / inPt) {
    toPt = this.toReference;
    fromPt = this.fromReference;
  }
}

final TYPOGRAPHY_POINT = Typography(
    name: 'common_unit_typography_pt_name',
    symbol: 'pt',
    isReference: true
);

final TYPOGRAPHY_SCALEDPOINT = Typography(
    name: 'common_unit_typography_sp_name',
    symbol: 'sp',
    inPt: 1.0 / 65536.0
);

final TYPOGRAPHY_BIGPOINT = Typography(
    name: 'common_unit_typography_bp_name',
    symbol: 'bp',
    inPt: 72.0 / 72.27
);

final TYPOGRAPHY_DIDOT = Typography(
    name: 'common_unit_typography_dd_name',
    symbol: 'dd',
    inPt: 1238.0 / 1157.0
);

final TYPOGRAPHY_CICERO = Typography(
    name: 'common_unit_typography_cc_name',
    symbol: 'cc',
    inPt: 12.0 * 1238.0 / 1157.0
);

final TYPOGRAPHY_PICA = Typography(
    name: 'common_unit_typography_pc_name',
    symbol: 'pc',
    inPt: 12.0
);


final List<Unit> typographies = [
  TYPOGRAPHY_POINT,
  TYPOGRAPHY_SCALEDPOINT,
  TYPOGRAPHY_BIGPOINT,
  TYPOGRAPHY_DIDOT,
  TYPOGRAPHY_CICERO,
  TYPOGRAPHY_PICA
];

