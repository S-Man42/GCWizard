// https://de.wikipedia.org/wiki/Hitzeindex
import 'dart:math';

var _heatParameterCelsius = {
  1: 8.784695 * (-1),
  2: 1.61139411,
  3: 2.338549,
  4: 0.14611605 * (-1),
  5: 1.2308094 * pow(10, -2) * (-1),
  6: 1.6424828 * pow(10, -2) * (-1),
  7: 2.211732 * pow(10, -3),
  8: 7.2546 * pow(10, -4),
  9: 3.582 * pow(10, -6) * (-1)
};

enum HEATINDEX_HEATSTRESS_CONDITION { LIGHT_YELLOW, YELLOW, ORANGE, RED }

final Map<HEATINDEX_HEATSTRESS_CONDITION, double> HEATINDEX_HEAT_STRESS = {
  // https://en.wikipedia.org/wiki/Heat_index
  HEATINDEX_HEATSTRESS_CONDITION.LIGHT_YELLOW: 27.0,
  HEATINDEX_HEATSTRESS_CONDITION.YELLOW: 33.0,
  HEATINDEX_HEATSTRESS_CONDITION.ORANGE: 41.0,
  HEATINDEX_HEATSTRESS_CONDITION.RED: 54.0,
};

double calculateHeatIndex(double temperature, double humidity) {
  var c;
  double heatIndex = 0;

  c = _heatParameterCelsius;

  heatIndex = c[1] +
      c[2] * temperature +
      c[3] * humidity +
      c[4] * temperature * humidity +
      c[5] * temperature * temperature +
      c[6] * humidity * humidity +
      c[7] * temperature * temperature * humidity +
      c[8] * temperature * humidity * humidity +
      c[9] * temperature * temperature * humidity * humidity;

  return heatIndex;
}
