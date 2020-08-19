import 'dart:math';


double calculateEnergy (double mass, double speed) {
    return mass / 2 * speed * speed;
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
