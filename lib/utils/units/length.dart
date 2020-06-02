import 'package:gc_wizard/utils/units/unit.dart';

final LENGTH_M = 'm';
final LENGTH_KM = 'km';
final LENGTH_MI = 'mi';
final LENGTH_NM = 'nm';
final LENGTH_FT = 'ft';

class Length extends Unit {
  Length(
    String name,
    String symbol,
    bool isReference,
    double inMeters
  ): super(name, symbol, isReference, (e) => e * inMeters, (e) => e / inMeters);
}

final List<Unit> lengths = [
  Length('unit_length_m_name', LENGTH_M, true, 1.0),
  Length('unit_length_km_name', LENGTH_KM, false, 1000.0),
  Length('unit_length_mi_name', LENGTH_MI, false, 1609.344),
  Length('unit_length_nm_name', LENGTH_NM, false, 1852.0),
  Length('unit_length_ft_name', LENGTH_FT, false, 0.3048),
];

final defaultLength = getReferenceUnit(lengths) as Length;