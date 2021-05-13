// https://de.wikipedia.org/wiki/Islamischer_Kalender#Umrechnung_eines_gregorianischen_Datums_in_den_islamischen_Kalender
// https://de.wikipedia.org/wiki/Julianisches_Datum
// https://www.bubomax.de/chrono/chrono.htm

final Map<int, int> _DAYDIFF_ISLAMICCAL = {
  1: 0,
  2: 30,
  3: 59,
  4: 89,
  5: 118,
  6: 148,
  7: 177,
  8: 207,
  9: 236,
  10: 266,
  11: 295,
  12: 325
};

final Map<int, int> _ISLAMICDAYSUM = {
  354: 1,
  709: 2,
  1063: 3,
  1417: 4,
  1772: 5,
  2126: 6,
  2481: 7,
  2835: 8,
  3189: 9,
  3544:10,
  3898: 11,
  4252: 12,
  4607: 13,
  4961: 14,
  5315: 15,
  5670: 16,
  6024: 17,
  6379: 18,
  6733: 19,
  7087: 20,
  7442: 21,
  7796: 22,
  8150: 23,
  8505: 24,
  8859: 25,
  9214: 26,
  9568: 27,
  9922: 28,
  10277: 29,
  10631: 30,
};

final Map<int, String> MONTH_ISLAMIC = {
  1: 'Muharram',
  2: 'Safar',
  3: 'Rabi al-Awwal',
  4: 'Rabi al-Akhir',
  5: 'Djumada l-Ula',
  6: 'Djumada t-Akhira',
  7: 'Radjab',
  8: 'Shaban',
  9: 'Ramadan',
  10: 'Shawwal',
  11: 'Dhu l-Kada',
  12: 'Dhu l-Hidjdja'
};

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
  return _JDToCal(jd, round, 'G');
}

DateOutput JulianDateToJulianCalendar(double jd, bool round){
  return _JDToCal(jd, round, 'J');
}

double GregorianCalendarToJulianDate(DateTime date){
  return _calToJD(date, 'G');
}

double JulianCalendarToJulianDate(DateTime date){
  return _calToJD(date, 'J');
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

double _calToJD(DateTime date, String type){
  int day = date.day;
  int month = date.month;
  int year = date.year;

  if (month <= 2) {
    year = year - 1;
    month = month + 12;
  }

  int b = 0;
  if (type == 'G')
    b = 2 - (year / 100).floor() + (year / 400).floor();

  return (365.25 * (year + 4716)).floor() + (30.6001 * (month + 1)).floor() + day + b - 1524.5;
}

DateOutput _JDToCal(double jd, bool round, String type){
  int z = (jd + 0.5).floor();
  double f = jd + 0.5 - z;
  int a = z;
  int alpha = 0;
  if (type == 'G') {
    alpha = ((z - 1867216.25) / 36524.25).floor();
    a = z + 1 + alpha - (alpha / 4).floor();
  }
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
    return DateOutput(day.truncate().toString(), month.toString(), year.toString());
  else
    return DateOutput(day.toString(), month.toString(), year.toString());
}

int JulianDay(DateTime date){
  return (GregorianCalendarToJulianDate(date) - GregorianCalendarToJulianDate(DateTime(date.year, 1, 1))).toInt();
}

DateOutput GregorianCalendarToIslamicCalendar(DateTime date){
  DateOutput JC = JulianDateToJulianCalendar(GregorianCalendarToJulianDate(date), true);
  int completeJY = int.parse(JC.year) - 1;
  int days = (completeJY % 4) * 1461 + (completeJY - (completeJY ~/ 4) * 4) * 356;
  days = days + JulianDay(date);
  days = days - 227016;
  int islamicCompleteCycles = days ~/ 10631;
  int islamicRestDays = days - islamicCompleteCycles * 10631;
  int islamicCompleteYears = 0;
  int islamicDays = 0;
  _ISLAMICDAYSUM.forEach((key, value) {
    if (key < islamicRestDays) {
      islamicCompleteYears = value;
      islamicDays = islamicRestDays - key;
    }
  });
  int day = 0;
  int month = 0;
  _DAYDIFF_ISLAMICCAL.forEach((key, value) {
    if (value < islamicDays) {
      month = key;
      day = islamicDays - value;
    }
  });

  return DateOutput(day.toString(), month.toString(), (islamicCompleteCycles * 30 + islamicCompleteYears + islamicCompleteYears + 1).toString());
}

double IslamicCalendarToJulianDate(DateTime date){
  int M = date.year;
  int b = (0.363636 * ((M + 5) % 30) + 9.28).floor() % 11;
  int d = M % 30;
  int JD0Muharram = 1948085 + 10631 * M ~/ 30 + 354 * d + b;
  return (JD0Muharram + date.day + _DAYDIFF_ISLAMICCAL[date.month]).toDouble();
}


