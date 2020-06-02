import 'package:gc_wizard/utils/units/unit.dart';

final TEMPERATURE_CELSIUS = String.fromCharCode(176) + 'C';
final TEMPERATURE_FAHRENHEIT = String.fromCharCode(176) + 'F';
final TEMPERATURE_KELVIN = 'K';

class Temperature extends Unit {
  Temperature(
    String name,
    String symbol,
    bool isReference,
    Function toKelvin,
    Function fromKelvin
  ): super(name, symbol, isReference, toKelvin, fromKelvin);
}

final List<Unit> temperatures = [
  Temperature('unit_temperature_k_name', TEMPERATURE_KELVIN, true, null, null),
  Temperature('unit_temperature_degc_name', TEMPERATURE_CELSIUS, false, (e) => e + 273.15, (e) => e - 273.15),
  Temperature('unit_temperature_degf_name', TEMPERATURE_FAHRENHEIT, false, (e) => (e + 459.67) * 5.0 / 9.0, (e) => e * 9.0 / 5.0 - 459.67),
];

final defaultTemperature = getReferenceUnit(temperatures) as Temperature;