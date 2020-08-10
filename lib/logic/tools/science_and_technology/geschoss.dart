import 'dart:math';


class GeschossOutput {
  final String state;
  final String output;
  final String formula;

  GeschossOutput(this.state, this.output, this.formula);
}

GeschossOutput calculateEnergy (String GMass, String GSpeed) {
  double GeschossEnergy = 0;
  double GeschossMass = 0;
  double GeschossSpeed = 0;

  if (GMass == null || GMass.length == 0) {
    return GeschossOutput('ERROR', 'geschoss_error_noInput_Mass', '');
  }

  GeschossMass = double.tryParse(GMass);
  if (GeschossMass == null ) {
    return GeschossOutput('ERROR', 'geschoss_error_wrongFormat_Double_Mass', '');
  }

  if (GSpeed == null || GSpeed.length == 0) {
    return GeschossOutput('ERROR', 'geschoss_error_noInput_Speed', '');
  }

  GeschossSpeed = double.tryParse(GSpeed);
  if (GeschossSpeed == null ) {
    return GeschossOutput('ERROR', 'geschoss_error_wrongFormat_Double_Speed', '');
  }

  GeschossEnergy = GeschossMass / 2 * GeschossSpeed * GeschossSpeed;
  return GeschossOutput('OK', GeschossEnergy.toStringAsFixed(5), 'geschoss_energy');
}


GeschossOutput calculateMass (String GEnergy, String GSpeed) {
  double GeschossMass = 0;
  double GeschossEnergy = 0;
  double GeschossSpeed = 0;

  if (GEnergy == null || GEnergy.length == 0) {
    return GeschossOutput('ERROR', 'geschoss_error_noInput_Energy', '');
  }

  GeschossEnergy = double.tryParse(GEnergy);
  if (GeschossEnergy == null ) {
    return GeschossOutput('ERROR', 'geschoss_error_wrongFormat_Double_Energy', '');
  }

  if (GSpeed == null || GSpeed.length == 0) {
    return GeschossOutput('ERROR', 'geschoss_error_noInput_Speed', '');
  }

  GeschossSpeed = double.tryParse(GSpeed);
  if (GeschossSpeed == null ) {
    return GeschossOutput('ERROR', 'geschoss_error_wrongFormat_Double_Speed', '');
  }

  GeschossMass = 2 * GeschossEnergy / GeschossSpeed / GeschossSpeed;
  return GeschossOutput('OK', GeschossMass.toStringAsFixed(5), 'geschoss_mass');
}


GeschossOutput calculateSpeed (String GEnergy, String GMass) {
  double calculateSpeed = 0;
  double GeschossEnergy = 0;
  double GeschossMass = 0;

  if (GMass == null || GMass.length == 0) {
    return GeschossOutput('ERROR', 'geschoss_error_noInput_Mass', '');
  }

  GeschossMass = double.tryParse(GMass);
  if (GeschossMass == null ) {
    return GeschossOutput('ERROR', 'geschoss_error_wrongFormat_Double_Mass', '');
  }

  if (GEnergy == null || GEnergy.length == 0) {
    return GeschossOutput('ERROR', 'geschoss_error_noInput_Energy', '');
  }

  GeschossEnergy = double.tryParse(GEnergy);
  if (GeschossEnergy == null ) {
    return GeschossOutput('ERROR', 'geschoss_error_wrongFormat_Double_Energy', '');
  }

  calculateSpeed = sqrt(2 * GeschossEnergy / GeschossMass);
  return GeschossOutput('OK', calculateSpeed.toStringAsFixed(5), 'geschoss_speed');
}
