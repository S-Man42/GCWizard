import 'package:gc_wizard/utils/units/unit.dart';

class Velocity extends Unit {
  Function toMS;
  Function fromMS;

  Velocity({
    String name,
    String symbol,
    bool isReference: false,
    double inMS
  }): super(name, symbol, isReference, (e) => e * inMS, (e) => e / inMS) {
    toMS = this.toReference;
    fromMS = this.fromReference;
  }
}

final VELOCITY_MS = Velocity(
  name: 'unit_velocity_ms_name',
  symbol: 'm/s',
  isReference: true
);

final VELOCITY_KMH = Velocity(
  name: 'unit_velocity_kmh_name',
  symbol: 'km/h',
  inMS: 1.0 / 3.6
);

final VELOCITY_MPH = Velocity(
  name: 'unit_velocity_mph_name',
  symbol: 'mph',
  inMS: 1.0 / (1.609344 * 3.6)
);

final List<Unit> velocities = [
  VELOCITY_MS,
  VELOCITY_KMH,
  VELOCITY_MPH
];

final defaultVelocity = VELOCITY_MS;