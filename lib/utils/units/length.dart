import 'package:gc_wizard/utils/units/unit.dart';

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
  name: 'unit_length_m_name',
  symbol: 'm',
  isReference: true
);

final LENGTH_KM = Length(
  name: 'unit_length_km_name',
  symbol: 'km',
  inMeters: 1000.0
);

final LENGTH_MI = Length(
  name: 'unit_length_mi_name',
  symbol: 'mi',
  inMeters: 1609.344
);

final LENGTH_NM = Length(
  name: 'unit_length_nm_name',
  symbol: 'nm',
  inMeters: 1852.0
);

final LENGTH_FT = Length(
  name: 'unit_length_ft_name',
  symbol: 'ft',
  inMeters: 0.3048
);

final List<Unit> lengths = [
  LENGTH_M,
  LENGTH_KM,
  LENGTH_MI,
  LENGTH_NM,
  LENGTH_FT
];

final defaultLength = LENGTH_M;