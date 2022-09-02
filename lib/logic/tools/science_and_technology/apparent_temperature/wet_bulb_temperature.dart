// https://en.wikipedia.org/wiki/Wet-bulb_temperature
// https://de.wikipedia.org/wiki/K%C3%BChlgrenztemperatur
// https://uwz.at/de/a/feuchtkugeltemperatur-wie-viel-schwuele-halten-wir-aus#:~:text=Steigt%20die%20Feuchtkugeltemperatur%20auf%20%C3%BCber,den%20Menschen%20(siehe%20Studie).
// https://climate-preparedness.com/understanding-wet-bulb-temperature-and-why-it-is-so-dangerous/
// https://ksi.uconn.edu/prevention/wet-bulb-globe-temperature-monitoring/
// https://www.researchgate.net/profile/Thieres-Silva/publication/261706490_Estimating_Black_Globe_Temperature_Based_on_Meteorological_Data/links/00b7d535176fd08364000000/Estimating-Black-Globe-Temperature-Based-on-Meteorological-Data.pdf?origin=publication_detail
// https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
// https://www.omnicalculator.com/physics/wet-bulb
// https://calculator-online.net/wet-bulb-calculator/
// https://climatechip.org/excel-wbgt-calculator
// https://rechneronline.de/barometer/feuchttemperatur.php

import 'dart:math';

import 'package:gc_wizard/logic/common/units/temperature.dart';

class WBOutput{
  final double WBT;
  final double WBGTOutdoor;

  WBOutput({this.WBT, this.WBGTOutdoor});
}

enum WBGT_HEATSTRESS_CONDITION { WHITE, GREEN, YELLOW, RED, BLACK }

final Map<String, Map<WBGT_HEATSTRESS_CONDITION, double>> WBGT_HEAT_STRESS = {
  TEMPERATURE_CELSIUS.symbol: {
    WBGT_HEATSTRESS_CONDITION.WHITE: 24.9,
    WBGT_HEATSTRESS_CONDITION.GREEN: 27.7,
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

enum WBT_HEATSTRESS_CONDITION { BLACK, PURPLE, BLUE, LIGHT_BLUE, GREEN, ORANGE, RED, DARK_RED }

final Map<String, Map<WBT_HEATSTRESS_CONDITION, double>> WBT_HEAT_STRESS = {
  // https://sustainabilitymath.org/2020/06/01/what-is-our-wet-bulb-temperature-limit/
  // https://www.science.org/doi/10.1126/sciadv.aaw1838
  TEMPERATURE_CELSIUS.symbol: {
    WBT_HEATSTRESS_CONDITION.PURPLE: 23.0,
    WBT_HEATSTRESS_CONDITION.BLUE: 25.0,
    WBT_HEATSTRESS_CONDITION.LIGHT_BLUE: 27.0,
    WBT_HEATSTRESS_CONDITION.GREEN: 29.0,
    WBT_HEATSTRESS_CONDITION.ORANGE: 31.0,
    WBT_HEATSTRESS_CONDITION.RED: 33.0,
    WBT_HEATSTRESS_CONDITION.DARK_RED: 35.0,
  },
  TEMPERATURE_FAHRENHEIT.symbol: {
    WBT_HEATSTRESS_CONDITION.PURPLE: 73.0,
    WBT_HEATSTRESS_CONDITION.BLUE: 77.0,
    WBT_HEATSTRESS_CONDITION.LIGHT_BLUE: 81.0,
    WBT_HEATSTRESS_CONDITION.GREEN: 84.0,
    WBT_HEATSTRESS_CONDITION.ORANGE: 88.0,
    WBT_HEATSTRESS_CONDITION.RED: 91.0,
    WBT_HEATSTRESS_CONDITION.DARK_RED: 94.0,
  },
};

WBOutput calculateWetBulbTemperature(double temperature, double humidity, Temperature temperatureUnit) {
  if (temperatureUnit == TEMPERATURE_FAHRENHEIT) temperature = (temperature - 32) / 1.8;

  // https://rechneronline.de/air/wet-bulb-temperature.php
  double WBT = temperature * atan(0.151977 * sqrt((humidity + 8.313659))) +
      atan(temperature + humidity) -
      atan(humidity - 1.676331) +
      0.00391838 * pow(humidity, 1.5) * atan(0.023101 * humidity) -
      4.686035;

  // calculating T dewpoint from temperature and humidity
  // https://www.vcalc.com/wiki/rklarsen/Calculating+Dew+Point+Temperature+from+Relative+Humidity
  double B1 = 243.04;
  double A1 = 17.625;
  double Tdew = (humidity != 0.0) ? (B1 * (log(humidity / 100) / log(e) + (A1 * temperature) / (B1 + temperature)))/(A1 - log(humidity/100) / log(e) - A1 * temperature / (B1 + temperature)) : 0.0;

  // Estimation of Black Globe Temperature for Calculation of the WBGT Index
  // https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
  double P = 1.0; // Barometric pressure
  double ea = exp(17.67 * (Tdew - temperature) / (Tdew + 243.5)) * (1.0007 + 0.00000346 * P) * 6.112 * exp(17.502 * temperature / (240.97 + temperature)); // atmospheric vapor pressure
  double epsilona = 0.575 * pow(ea, 1/7);
  double S = 1.0; // Solar irradiance in Watts per meter squared - TSI Total Solar irradiance
  double fdb = 0.5; // direct beam radiation from the sun - DNI Direct Normal irradiance, 6000 W/m2 per day => 4.1 W/m2 per minute
  double fdif = 0.5; // diffuse  radiation from the sun - DHI Diffuse Horizontal Irradiance
  double sigma = 5.67 * pow(10, -8); // Stefan-Boltzmann const
  double z = 89.1 * pi / 180; // zenith angle in radian - 0° <=> 90° - altitude
  double B = S * (fdb / 4 / sigma / cos(z) + 1.2 / sigma * fdif) + epsilona * pow(temperature, 4);
  double u = 1.0; // wind speed in m/h
  double C = 0.315 * pow(u, 0.58) / (5.3865 * pow(10, -8));
  double GT = (B + C * temperature + 7680000) / (C + 256000);
  double WBGTOutdoor = 0.7 * WBT + 0.2 * GT + 0.1 * temperature;

  if (temperatureUnit == TEMPERATURE_FAHRENHEIT) {
    WBT = WBT * 1.8 + 32;
    WBGTOutdoor = WBGTOutdoor * 1.8 + 32;
  }

  return WBOutput(WBT: WBT, WBGTOutdoor: WBGTOutdoor, );
}
