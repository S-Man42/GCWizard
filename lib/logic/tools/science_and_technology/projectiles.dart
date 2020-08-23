import 'dart:math';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/theme/theme.dart';

enum CalculateProjectilesMode {ENERGY, MASS, VELOCITY}


double calculateEnergy (double mass, double velocity) {
    return mass * velocity * velocity / 2;
}


double calculateMass (double energy, double velocity) {
  if ( velocity == 0)
    return 0;
  else
    return 2 * energy / velocity / velocity;
}


double calculateVelocity (double energy, double mass) {
  if (mass == 0)
    return 0;
  else
    return sqrt(2 * energy / mass);
}


