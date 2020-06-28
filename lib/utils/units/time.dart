import 'package:gc_wizard/utils/units/unit.dart';

class Time extends Unit {
  Function toMicroseconds;
  Function fromMicroseconds;

  Time({
    String name,
    String symbol,
    bool isReference: false,
    double inMicroseconds
  }): super(name, symbol, isReference, (e) => e * inMicroseconds, (e) => e / inMicroseconds) {
    toMicroseconds = this.toReference;
    fromMicroseconds = this.fromReference;
  }
}

final TIME_WEEK = Time(
    name: 'unit_time_week_name',
    symbol: 'w',
    inMicroseconds: 7.0 * 24.0 * 60.0 * 60.0 * 1000.0 * 1000.0
);

final TIME_DAY = Time(
    name: 'unit_time_day_name',
    symbol: 'd',
    inMicroseconds: 24.0 * 60.0 * 60.0 * 1000.0 * 1000.0
);

final TIME_HOUR = Time(
    name: 'unit_time_hour_name',
    symbol: 'h',
    inMicroseconds: 60.0 * 60.0 * 1000.0 * 1000.0
);

final TIME_MINUTE = Time(
    name: 'unit_time_minute_name',
    symbol: 'min',
    inMicroseconds: 60.0 * 1000.0 * 1000.0
);

final TIME_SECOND = Time(
    name: 'unit_time_second_name',
    symbol: 's',
    inMicroseconds: 1000.0 * 1000.0
);

final TIME_MILLISECOND = Time(
    name: 'unit_time_millisecond_name',
    symbol: 'ms',
    inMicroseconds: 1000.0
);

final TIME_MICROSECOND = Time(
    name: 'unit_time_microsecond_name',
    symbol: '\xB5s',
    isReference: true
);

final List<Unit> times = [
  TIME_WEEK,
  TIME_DAY,
  TIME_HOUR,
  TIME_MINUTE,
  TIME_SECOND,
  TIME_MILLISECOND,
  TIME_MICROSECOND
];

final defaultTime = TIME_SECOND;