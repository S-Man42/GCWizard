final Map<int, String>  MONTH = {
  1: 'common_month_january',
  2: 'common_month_february',
  3: 'common_month_march',
  4: 'common_month_april',
  5: 'common_month_may',
  6: 'common_month_june',
  7: 'common_month_july',
  8: 'common_month_august',
  9: 'common_month_september',
  10: 'common_month_october',
  11: 'common_month_november',
  12: 'common_month_december',
};

class DateOutput {
  final String day;
  final String month;
  final String year;
  DateOutput(this.day, this.month, this.year);
}

DateOutput JulianDateToGregorianCalendar(double jd, bool round){
  int z = (jd + 0.5).floor();
  double f = jd + 0.5 - z;
  int alpha = ((z - 1867216.25) / 36524.25).floor();
  int a = z + 1 + alpha - (alpha / 4).floor();
  int b = a + 1524;
  int c = ((b - 122.1) / 365.25).floor();
  int d = (365.25 * c).floor();
  int e = ((b - d) / 30.6001).floor();
  double day = b - d - (30.6001 * e).floor() + f;
  int month = 0;
  int year = 0;
  if (e <= 13) {
    month = e - 1;
    year = c - 4716;
  } else {
    month = e - 13;
    year = c - 4715;
  }
  if (round)
    return DateOutput(day.round().toString(), month.toString(), year.toString());
  else
    return DateOutput(day.toString(), month.toString(), year.toString());
}

DateOutput JulianDateToJulianCalendar(double jd, bool round){
  int z = (jd + 0.5).floor();
  double f = jd + 0.5 - z;
  int a = z;
  int b = a + 1524;
  int c = ((b - 122.1) / 365.25).floor();
  int d = (365.25 * c).floor();
  int e = ((b - d) / 30.6001).floor();
  double day = b - d - (30.6001 * e).floor() + f;
  int month = 0;
  int year = 0;
  if (e <= 13) {
    month = e - 1;
    year = c - 4716;
  } else {
    month = e - 13;
    year = c - 4715;
  }
  if (round)
    return DateOutput(day.toString().split('.')[0], month.toString(), year.toString());
  else
    return DateOutput(day.toString(), month.toString(), year.toString());
}

double GregorianCalendarToJulianDate(DateTime date){
  int day = date.day;
  int month = date.month;
  int year = date.year;

  if (month <= 2) {
    year = year - 1;
    month = month + 12;
  }
  int b = 2 - (year / 100).floor() + (year / 400).floor();

  return (365.25 * (year + 4716)).floor() + (30.6001 * (month + 1)).floor() + day + b - 1524.5;
}

double JulianCalendarToJulianDate(DateTime date){
  int day = date.day;
  int month = date.month;
  int year = date.year;

  if (month <= 2) {
    year = year - 1;
    month = month + 12;
  }
  int b = 0;

  return (365.25 * (year + 4716)).floor() + (30.6001 * (month + 1)).floor() + day + b - 1524.5;
}

double JulianDateToModifedJulianDate(double jd){
  return jd - 2400000.5;
}

double ModifedJulianDateToJulianDate(double mjd){
  return mjd + 2400000.5;
}

int JulianDateToJulianDayNumber(double jd){
  return jd.floor();
}


