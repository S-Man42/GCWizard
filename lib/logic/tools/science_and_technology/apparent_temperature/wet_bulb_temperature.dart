// https://en.wikipedia.org/wiki/Wet-bulb_temperature
// https://de.wikipedia.org/wiki/K%C3%BChlgrenztemperatur
// https://uwz.at/de/a/feuchtkugeltemperatur-wie-viel-schwuele-halten-wir-aus#:~:text=Steigt%20die%20Feuchtkugeltemperatur%20auf%20%C3%BCber,den%20Menschen%20(siehe%20Studie).
// https://climate-preparedness.com/understanding-wet-bulb-temperature-and-why-it-is-so-dangerous/
// https://ksi.uconn.edu/prevention/wet-bulb-globe-temperature-monitoring/
// https://www.omnicalculator.com/physics/wet-bulb
// https://calculator-online.net/wet-bulb-calculator/
// https://climatechip.org/excel-wbgt-calculator
// https://rechneronline.de/barometer/feuchttemperatur.php

import 'dart:math';

import 'package:gc_wizard/logic/common/units/temperature.dart';

class WBOutput{
  final double WBT;
  final double WBGT;

  WBOutput({this.WBT, this.WBGT});
}

enum WBGT_HEATSTRESS_CONDITION { WHITE, GREEN, YELLOW, RED, BLACK }

final Map<String, Map<WBGT_HEATSTRESS_CONDITION, double>> WBGT_HEAT_STRESS = {
  TEMPERATURE_CELSIUS.symbol: {
    WBGT_HEATSTRESS_CONDITION.WHITE: 24.9,
    WBGT_HEATSTRESS_CONDITION.GREEN: 25.0,
    WBGT_HEATSTRESS_CONDITION.YELLOW: 29.4,
    WBGT_HEATSTRESS_CONDITION.RED: 31.6,
  },
  TEMPERATURE_FAHRENHEIT.symbol: {
    WBGT_HEATSTRESS_CONDITION.WHITE: 76.9,
    WBGT_HEATSTRESS_CONDITION.GREEN: 81.9,
    WBGT_HEATSTRESS_CONDITION.YELLOW: 84.9,
    WBGT_HEATSTRESS_CONDITION.RED: 88.9,
  },
};

enum WBT_HEATSTRESS_CONDITION { WHITE, LIGHT_GREEN, GREEN, YELLOW, RED, DARK_RED, BLACK }

final Map<String, Map<WBT_HEATSTRESS_CONDITION, double>> WBT_HEAT_STRESS = {
  // https://sustainabilitymath.org/2020/06/01/what-is-our-wet-bulb-temperature-limit/
  // https://www.science.org/doi/10.1126/sciadv.aaw1838
  TEMPERATURE_CELSIUS.symbol: {
    WBT_HEATSTRESS_CONDITION.WHITE: 23.0,
    WBT_HEATSTRESS_CONDITION.LIGHT_GREEN: 25.0,
    WBT_HEATSTRESS_CONDITION.GREEN: 27.0,
    WBT_HEATSTRESS_CONDITION.YELLOW: 29.0,
    WBT_HEATSTRESS_CONDITION.RED: 31.0,
    WBT_HEATSTRESS_CONDITION.DARK_RED: 33.0,
  },
  TEMPERATURE_FAHRENHEIT.symbol: {
    WBT_HEATSTRESS_CONDITION.WHITE: 73.0,
    WBT_HEATSTRESS_CONDITION.LIGHT_GREEN: 77.0,
    WBT_HEATSTRESS_CONDITION.GREEN: 81.0,
    WBT_HEATSTRESS_CONDITION.YELLOW: 84.0,
    WBT_HEATSTRESS_CONDITION.RED: 88.0,
    WBT_HEATSTRESS_CONDITION.DARK_RED: 91.0,
  },
};

WBOutput calculateWetBulbTemperature(double temperature, double humidity, Temperature temperatureUnit) {
  if (temperatureUnit == TEMPERATURE_FAHRENHEIT) temperature = (temperature - 32) / 1.8;

  double WBT = temperature * atan(0.151977 * sqrt((humidity + 8.313659))) +
      atan(temperature + humidity) -
      atan(humidity - 1.676331) +
      0.00391838 * pow(humidity, 1.5) * atan(0.023101 * humidity) -
      4.686035;
  double WBDT = 0.4 * WBT + 0.6 * temperature;
  double WBGT = 0.7 * WBT + 0.3 * temperature;

  //double WBGT = -5.809 + 0.058 * humidity + 0.697 * temperature + 0.003 * humidity * temperature;
  //double WBGT = 0.67 * WBT + 0.33 * temperature - 0.048 * log(1) * (temperature - WBT);
  double MDI = 0.75 * WBT + 0.3 * temperature;
  double DI = 0.5 * WBT + 0.5 * temperature;
  double DI_2 = 0.4 * WBT + 0.4 * temperature + 8.3;
  print(temperature.toStringAsFixed(2)+' ' + humidity.toStringAsFixed(2)+ '   WBT ' + WBT.toStringAsFixed(2)+'   WBGT '+WBGT.toStringAsFixed(2)+'   MDI '+MDI.toStringAsFixed(2)+'   DI '+DI.toStringAsFixed(2)+'   DI-2 '+DI_2.toStringAsFixed(2)+'   WBDT '+WBDT.toStringAsFixed(2));

  return WBOutput(WBT: WBT, WBGT: WBGT);
}
