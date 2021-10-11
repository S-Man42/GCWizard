import 'dart:math';

import 'package:gc_wizard/logic/common/units/unit.dart';

class Length extends Unit {
  Function toMeter;
  Function fromMeter;

  Length({
    String name,
    String symbol,
    bool isReference: false,
    double inMeters: 1.0,
  }) : super(name, symbol, isReference, (e) => e * inMeters, (e) => e / inMeters) {
    toMeter = this.toReference;
    fromMeter = this.fromReference;
  }
}

final LENGTH_METER = Length(name: 'common_unit_length_m_name', symbol: 'm', isReference: true);

final LENGTH_STATUTEMILE = Length(name: 'common_unit_length_mi_name', symbol: 'mi', inMeters: 1609.344);

final LENGTH_NAUTICALMILE = Length(name: 'common_unit_length_nm_name', symbol: 'nm', inMeters: 1852.0);

final LENGTH_INCH = Length(name: 'common_unit_length_in_name', symbol: 'in', inMeters: 0.3048 / 12.0);

final LENGTH_FOOT = Length(name: 'common_unit_length_ft_name', symbol: 'ft', inMeters: 0.3048);

final LENGTH_YARD = Length(name: 'common_unit_length_yd_name', symbol: 'yd', inMeters: 3 * 0.3048);

final LENGTH_USSURVEYFOOT = Length(name: 'common_unit_length_ussurveyft_name', symbol: 'ft', inMeters: 1200.0 / 3937.0);

final LENGTH_LIGHTYEAR = Length(name: 'common_unit_length_ly_name', symbol: 'ly', inMeters: 9460730472580800.0);

final LENGTH_ASTRONOMICALUNIT = Length(name: 'common_unit_length_au_name', symbol: 'AU', inMeters: 149597870700.0);

final LENGTH_PARSEC = Length(name: 'common_unit_length_pc_name', symbol: 'pc', inMeters: 96939420213600000.0 / pi);

final LENGTH_LAR = Length(name: 'common_unit_length_lar_name', symbol: 'lar', inMeters: 4827);

final LENGTH_RANGAR = Length(name: 'common_unit_length_rangar_name', symbol: 'rangar', inMeters: 4827 / 5000);

final LENGTH_FATHOM = Length(name: 'common_unit_length_fathom_name', symbol: 'fm', inMeters: 1.8288);

final LENGTH_FURLONG = Length(name: 'common_unit_length_furlong_name', symbol: 'fur', inMeters: 201.168);

final LENGTH_CHAIN = Length(name: 'common_unit_length_chain_name', symbol: 'ch', inMeters: 20.1168);

final LENGTH_ROD = Length(name: 'common_unit_length_rod_name', symbol: 'rd', inMeters: 5.0292);

final LENGTH_LINK = Length(name: 'common_unit_length_link_name', symbol: 'li', inMeters: 0.201168);

final List<Unit> baseLengths = [
  LENGTH_METER,
  LENGTH_STATUTEMILE,
  LENGTH_INCH,
  LENGTH_FOOT,
  LENGTH_YARD,
  LENGTH_FATHOM,
  LENGTH_FURLONG,
  LENGTH_CHAIN,
  LENGTH_ROD,
  LENGTH_LINK,
  LENGTH_USSURVEYFOOT,
  LENGTH_NAUTICALMILE,
  LENGTH_LIGHTYEAR,
  LENGTH_ASTRONOMICALUNIT,
  LENGTH_PARSEC,
  LENGTH_LAR,
  LENGTH_RANGAR
];

final LENGTH_KM = Length(name: 'common_unit_length_km_name', symbol: 'km', inMeters: 1000.0);
final LENGTH_CM = Length(name: 'common_unit_length_cm_name', symbol: 'cm', inMeters: 0.01);

List<Unit> allLengths() {
  var lengths = List<Unit>.from(baseLengths);
  var indexM = baseLengths.indexOf(LENGTH_METER);
  lengths.insert(indexM + 1, LENGTH_KM);
  lengths.insert(indexM + 2, LENGTH_CM);

  return lengths;
}
