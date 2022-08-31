//weeknumber code: https://gist.github.com/Maistho/e38da422ad5c097c635ccf708ec68251

class DayOfTheYearOutput{
  final DateTime date;
  final int weekday;
  final int weeknumber;

  DayOfTheYearOutput(this.date, this.weekday, this.weeknumber);
}

DayOfTheYearOutput calculateDayInfos(int year, int day) {
  if (year == null || day == null) return null;
  var date = DateTime(year, 1, day);

  return DayOfTheYearOutput(date, date.weekday, isoWeekOfYear(date));
}



int isoWeekOfYear(DateTime date) {
  if (date == null)  return null;

  // Get the monday of week 1
  final DateTime mondayWeek1 = _isoWeek1Monday(date);

  // If this date is before the first week of the year, it is the same week as the last week of the previous year.
  if (date.isBefore(mondayWeek1)) {
    return isoWeekOfYear(DateTime(date.year - 1, 12, 31));
  }

  final int ordinalWeek1Monday = _ordinalDate(mondayWeek1);
  final int ordinal = _ordinalDate(date);

  // Calculate number of days after monday week 1
  int diffInDays = ordinal - ordinalWeek1Monday;

  // If the monday occurs on the previous year, we'll need to add a year to the diff
  if (date.year > mondayWeek1.year) {
    diffInDays += 365;
    // If it's a leap year and the leap day is before the date checked, add an extra day
    if (_isLeapYear(date) && DateTime(date.year, 2, 29).isBefore(date)) {
      diffInDays += 1;
    }
  }

  // Divide the difference by 7 to get the number of weeks
  int week = (diffInDays ~/ 7) + 1;

  // The week wraps around to 1 if week 53 doesn't contain a thursday.
  if (week == 53 && date.weekday < DateTime.thursday) {
    return 1;
  }
  return week;
}

/**
 * Calculates the ordinal date
 * The ordinal date is the number of days since December 31st the previous year.
 * January 1st has the ordinal date 1
 * December 31st has the ordinal date 365, or 366 in leap years
 */
int _ordinalDate(DateTime date) {
  final DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  final monthsBefore = DAYS_IN_MONTH.getRange(0, date.month - 1);

  int days = monthsBefore.length > 0
      ? monthsBefore.reduce((value, element) => value + element)
      : 0;

  if (date.month > 2 && _isLeapYear(date)) {
    days += 1;
  }

  return days + date.day;
}

/**
 * Check if this date is on a leap year
 */
bool _isLeapYear(DateTime date) {
  return date.year % 4 == 0 && (date.year % 100 != 0 || date.year % 400 == 0);
}

/**
 * Gets the date of the monday of ISO week 1 this year
 */
DateTime _isoWeek1Monday(DateTime date) {
  final jan4 = DateTime(date.year, 1, 4); // Jan 4 is always in week 1

  return DateTime(
    jan4.year,
    jan4.month,
    jan4.day - jan4.weekday + 1,
  );
}