import 'dart:math';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/theme/theme.dart';

enum CalculateProjectilesMode {ENERGY, MASS, SPEED}


double calculateEnergy (double mass, double speed) {
    return mass * speed * speed / 2;
}


double calculateMass (double energy, double speed) {
  if ( speed == 0)
    return 0;
  else
    return 2 * energy / speed / speed;
}


double calculateSpeed (double energy, double mass) {
  if (mass == 0)
    return 0;
  else
    return sqrt(2 * energy / mass);
}


