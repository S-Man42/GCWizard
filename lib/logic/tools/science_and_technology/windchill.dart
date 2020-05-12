import 'dart:math';

double calcWindchill(double t, double v, isMetric) {
  if (t == null || v == null)
    return null;

  var wct = isMetric
    ? 13.12 + 0.6215 * t + (0.3965 * t - 11.37) * pow(v, 0.16)
    : 35.74 + 0.6215 * t - (35.75 * pow(v, 0.16)) + 0.4275 * t * pow(v, 0.16);
  return (wct * 1000).round() / 1000;
}
