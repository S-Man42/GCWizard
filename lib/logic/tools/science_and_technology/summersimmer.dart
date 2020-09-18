// https://myscope.net/hitzeindex-gefuehle-temperatur/

import 'package:gc_wizard/logic/units/temperature.dart';


double calculateSummersimmerIndex (double temperature, double humidity, Temperature temperatureUnit) {
  double summersimmerIndex = 0;

  if (temperatureUnit == TEMPERATURE_CELSIUS) {
    temperature = temperature * 1.8 + 32;
    summersimmerIndex = ((1.98 * (temperature - (0.55 - 0.0055 * humidity) * (temperature - 58)) - 56.83) - 32) * 5 / 9;
  } else {
    summersimmerIndex = 1.98 * (temperature - (0.55 - 0.0055 * humidity) * (temperature - 58)) - 56.83;
  }

  return summersimmerIndex;
}