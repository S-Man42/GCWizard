// https://en.wikipedia.org/wiki/Wet-bulb_temperature
// https://de.wikipedia.org/wiki/K%C3%BChlgrenztemperatur
// https://climate-preparedness.com/understanding-wet-bulb-temperature-and-why-it-is-so-dangerous/
// https://www.omnicalculator.com/physics/wet-bulb

import 'dart:math';

import 'package:gc_wizard/logic/common/units/temperature.dart';

enum HEATSTRESS_CONDITION {WHITE, GREEN, YELLOW, RED, BLACK}

final Map<String, Map<HEATSTRESS_CONDITION, double>> HEAT_STRESS = {
  TEMPERATURE_CELSIUS.symbol : {
    HEATSTRESS_CONDITION.WHITE : 24.9,
    HEATSTRESS_CONDITION.GREEN : 25.0,
    HEATSTRESS_CONDITION.YELLOW: 29.4,
    HEATSTRESS_CONDITION.RED: 31.6,
  },
  TEMPERATURE_FAHRENHEIT.symbol : {
    HEATSTRESS_CONDITION.WHITE : 76.9,
    HEATSTRESS_CONDITION.GREEN : 81.9,
    HEATSTRESS_CONDITION.YELLOW : 84.9,
    HEATSTRESS_CONDITION.RED : 88.9,
  },
};

double calculateWetBulbTemperature(double temperature, double humidity, Temperature temperatureUnit) {
  if (temperatureUnit == TEMPERATURE_FAHRENHEIT)
   temperature = (temperature - 32) / 1.8;

  return temperature * atan(0.151977 * sqrt((humidity + 8.313659))) + atan(temperature + humidity) - atan(humidity - 1.676331) + 0.00391838 *pow(humidity, 1.5) * atan(0.023101 * humidity) - 4.686035;
}
