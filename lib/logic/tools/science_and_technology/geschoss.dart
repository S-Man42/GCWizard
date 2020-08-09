import 'dart:math';


class GeschossOutput {
  final String state;
  final String output;

  GeschossOutput(this.state, this.output);
}

GeschossOutput calculateEnergy (double GeschossMass, double GeschossSpeed) {
  double GeschossEnergy = 0;
  GeschossEnergy = GeschossMass / 2 * GeschossSpeed * GeschossSpeed;
  return GeschossOutput('OK', GeschossEnergy.toStringAsFixed(5));
}


GeschossOutput calculateMass (double GeschossEnergy, double GeschossSpeed) {
  double GeschossMass = 0;
  GeschossMass = 2 * GeschossEnergy / GeschossSpeed / GeschossSpeed;
  return GeschossOutput('OK', GeschossMass.toStringAsFixed(5));
}


GeschossOutput calculateSpeed (double GeschossEnergy, double GeschossMass) {
  double calculateSpeed = 0;
  calculateSpeed = sqrt(2 * GeschossEnergy / GeschossMass);
  return GeschossOutput('OK', calculateSpeed.toStringAsFixed(5));
}
