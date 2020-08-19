// https://de.wikipedia.org/wiki/Hitzeindex
import 'dart:math';

enum HeatTemperatureMode{Celsius, Fahrenheit}

var heatParameterCelsius = {
  1 : 8.784695 * (-1),
  2 : 1.61139411,
  3 : 2.338549,
  4 : 0.14611605 * (-1),
  5 : 1.2308094 * pow(10,-2) * (-1),
  6 : 1.6424828 * pow(10,-2) * (-1),
  7 : 2.211732 * pow(10,-3),
  8 : 7.2546 * pow(10,-4),
  9 : 3.582 * pow(10,-6) * (-1)
};

var heatParameterFahrenheit = {
  1 : 42.379 * (-1),
  2 : 2.04901523,
  3 : 10.1433127,
  4 : 0.22475541 * (-1),
  5 : 6.83783 * pow(10,-3) * (-1),
  6 : 5.481717 * pow(10,-2) * (-1),
  7 : 1.22874 * pow(10,-3),
  8 : 8.5282 * pow(10,-4),
  9 : 1.99 * pow(10,-6) * (-1),
};

var c;

String calculateHeat (double temperature, double humidity, HeatTemperatureMode temperatureMode) {

  double heat = 0;

  if (temperatureMode == HeatTemperatureMode.Celsius)
    c = heatParameterCelsius;
  else
    c = heatParameterFahrenheit;

  heat =  c[1] +
          c[2] * temperature +
          c[3] * humidity +
          c[4] * temperature * humidity +
          c[5] * temperature * temperature +
          c[6] * humidity * humidity +
          c[7] * temperature * temperature * humidity +
          c[8] * temperature * humidity * humidity +
          c[9] * temperature * temperature *humidity * humidity;
  return heat.toStringAsFixed(3);
}