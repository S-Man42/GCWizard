// https://de.wikipedia.org/wiki/Polarkoordinaten

import 'dart:math';

import 'package:intl/intl.dart';

String CartesianToPolar(String currentA, String currentB) {
  if (currentA == null || currentA == '' || currentB == null || currentB == '') return '';
  currentA = currentA.replaceAll(',', '.');
  currentB = currentB.replaceAll(',', '.');

  double a = double.parse(currentA);
  double b = double.parse(currentB);
  double r = sqrt( a * a + b * b);
  double phi = 0.0;

  if (a > 0 && b >= 0)
    phi = atan(b / a);
  else if (a > 0 && b < 0)
    phi = atan(b / a) + 2 * pi;
  else if (a < 0)
    phi = atan(b / a) + pi;
  else if (a == 0 && b > 0)
    phi = pi / 2;
  else
    phi = 3 * pi / 2;

  phi = phi * 180 / pi;

  return 'r = ' + NumberFormat('0.0' + '#' * 6).format(r)
         + '\n'
      + 'φ = ' + NumberFormat('0.0' + '#' * 6).format(phi);
}

String PolarToCartesian(String currentRadius, currentAngle) {
  if (currentRadius == null || currentRadius == '' || currentAngle == null || currentAngle == '') return '';
  currentRadius = currentRadius.replaceAll(',', '.');
  currentAngle = currentAngle.replaceAll(',', '.');

  double r = double.parse(currentRadius);
  double a = double.parse(currentAngle);

  return 'a = ' + NumberFormat('0.0' + '#' * 6).format(r * cos(a * pi / 180))
      + '\n'
      + 'b = ' + NumberFormat('0.0' + '#' * 6).format(r * sin(a * pi / 180));
}

