import 'package:gc_wizard/logic/common/units/unit.dart';

class Velocity extends Unit {
  Function toMS;
  Function fromMS;

  Velocity({String name, String symbol, bool isReference: false, double inMS})
      : super(name, symbol, isReference, (e) => e * inMS, (e) => e / inMS) {
    toMS = this.toReference;
    fromMS = this.fromReference;
  }
}

final VELOCITY_MS = Velocity(name: 'common_unit_velocity_ms_name', symbol: 'm/s', isReference: true);

final VELOCITY_KMH = Velocity(name: 'common_unit_velocity_kmh_name', symbol: 'km/h', inMS: 1.0 / 3.6);

final VELOCITY_MPH = Velocity(name: 'common_unit_velocity_mph_name', symbol: 'mph', inMS: 1.0 / 3.6 * 1.609344);

final VELOCITY_MPMIN =
    Velocity(name: 'common_unit_velocity_mpmin_name', symbol: 'mpm', inMS: 1.0 / 3.6 * 1.609344 * 60.0);

final VELOCITY_FTS = Velocity(name: 'common_unit_velocity_fts_name', symbol: 'fts', inMS: 0.3048);

final VELOCITY_KN = Velocity(name: 'common_unit_velocity_kn_name', symbol: 'kn', inMS: 463.0 / 900.0);

final VELOCITY_MMIN = Velocity(name: 'common_unit_velocity_mmin_name', symbol: 'm/min', inMS: 1.0 / 60.0);

final VELOCITY_KMS = Velocity(name: 'common_unit_velocity_kms_name', symbol: 'km/s', inMS: 1000.0);

final VELOCITY_KMMIN = Velocity(name: 'common_unit_velocity_kmmin_name', symbol: 'km/min', inMS: 100.0 / 6.0);

final VELOCITY_FTMIN = Velocity(name: 'common_unit_velocity_ftmin_name', symbol: 'ft/min', inMS: 0.3048 / 60.0);

final VELOCITY_YDS = Velocity(name: 'common_unit_velocity_yds_name', symbol: 'yd/s', inMS: 0.9144);

final VELOCITY_YDMIN = Velocity(name: 'common_unit_velocity_ydmin_name', symbol: 'yd/min', inMS: 0.01524);

final List<Unit> velocities = [
  VELOCITY_MS,
  VELOCITY_MMIN,
  VELOCITY_KMS,
  VELOCITY_KMMIN,
  VELOCITY_KMH,
  VELOCITY_MPMIN,
  VELOCITY_MPH,
  VELOCITY_KN,
  VELOCITY_FTS,
  VELOCITY_FTMIN,
  VELOCITY_YDS,
  VELOCITY_YDMIN
];
