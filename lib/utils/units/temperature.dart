import 'package:gc_wizard/utils/units/unit.dart';

class Temperature extends Unit {
  final Function toKelvin;
  final Function fromKelvin;

  Temperature({
    String name,
    String symbol,
    bool isReference: false,
    this.toKelvin,
    this.fromKelvin
  }): super(name, symbol, isReference, toKelvin, fromKelvin);
}

final TEMPERATURE_KELVIN = Temperature(
  name: 'common_unit_temperature_k_name',
  symbol: 'K',
  isReference: true
);

final TEMPERATURE_CELSIUS = Temperature(
  name: 'common_unit_temperature_degc_name',
  symbol: String.fromCharCode(176) + 'C',
  toKelvin: (e) => e + 273.15,
  fromKelvin: (e) => e - 273.15
);

final TEMPERATURE_FAHRENHEIT = Temperature(
  name: 'common_unit_temperature_degf_name',
  symbol: String.fromCharCode(176) + 'F',
  toKelvin: (e) => (e + 459.67) * 5.0 / 9.0,
  fromKelvin: (e) => e * 9.0 / 5.0 - 459.67
);

final TEMPERATURE_REAUMUR = Temperature(
    name: 'common_unit_temperature_degr_name',
    symbol: String.fromCharCode(176) + 'R',
    toKelvin: (e) => e * 1.25 + 273.15,
    fromKelvin: (e) => (e - 273.15) * 0.8
);

final TEMPERATURE_RANKINE = Temperature(
    name: 'common_unit_temperature_degra_name',
    symbol: String.fromCharCode(176) + 'Ra',
    toKelvin: (e) => e * 5.0 / 9.0,
    fromKelvin: (e) => e * 9.0 / 5.0
);

final List<Unit> temperatures = [
  TEMPERATURE_KELVIN,
  TEMPERATURE_CELSIUS,
  TEMPERATURE_FAHRENHEIT,
  TEMPERATURE_REAUMUR,
  TEMPERATURE_RANKINE
];

final defaultTemperature = TEMPERATURE_KELVIN;