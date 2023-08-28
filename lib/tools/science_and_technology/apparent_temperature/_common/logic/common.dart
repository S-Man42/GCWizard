import 'dart:math';

enum CLOUD_COVER {CLEAR_0, FEW_1, FEW_2, SCATTERED_3, SCATTERED_4, BROKEN_5, BROKEN_6, BROKEN_7, OVERCAST_8, OBSCURED_9, NULL}

Map<CLOUD_COVER, String> CLOUD_COVER_LIST = {
  CLOUD_COVER.CLEAR_0 : 'weathersymbols_n_0',
  CLOUD_COVER.FEW_1 : 'weathersymbols_n_1',
  CLOUD_COVER.FEW_2 : 'weathersymbols_n_2',
  CLOUD_COVER.SCATTERED_3 : 'weathersymbols_n_3',
  CLOUD_COVER.SCATTERED_4 : 'weathersymbols_n_4',
  CLOUD_COVER.BROKEN_5 : 'weathersymbols_n_5',
  CLOUD_COVER.BROKEN_6 : 'weathersymbols_n_6',
  CLOUD_COVER.BROKEN_7 : 'weathersymbols_n_7',
  CLOUD_COVER.OVERCAST_8 : 'weathersymbols_n_8',
  CLOUD_COVER.OBSCURED_9 : 'weathersymbols_n_9',
};

Map<CLOUD_COVER, double> CLOUD_COVER_VALUE = {
  CLOUD_COVER.CLEAR_0 : 0.0,
  CLOUD_COVER.FEW_1 : 0.05,
  CLOUD_COVER.FEW_2 : 0.10,
  CLOUD_COVER.SCATTERED_3 : 0.25,
  CLOUD_COVER.SCATTERED_4 : 0.40,
  CLOUD_COVER.BROKEN_5 : 0.50,
  CLOUD_COVER.BROKEN_6 : 0.65,
  CLOUD_COVER.BROKEN_7 : 0.80,
  CLOUD_COVER.OVERCAST_8 : 1.0,
  CLOUD_COVER.OBSCURED_9 : 1.0,
};

double calc_solar_irradiance({double solarElevationAngle = 0.0, required CLOUD_COVER cloudcover}) {
  double R0 = 990 * sin(solarElevationAngle * pi / 180) - 30;
  double cloudCoverFraction = CLOUD_COVER_VALUE[cloudcover]!;
  return R0 * (1.0 - 0.75 * pow(cloudCoverFraction, 3.4));
}

