import 'package:gc_wizard/utils/units/unit.dart';

final VELOCITY_MS = 'm/s';
final VELOCITY_KMH = 'km/h';
final VELOCITY_MPH = 'mph';

class Velocity extends Unit {
  Velocity(
    String name,
    String symbol,
    bool isReference,
    double inMS
  ): super(name, symbol, isReference, (e) => e * inMS, (e) => e / inMS);
}

final List<Unit> velocities = [
  Velocity('unit_velocity_ms_name', VELOCITY_MS, true, 1.0),
  Velocity('unit_velocity_kmh_name', VELOCITY_KMH, false, 3.6),
  Velocity('unit_velocity_mph_name', VELOCITY_MPH, false, 1.609344 * 3.6)
];

final defaultVelocity = getReferenceUnit(velocities) as Velocity;