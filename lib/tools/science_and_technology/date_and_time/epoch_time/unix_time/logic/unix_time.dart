//https://de.wikipedia.org/wiki/Unixzeit

import 'package:gc_wizard/tools/science_and_technology/date_and_time/calendar/logic/calendar_constants.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time/epoch_time/logic/epoch_time.dart';
import 'package:gc_wizard/utils/datetime_utils.dart';

EpochTimeOutput DateTimeToUnixTime(DateTime currentDateTime) {
  if (_invalidUnixDate(gregorianCalendarToJulianDate(currentDateTime))) {
    return EpochTimeOutput(
      Error: 'dates_calendar_unix_error',
      timeStamp: 0,
      UTC: DateTime.utc(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          currentDateTime.hour,
          currentDateTime.minute,
          currentDateTime.second),
      local: currentDateTime,
    );
  }

  return EpochTimeOutput(
      timeStamp:
      (currentDateTime.difference(DateTime.utc(1970,1,1)).inSeconds + currentDateTime.timeZoneOffset.inSeconds).toDouble(),
      UTC: DateTime.utc(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          currentDateTime.hour,
          currentDateTime.minute,
          currentDateTime.second),
      local: currentDateTime,
      Error: '');
}

EpochTimeOutput UnixTimeToDateTime(int unixtime) {
  return EpochTimeOutput(
      timeStamp: unixtime.toDouble(),
      UTC: DateTime.fromMillisecondsSinceEpoch(unixtime * 1000, isUtc: true),
      local: DateTime.fromMillisecondsSinceEpoch(unixtime * 1000, isUtc: false),
      Error: '');
}

bool _invalidUnixDate(double jd) {
  if (jd < JD_UNIX_START) return true;
  return false;
}
