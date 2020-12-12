final UNITPREFIX_EXA = UnitPrefix('common_unit_prefix_exa', 'E', 1.0e18);
final UNITPREFIX_PETA = UnitPrefix('common_unit_prefix_peta', 'P', 1.0e15);
final UNITPREFIX_TERA = UnitPrefix('common_unit_prefix_tera', 'T', 1.0e12);
final UNITPREFIX_GIGA = UnitPrefix('common_unit_prefix_giga', 'G', 1.0e9);
final UNITPREFIX_MEGA = UnitPrefix('common_unit_prefix_mega', 'M', 1.0e6);
final UNITPREFIX_KILO = UnitPrefix('common_unit_prefix_kilo', 'k', 1.0e3);
final UNITPREFIX_HECTO = UnitPrefix('common_unit_prefix_hecto', 'h', 1.0e2);
final UNITPREFIX_DECA = UnitPrefix('common_unit_prefix_deca', 'da', 1.0e1);
final UNITPREFIX_NONE = UnitPrefix(null, null, 1.0);
final UNITPREFIX_DECI = UnitPrefix('common_unit_prefix_deci', 'd', 1.0e-1);
final UNITPREFIX_CENTI = UnitPrefix('common_unit_prefix_centi', 'c', 1.0e-2);
final UNITPREFIX_MILLI = UnitPrefix('common_unit_prefix_milli', 'm', 1.0e-3);
final UNITPREFIX_MICRO = UnitPrefix('common_unit_prefix_micro', '\u00B5', 1.0e-6);
final UNITPREFIX_NANO = UnitPrefix('common_unit_prefix_nano', 'n', 1.0e-9);
final UNITPREFIX_PICO = UnitPrefix('common_unit_prefix_pico', 'p', 1.0e-12);
final UNITPREFIX_FEMTO = UnitPrefix('common_unit_prefix_femto', 'f', 1.0e-15);
final UNITPREFIX_ATTO = UnitPrefix('common_unit_prefix_atto', 'a', 1.0e-18);

final unitPrefixes = [
  UNITPREFIX_EXA,
  UNITPREFIX_PETA,
  UNITPREFIX_TERA,
  UNITPREFIX_GIGA,
  UNITPREFIX_MEGA,
  UNITPREFIX_KILO,
  UNITPREFIX_HECTO,
  UNITPREFIX_DECA,
  UNITPREFIX_NONE,
  UNITPREFIX_DECI,
  UNITPREFIX_CENTI,
  UNITPREFIX_MILLI,
  UNITPREFIX_MICRO,
  UNITPREFIX_NANO,
  UNITPREFIX_PICO,
  UNITPREFIX_FEMTO,
  UNITPREFIX_ATTO
];

class UnitPrefix {
  String key;
  String symbol;
  double value;

  UnitPrefix(this.key, this.symbol, this.value);
}