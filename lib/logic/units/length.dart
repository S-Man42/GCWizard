import 'dart:math';

import 'package:gc_wizard/logic/units/unit.dart';

class Length extends Unit {
  Function toMeter;
  Function fromMeter;

  Length({
    String name,
    String symbol,
    bool isReference: false,
    double inMeters: 1.0,
  }): super(name, symbol, isReference, (e) => e * inMeters, (e) => e / inMeters) {
    toMeter = this.toReference;
    fromMeter = this.fromReference;
  }
}

final LENGTH_M = Length(
  name: 'common_unit_length_m_name',
  symbol: 'm',
  isReference: true
);

final LENGTH_MI = Length(
  name: 'common_unit_length_mi_name',
  symbol: 'mi',
  inMeters: 1609.344
);

final LENGTH_NM = Length(
  name: 'common_unit_length_nm_name',
  symbol: 'nm',
  inMeters: 1852.0
);

final LENGTH_IN = Length(
  name: 'common_unit_length_in_name',
  symbol: 'in',
  inMeters: 0.3048 / 12.0
);

final LENGTH_FT = Length(
  name: 'common_unit_length_ft_name',
  symbol: 'ft',
  inMeters: 0.3048
);

final LENGTH_YD = Length(
  name: 'common_unit_length_yd_name',
  symbol: 'yd',
  inMeters: 3 * 0.3048
);

final LENGTH_USSURVEYFT = Length(
  name: 'common_unit_length_ussurveyft_name',
  symbol: 'ft',
  inMeters: 1200.0 / 3937.0
);

final LENGTH_LY = Length(
  name: 'common_unit_length_ly_name',
  symbol: 'ly',
  inMeters: 9460730472580800.0
);

final LENGTH_AU = Length(
  name: 'common_unit_length_au_name',
  symbol: 'AU',
  inMeters: 149597870700.0
);

final LENGTH_PC= Length(
    name: 'common_unit_length_pc_name',
    symbol: 'pc',
    inMeters: 96939420213600000.0 / pi
);

final List<Unit> lengths = [
  LENGTH_M,
  LENGTH_MI,
  LENGTH_IN,
  LENGTH_FT,
  LENGTH_YD,
  LENGTH_USSURVEYFT,
  LENGTH_NM,
  LENGTH_LY,
  LENGTH_AU,
  LENGTH_PC
];

final defaultLength = LENGTH_M;