import 'dart:math';

enum CLOUD_COVER {
  CLEAR_0,
  FEW_1,
  FEW_2,
  SCATTERED_3,
  SCATTERED_4,
  BROKEN_5,
  BROKEN_6,
  BROKEN_7,
  OVERCAST_8,
  OBSCURED_9,
  NULL
}

Map<CLOUD_COVER, String> CLOUD_COVER_LIST = {
  CLOUD_COVER.CLEAR_0: 'weathersymbols_n_0',
  CLOUD_COVER.FEW_1: 'weathersymbols_n_1',
  CLOUD_COVER.FEW_2: 'weathersymbols_n_2',
  CLOUD_COVER.SCATTERED_3: 'weathersymbols_n_3',
  CLOUD_COVER.SCATTERED_4: 'weathersymbols_n_4',
  CLOUD_COVER.BROKEN_5: 'weathersymbols_n_5',
  CLOUD_COVER.BROKEN_6: 'weathersymbols_n_6',
  CLOUD_COVER.BROKEN_7: 'weathersymbols_n_7',
  CLOUD_COVER.OVERCAST_8: 'weathersymbols_n_8',
  CLOUD_COVER.OBSCURED_9: 'weathersymbols_n_9',
};

class CloudCoverConfig {
  final String image;
  final String title;
  final String subtitle;

  const CloudCoverConfig({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

const Map<CLOUD_COVER, CloudCoverConfig> CLOUD_COVER_MAP = {
  CLOUD_COVER.CLEAR_0:
      CloudCoverConfig(image: '0', title: 'weathersymbols_n_0', subtitle: ''),
  CLOUD_COVER.FEW_1:
      CloudCoverConfig(image: '1', title: 'weathersymbols_n_1', subtitle: ''),
  CLOUD_COVER.FEW_2:
      CloudCoverConfig(image: '2', title: 'weathersymbols_n_2', subtitle: ''),
  CLOUD_COVER.SCATTERED_3:
      CloudCoverConfig(image: '3', title: 'weathersymbols_n_3', subtitle: ''),
  CLOUD_COVER.SCATTERED_4:
      CloudCoverConfig(image: '4', title: 'weathersymbols_n_4', subtitle: ''),
  CLOUD_COVER.BROKEN_5:
      CloudCoverConfig(image: '5', title: 'weathersymbols_n_5', subtitle: ''),
  CLOUD_COVER.BROKEN_6:
      CloudCoverConfig(image: '6', title: 'weathersymbols_n_6', subtitle: ''),
  CLOUD_COVER.BROKEN_7:
      CloudCoverConfig(image: '7', title: 'weathersymbols_n_7', subtitle: ''),
  CLOUD_COVER.OVERCAST_8:
      CloudCoverConfig(image: '8', title: 'weathersymbols_n_8', subtitle: ''),
  CLOUD_COVER.OBSCURED_9:
      CloudCoverConfig(image: '9', title: 'weathersymbols_n_9', subtitle: ''),
};

Map<CLOUD_COVER, double> CLOUD_COVER_VALUE = {
  CLOUD_COVER.CLEAR_0: 0.0,
  CLOUD_COVER.FEW_1: 0.05,
  CLOUD_COVER.FEW_2: 0.10,
  CLOUD_COVER.SCATTERED_3: 0.25,
  CLOUD_COVER.SCATTERED_4: 0.40,
  CLOUD_COVER.BROKEN_5: 0.50,
  CLOUD_COVER.BROKEN_6: 0.65,
  CLOUD_COVER.BROKEN_7: 0.80,
  CLOUD_COVER.OVERCAST_8: 1.0,
  CLOUD_COVER.OBSCURED_9: 1.0,
};

double calculateSolarIrradiance(
    {double solarElevationAngle = 0.0, required CLOUD_COVER cloudcover}) {
  // https://scool.larc.nasa.gov/lesson_plans/CloudCoverSolarRadiation.pdf#:~:text=There%20is%20a%20simple%20formula%20to%20predict%20how,%280%25%20no%20clouds%29%20to%201.0%20%28100%25%20complete%20coverage%29.
  // https://web.archive.org/web/20240920192708/https://scool.larc.nasa.gov/lesson_plans/CloudCoverSolarRadiation.pdf#:~:text=There%20is%20a%20simple%20formula%20to%20predict%20how,%280%25%20no%20clouds%29%20to%201.0%20%28100%25%20complete%20coverage%29

  // http://www.shodor.org/os411/courses/_master/tools/calculators/solarrad/
  // https://web.archive.org/web/20240920193138/http://www.shodor.org/os411/courses/_master/tools/calculators/solarrad/
  double R0 = 990 * sin(solarElevationAngle * pi / 180) - 30;
  double cloudCoverFraction = CLOUD_COVER_VALUE[cloudcover]!;
  return R0 * (1.0 - 0.75 * pow(cloudCoverFraction, 3.4));
}

double calculateDewPoint(double t, double rh) {
  // https://energie-m.de/tools/taupunkt.html
  // https://myscope.net/taupunkttemperatur/
  double log10(double x) {
    return log(x) / log(10);
  }

  double a = 7.5;
  double b = 237.3;
  double sdd =
      6.1078 * pow(10, (a * t) / (b + t)); // Sättigungsdampfdruck (hPa)
  double dd = sdd * (rh / 100); // Dampfdruck (hPa)
  double v = log10(dd / 6.1078);
  return (b * v) / (a - v);
}

double calculateMeanRadiantTemperature(
    double Tg, double va, double e, double D, double Ta) {
  // https://en.wikipedia.org/wiki/Mean_radiant_temperature
  double MRT = pow(
          pow(Tg + 2784.15, 4) + 0.25 * pow(10, 8) * pow(va, 0.6) * (Tg - Ta),
          0.25) -
      273.15;

  return MRT;
}

double calculateGlobeTemperature(
  double Ta, // T ambient in °C
  double Td, // T DewPoint in C°
  double P, // Barometric pressure
  double u, // Wind speed in m/s
  double S, // Solar irridiance in W/m/m
  double fdb, // direct beam radiation from the sun
  double fdif, // diffuse radiation from the sun
  double z, // Zenith angle in radians
) {
  // https://www.weather.gov/media/tsa/pdf/WBGTpaper2.pdf
  const h = 0.315;
  final sb = 5.67 * pow(10, -8);

  double ea = exp(17.67 * (Td - Td) / (Td + 243.5)) *
      (1.0007 + 0.00000346 * P) *
      6.112 *
      exp(17.502 * Ta / (240.97 + Ta));
  double epsilona = 0.575 * pow(ea, 1 / 7);

  double B =
      S * (fdb / 4 / sb / cos(z) + 1.2 / sb * fdif) + epsilona * pow(Ta, 4);
  double C = h * pow(u, 0.58) / (5.3865 * pow(10, -8));

  return (B + C * Ta + 7680000) / (C + 256000);
}
