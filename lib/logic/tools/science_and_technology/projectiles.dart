import 'dart:math';


class ProjectilesOutput {
  final String state;
  final String output;
  final String formula;

  ProjectilesOutput(this.state, this.output, this.formula);
}

//ProjectilesOutput calculateEnergy (String GMass, String GSpeed) {
double calculateEnergy (double mass, double speed) {
//  double projectilesEnergy = 0;
//  double projectilesMass = 0;
//  double projectilesSpeed = 0;

//  if (GMass == null || GMass.length == 0) {
//    return ProjectilesOutput('ERROR', 'Projectiles_error_noInput_Mass', '');
//    return 0;
//  }

//  projectilesMass = double.tryParse(GMass);
//  if (projectilesMass == null ) {
//    return ProjectilesOutput('ERROR', 'Projectiles_error_wrongFormat_Double_Mass', '');
//    return 0;
//  }

//  if (GSpeed == null || GSpeed.length == 0) {
//    return ProjectilesOutput('ERROR', 'Projectiles_error_noInput_Speed', '');
//    return 0;
//  }

//  ProjectilesSpeed = double.tryParse(GSpeed);
//  if (ProjectilesSpeed == null ) {
//    return ProjectilesOutput('ERROR', 'Projectiles_error_wrongFormat_Double_Speed', '');
//    return 0;
//  }

//  ProjectilesEnergy = ProjectilesMass / 2 * ProjectilesSpeed * ProjectilesSpeed;
//  return ProjectilesOutput('OK', ProjectilesEnergy.toStringAsFixed(5), 'Projectiles_energy');
    return mass / 2 * speed * speed;
}


//ProjectilesOutput calculateMass (String GEnergy, String GSpeed) {
double calculateMass (double energy, double speed) {
//  double ProjectilesMass = 0;
//  double ProjectilesEnergy = 0;
//  double ProjectilesSpeed = 0;

//  if (GEnergy == null || GEnergy.length == 0) {
//    return ProjectilesOutput('ERROR', 'Projectiles_error_noInput_Energy', '');
//  }

//  ProjectilesEnergy = double.tryParse(GEnergy);
//  if (ProjectilesEnergy == null ) {
//    return ProjectilesOutput('ERROR', 'Projectiles_error_wrongFormat_Double_Energy', '');
//  }

//  if (GSpeed == null || GSpeed.length == 0) {
//    return ProjectilesOutput('ERROR', 'Projectiles_error_noInput_Speed', '');
//  }

//  ProjectilesSpeed = double.tryParse(GSpeed);
//  if (ProjectilesSpeed == null ) {
//    return ProjectilesOutput('ERROR', 'Projectiles_error_wrongFormat_Double_Speed', '');
//  }

//  ProjectilesMass = 2 * ProjectilesEnergy / ProjectilesSpeed / ProjectilesSpeed;
//  return ProjectilesOutput('OK', ProjectilesMass.toStringAsFixed(5), 'Projectiles_mass');
  if ( speed == 0)
    return 0;
  else
    return 2 * energy / speed / speed;
}


//ProjectilesOutput calculateSpeed (String GEnergy, String GMass) {
double calculateSpeed (double energy, double mass) {
/*
  double calculateSpeed = 0;
  double ProjectilesEnergy = 0;
  double ProjectilesMass = 0;

  if (GMass == null || GMass.length == 0) {
    return ProjectilesOutput('ERROR', 'Projectiles_error_noInput_Mass', '');
  }

  ProjectilesMass = double.tryParse(GMass);
  if (ProjectilesMass == null ) {
    return ProjectilesOutput('ERROR', 'Projectiles_error_wrongFormat_Double_Mass', '');
  }

  if (GEnergy == null || GEnergy.length == 0) {
    return ProjectilesOutput('ERROR', 'Projectiles_error_noInput_Energy', '');
  }

  ProjectilesEnergy = double.tryParse(GEnergy);
  if (ProjectilesEnergy == null ) {
    return ProjectilesOutput('ERROR', 'Projectiles_error_wrongFormat_Double_Energy', '');
  }

  calculateSpeed = sqrt(2 * ProjectilesEnergy / ProjectilesMass);
  return ProjectilesOutput('OK', calculateSpeed.toStringAsFixed(5), 'Projectiles_speed');
*/
  if (mass == 0)
    return 0;
  else
    return sqrt(2 * energy / mass);
}
