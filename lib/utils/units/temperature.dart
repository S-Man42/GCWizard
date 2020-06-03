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
  name: 'unit_temperature_k_name',
  symbol: 'K',
  isReference: true
);

final TEMPERATURE_CELSIUS = Temperature(
  name: 'unit_temperature_degc_name',
  symbol: String.fromCharCode(176) + 'C',
  toKelvin: (e) => e + 273.15,
  fromKelvin: (e) => e - 273.15
);

final TEMPERATURE_FAHRENHEIT = Temperature(
  name: 'unit_temperature_degf_name',
  symbol: String.fromCharCode(176) + 'F',
  toKelvin: (e) => (e + 459.67) * 5.0 / 9.0,
  fromKelvin: (e) => e * 9.0 / 5.0 - 459.67
);

final List<Unit> temperatures = [
  TEMPERATURE_KELVIN,
  TEMPERATURE_CELSIUS,
  TEMPERATURE_FAHRENHEIT
];

final defaultTemperature = TEMPERATURE_KELVIN;