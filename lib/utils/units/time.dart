import 'package:gc_wizard/utils/units/unit.dart';

class Time extends Unit {
  Function toSeconds;
  Function fromSeconds;

  Time({
    String name,
    String symbol,
    bool isReference: false,
    double inSeconds
  }): super(name, symbol, isReference, (e) => e * inSeconds, (e) => e / inSeconds) {
    toSeconds = this.toReference;
    fromSeconds = this.fromReference;
  }
}

final TIME_WEEK = Time(
  name: 'common_unit_time_w_name',
  symbol: 'w',
  inSeconds: 7.0 * 24.0 * 60.0 * 60.0
);

final TIME_DAY = Time(
  name: 'common_unit_time_d_name',
  symbol: 'd',
  inSeconds: 24.0 * 60.0 * 60.0
);

final TIME_HOUR = Time(
  name: 'common_unit_time_h_name',
  symbol: 'h',
  inSeconds: 60.0 * 60.0
);

final TIME_MINUTE = Time(
  name: 'common_unit_time_min_name',
  symbol: 'min',
  inSeconds: 60.0
);

final TIME_SECOND = Time(
  name: 'common_unit_time_s_name',
  symbol: 's',
  isReference: true
);

final List<Unit> times = [
  TIME_WEEK,
  TIME_DAY,
  TIME_HOUR,
  TIME_MINUTE,
  TIME_SECOND
];

final defaultTime = TIME_SECOND;