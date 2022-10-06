// https://en.wikipedia.org/wiki/Humidex

import 'dart:math';

enum HUMIDEX_HEATSTRESS_CONDITION { GREEN, YELLOW, ORANGE, RED }

final Map<HUMIDEX_HEATSTRESS_CONDITION, double> HUMIDEX_HEAT_STRESS = {
  // https://en.wikipedia.org/wiki/Humidex
  HUMIDEX_HEATSTRESS_CONDITION.GREEN: 16.0,
  HUMIDEX_HEATSTRESS_CONDITION.YELLOW: 30.0,
  HUMIDEX_HEATSTRESS_CONDITION.ORANGE: 40.0,
  HUMIDEX_HEATSTRESS_CONDITION.RED: 46.0,
};

double calculateHumidex(double temperature, double dewpointhumidity) {

  double dewpoint(double t, double h) {
    // https://myscope.net/taupunkttemperatur/
    // http://www.thermotech.de/taupunkt.html
    double a = 7.45;
    double b = 235.0;

    double z1 = (a * t) / (b + t);
    double es = 6.1 * exp(z1 * 2.3025851);
    double dru = es * h / 100;                      // Dampfdruck (hPa)
    double z2 = dru / 6.1;
    double z3 = 0.434292289 * log(z2);
    double tau = (235 * z3) / (7.45 - z3);          // Taupunkttemperatur (°C)

    return tau;
  }

  dewpointhumidity = dewpoint(temperature, dewpointhumidity);
  return temperature + 0.5555 * (6.11 * pow(e, 5417.7530 * (1 / 273.16 - 1 / (273.15 + dewpointhumidity))) - 10);
}
