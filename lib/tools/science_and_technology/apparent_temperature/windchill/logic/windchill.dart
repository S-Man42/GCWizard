import 'dart:math';

import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/velocity.dart';

double calcWindchill(double tempInCelsius, double vInMS) {
  return 13.12 + 0.6215 * tempInCelsius + (0.3965 * tempInCelsius - 11.37) * pow(VELOCITY_KMH.fromMS(vInMS), 0.16);
}