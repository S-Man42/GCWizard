import 'dart:math';


class GeschossOutput {
  final String state;
  final String output;

  GeschossOutput(this.state, this.output);
}

GeschossOutput calculateEnergy (String GMass, String GSpeed) {
  double GeschossEnergy = 0;
  double GeschossMass = 0;
  double GeschossSpeed = 0;

  if (GMass == null || GMass.length == 0) {
    return GeschossOutput('ERROR', 'geschoss_error_noInput_Mass');
  }
  if (GEnergy == null || GEnergy.length == 0) {
    return GeschossOutput('ERROR', 'geschoss_error_noInput_Speed');
  }

  GeschossMass = double.tryParse(GMass);
  if (GeschossMass == null ) {
    return GeschossOutput('ERROR', 'geschoss_error_wrongFormat_Double');
  }

  GeschossSpeed = double.tryParse(GSpeed);
  if (GeschossSpeed == null ) {
    return GeschossOutput('ERROR', 'geschoss_error_wrongFormat_Double');
  }

  GeschossEnergy = GeschossMass / 2 * GeschossSpeed * GeschossSpeed;
  return GeschossOutput('OK', GeschossEnergy.toStringAsFixed(5));
}


GeschossOutput calculateMass (String GEnergy, String GSpeed) {
  double GeschossMass = 0;
  double GeschossEnergy;
  double GeschossSpeed;

  GeschossMass = 2 * GeschossEnergy / GeschossSpeed / GeschossSpeed;
  return GeschossOutput('OK', GeschossMass.toStringAsFixed(5));
}


GeschossOutput calculateSpeed (String GEnergy, String GMass) {
  double calculateSpeed = 0;
  double GeschossEnergy;
  double GeschossMass;

  calculateSpeed = sqrt(2 * GeschossEnergy / GeschossMass);
  return GeschossOutput('OK', calculateSpeed.toStringAsFixed(5));
}
