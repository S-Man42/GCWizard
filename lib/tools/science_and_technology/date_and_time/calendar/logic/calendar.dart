// https://www.aoi.uzh.ch/de/islamwissenschaft/hilfsmittel/tools/kalenderumrechnung/yazdigird.html
// http://www.nabkal.de/kalrech.html
// jüdisch   http://www.nabkal.de/kalrechyud.html
// koptisch  http://www.nabkal.de/kalrech8.html
// iranisch  http://www.nabkal.de/kalrechiran.html
// https://web.archive.org/web/20071012175539/http://ortelius.de/kalender/basic_de.php

import 'package:gc_wizard/utils/logic_utils/datetime_utils.dart';

enum CalendarSystem {
  JULIANDATE,
  JULIANCALENDAR,
  MODIFIEDJULIANDATE,
  GREGORIANCALENDAR,
  ISLAMICCALENDAR,
  PERSIANYAZDEGARDCALENDAR,
  HEBREWCALENDAR,
  COPTICCALENDAR,
  POTRZEBIECALENDAR,
  MAYACALENDAR,
}

Map<CalendarSystem, String> CALENDAR_SYSTEM = {
  CalendarSystem.JULIANDATE: 'dates_calendar_system_juliandate',
  CalendarSystem.JULIANCALENDAR: 'dates_calendar_system_juliancalendar',
  CalendarSystem.MODIFIEDJULIANDATE: 'dates_calendar_system_modifiedjuliandate',
  CalendarSystem.GREGORIANCALENDAR: 'dates_calendar_system_gregoriancalendar',
  CalendarSystem.ISLAMICCALENDAR: 'dates_calendar_system_islamiccalendar',
  CalendarSystem.PERSIANYAZDEGARDCALENDAR: 'dates_calendar_system_persiancalendar',
  CalendarSystem.HEBREWCALENDAR: 'dates_calendar_system_hebrewcalendar',
  CalendarSystem.COPTICCALENDAR: 'dates_calendar_system_copticcalendar',
  CalendarSystem.POTRZEBIECALENDAR: 'dates_calendar_system_potrzebiecalendar',
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
final Map<int, String> MONTH_PERSIAN = {
  1: 'Farwardin',
  2: 'Ordibehescht',
  3: 'Chordād',
  4: 'Tir',
  5: 'Mordād',
  6: 'Schahriwar',
  7: 'Mehr',
  8: 'Ābān',
  9: 'Āzar',
  10: 'Déi',
  11: 'Bahman',
  12: 'Esfand'
};
final Map<int, String> MONTH_COPTIC = {
  1: 'Thoth',
  2: 'Paophi',
  3: 'Athyr',
  4: 'Cohiac',
  5: 'Tybi',
  6: 'Mesir',
  7: 'Phamenoth',
  8: 'Pharmouthi',
  9: 'Pachons',
  10: 'Payni',
  11: 'Epiphi',
  12: 'Mesori'
};
final Map<int, String> MONTH_HEBREW = {
  1: 'Tishri',
  2: 'Heshvan',
  3: 'Kislev',
  4: 'Tevet',
  5: 'Shevat',
  6: 'Adar beth',
  7: 'Adar aleph',
  8: 'Nisan',
  9: 'Iyar',
  10: 'Sivan',
  11: 'Tammuz',
  12: 'Av',
  13: 'Elul'
};
final Map<int, String> MONTH_POTRZEBIE = {
  1: 'Tales',
  2: 'Calculated',
  3: 'To',
  4: 'Drive',
  5: 'You',
  6: 'Humor',
  7: 'In',
  8: 'A',
  9: 'Jugular',
  10: 'Vein',
};

final Map<CalendarSystem, Map<int, String>> MONTH_NAMES = {
  CalendarSystem.ISLAMICCALENDAR: MONTH_ISLAMIC,
  CalendarSystem.PERSIANYAZDEGARDCALENDAR: MONTH_PERSIAN,
  CalendarSystem.HEBREWCALENDAR: MONTH_HEBREW,
  CalendarSystem.COPTICCALENDAR: MONTH_COPTIC,
  CalendarSystem.POTRZEBIECALENDAR: MONTH_POTRZEBIE,
};

final Map<int, String> WEEKDAY_ISLAMIC = {
  1: 'yaum al-ahad',
  2: 'yaum al-ithnayna',
  3: 'yaum ath-thalatha',
  4: 'yaum al-arba`a',
  5: 'yaum al-chamis',
  6: 'yaum al-dschum`a',
  7: 'yaum as-sabt'
};

final Map<int, String> WEEKDAY_PERSIAN = {
  1: 'Schambé',
  2: 'yek – Schambé',
  3: 'do – Schambé',
  4: 'ße – Schambé',
  5: 'tschahár – Schambé',
  6: 'pansch – Schambé',
  7: 'Djomé'
};

final Map<int, String> WEEKDAY_HEBREW = {
  1: 'Jom Rischon',
  2: 'Jom Scheni',
  3: 'Jom Schlischi',
  4: 'Jom Revi’i',
  5: 'Jom Chamischi',
  6: 'Jom Schischi',
  7: 'Schabbat'
};

int intPart(double floatNum) {
  if (floatNum < -0.0000001)
    return (floatNum - 0.0000001).ceil();
  else
    return (floatNum + 0.0000001).floor();
}

double JulianDateToModifedJulianDate(double jd) {
  return jd - 2400000.5;
}

double ModifedJulianDateToJulianDate(double mjd) {
  return mjd + 2400000.5;
}

int JulianDateToJulianDayNumber(double jd) {
  return jd.floor();
}

int Weekday(double JD) {
  return 1 + (JD + 0.5).floor() % 7;
}

int JulianDay(DateTime date) {
  return 1 + (GregorianCalendarToJulianDate(date) - GregorianCalendarToJulianDate(DateTime(date.year, 1, 1))).toInt();
}

DateTime JulianDateToIslamicCalendar(double jd) {
  int l = (jd + 0.5).floor() - 1948440 + 10632;
  int n = intPart((l - 1) / 10631);
  l = l - 10631 * n + 354;
  int j =
      (intPart((10985 - l) / 5316)) * (intPart((50 * l) / 17719)) + (intPart(l / 5670)) * (intPart((43 * l) / 15238));
  l = l - (intPart((30 - j) / 15)) * (intPart((17719 * j) / 50)) - (intPart(j / 16)) * (intPart((15238 * j) / 43)) + 29;
  int m = intPart((24 * l) / 709);
  int d = l - intPart((709 * m) / 24);
  int y = 30 * n + j - 30;

  return DateTime(y, m , d);
}

double IslamicCalendarToJulianDate(DateTime date) {
  int d = date.day;
  int m = date.month;
  int y = date.year;
  return (intPart((11 * y + 3) / 30) + 354 * y + 30 * m - intPart((m - 1) / 2) + d + 1948440 - 385).toDouble();
}

DateTime JulianDateToPersianYazdegardCalendar(double jd) {
  int epagflg = 0; // Epagomenai: Change at 1007 Jul./376 Yaz.
  int epag_change = 2088938;
  int d_diff = intPart(jd + 0.5) - 1952063;
  int y = intPart(d_diff / 365) + 1;
  int y_diff = d_diff - (y - 1) * 365;
  int epalim = 240;
  if ((jd > epag_change && epagflg == 0) || (epagflg == 2)) {
    epalim = 360;
  }
  int m = intPart((y_diff - intPart(y_diff / epalim) * 5) / 30) + 1;
  int d = y_diff - (m - 1) * 30 - intPart(y_diff / (epalim + 5)) * 5 + 1;
  return DateTime(y, m, d);
}

double PersianYazdegardCalendarToJulianDate(DateTime date) {
  int epagflg = 0; // Epagomenai: Change at 1007 Jul./376 Yaz.
  int yaz_ep = 1951668;
  int m = date.month;
  int d = date.day;
  int y = date.year;
  if (m > 8 && ((y < 376 && epagflg == 0) || (epagflg == 1))) {
    yaz_ep = yaz_ep + 5; // days increased by Epagomenai
  }
  return (yaz_ep + d - 1 + m * 30 + y * 365).toDouble();
}

final List<int> _jregyeardef = [30, 29, 29, 29, 30, 29, 30, 29, 30, 29, 30, 29];
final List<int> _jregyearreg = [30, 29, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29];
final List<int> _jregyearcom = [30, 30, 30, 29, 30, 29, 30, 29, 30, 29, 30, 29];

final List<int> _jembyeardef = [30, 29, 29, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29];
final List<int> _jembyearreg = [30, 29, 30, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29];
final List<int> _jembyearcom = [30, 30, 30, 29, 30, 30, 29, 30, 29, 30, 29, 30, 29];

String typeOfJewYear(int yearlength) {
  if (yearlength == 353) {
    return "common, deficient";
  } else if (yearlength == 354) {
    return "common, regular";
  } else if (yearlength == 355) {
    return "common, complete";
  } else if (yearlength == 383) {
    return "embolistic, deficient";
  } else if (yearlength == 384) {
    return "embolistic, regular";
  } else if (yearlength == 385) {
    return "embolistic, complete";
  } else
    return ("common");
}

List<int> jewDayAndMonthInYear(int days, yearlength) {
  List<int> mschema = _jregyeardef;
  if (yearlength == 353) {
    mschema = _jregyeardef;
  } else if (yearlength == 354) {
    mschema = _jregyearreg;
  } else if (yearlength == 355) {
    mschema = _jregyearcom;
  } else if (yearlength == 383) {
    mschema = _jembyeardef;
  } else if (yearlength == 384) {
    mschema = _jembyearreg;
  } else if (yearlength == 385) {
    mschema = _jembyearcom;
  }

  var oldSum = days;
  var newSum = days;
  var i = 0;
  while (newSum > 0) {
    oldSum = newSum;
    newSum = oldSum - mschema[i];
    i = i + 1;
  }
  List<int> resArr = [1, 1];
  resArr[0] = oldSum + 1;
  if (i == 0) i = 1;

  resArr[1] = i;
  return resArr;
}

int daysInJewYear(int d, m, yearlength) {
  List<int> mschema = _jregyeardef;
  if (yearlength == 353) {
    mschema = _jregyeardef;
  } else if (yearlength == 354) {
    mschema = _jregyearreg;
  } else if (yearlength == 355) {
    mschema = _jregyearcom;
  } else if (yearlength == 383) {
    mschema = _jembyeardef;
  } else if (yearlength == 384) {
    mschema = _jembyearreg;
  } else if (yearlength == 385) {
    mschema = _jembyearcom;
  }
  int i = 0;
  int days = 0;
  while (i < m - 1) {
    days = days + mschema[i];
    i = i + 1;
  }
  return days + d;
}

int cyear2pesach(int xx) {
  int cc = (0.01 * xx).floor();
  int ss = (0.25 * (3 * cc - 5)).floor();
  if (xx < 1583) {
    ss = 0;
  }
  int aa = xx + 3760;
  int a = (12 * xx + 12) % 19;
  int b = xx % 4;
  double qq = -1.904412361576 + 1.554241796621 * a + 0.25 * b - 0.003177794022 * xx + ss;
  int j = ((qq).floor() + 3 * xx + 5 * b + 2 - ss) % 7;
  double r = qq - (qq).floor();
  int dd = (qq).floor() + 22;
  if (j == 2 || j == 4 || j == 6)
    dd = (qq).floor() + 23;
  else if (j == 1 && a > 6 && r >= 0.632870370)
    dd = (qq).floor() + 24;
  else if (j == 0 && a > 11 && r >= 0.897723765) dd = (qq).floor() + 23;
  return dd;
}

int JewishYearLength(double jd) {
  DateTime GregorianDate = JulianDateToGregorianCalendar(jd);
  int jyearlength = 0;
  int cy = GregorianDate.year;
  int pd = cyear2pesach(cy);
  int pm = 3;
  if (pd > 31) {
    pd = pd - 31;
    pm = 4;
  }
  int pjd = (GregorianCalendarToJulianDate(DateTime(cy, pm, pd)) + 0.5).floor();
  int jnyjd = pjd + 163;
  int jy = cy + 3761;
  if (jd < jnyjd) {
    jy = jy - 1;
    int pdprev = cyear2pesach(cy - 1);
    int pmprev = 3;
    if (pdprev > 31) {
      pdprev = pdprev - 31;
      pmprev = 4;
    }
    int pjdprev = (GregorianCalendarToJulianDate(DateTime(cy - 1, pmprev, pdprev)) + 0.5).floor();

    jyearlength = pjd - pjdprev;
  } else {
    int pdnext = cyear2pesach(cy + 1);
    int pmnext = 3;
    if (pdnext > 31) {
      pdnext = pdnext - 31;
      pmnext = 4;
    }
    int pjnext = (GregorianCalendarToJulianDate(DateTime(cy + 1, pmnext, pdnext)) + 0.5).floor();

    jyearlength = pjnext - pjd;
  }

  return jyearlength;
}

DateTime JulianDateToHebrewCalendar(double jd) {
  int jday = 1;
  int jmonth = 1;
  DateTime GregorianDate = JulianDateToGregorianCalendar(jd);
  int cy = GregorianDate.year;
  int pd = cyear2pesach(cy);
  int pm = 3;
  if (pd > 31) {
    pd = pd - 31;
    pm = 4;
  }
  int pjd = (GregorianCalendarToJulianDate(DateTime(cy, pm, pd)) + 0.5).floor();
  int jnyjd = pjd + 163;

  int jy = cy + 3761;

  if (jd < jnyjd) {
    jy = jy - 1;
    int pdprev = cyear2pesach(cy - 1);
    int pmprev = 3;
    if (pdprev > 31) {
      pdprev = pdprev - 31;
      pmprev = 4;
    }
    int pjdprev = (GregorianCalendarToJulianDate(DateTime(cy - 1, pmprev, pdprev)) + 0.5).floor();

    int jyearlength = pjd - pjdprev;
    int days = (jd + 0.5).floor() - pjdprev - 163;
    List<int> dateArr = jewDayAndMonthInYear(days, jyearlength);
    jmonth = dateArr[1];
    jday = dateArr[0];
  } else {
    int pdnext = cyear2pesach(cy + 1);
    int pmnext = 3;
    if (pdnext > 31) {
      pdnext = pdnext - 31;
      pmnext = 4;
    }
    int pjnext = (GregorianCalendarToJulianDate(DateTime(cy + 1, pmnext, pdnext)) + 0.5).floor();

    int jyearlength = pjnext - pjd;
    int days = (jd + 0.5).floor() - pjd - 163;
    List<int> dateArr = jewDayAndMonthInYear(days, jyearlength);
    jmonth = dateArr[1];
    jday = dateArr[0];
  }

  return DateTime(jy, jmonth, jday);
}

double HebrewCalendarToJulianDate(DateTime date) {
  int jy = date.year;
  int m = date.month;
  int d = date.day;
  int cy = jy - 3761;
  int pd = cyear2pesach(cy);
  int pm = 3;
  if (pd > 31) {
    pd = pd - 31;
    pm = 4;
  }
  int pjd = (GregorianCalendarToJulianDate(DateTime(cy, pm, pd)) + 0.5).floor();
  int jnyjd = pjd + 163;
  int pdnext = cyear2pesach(cy + 1);
  int pmnext = 3;
  if (pdnext > 31) {
    pdnext = pdnext - 31;
    pmnext = 4;
  }
  int pjnext = (GregorianCalendarToJulianDate(DateTime(cy + 1, pmnext, pdnext)) + 0.5).floor();
  int jyearlength = pjnext - pjd;

  int days = daysInJewYear(d, m, jyearlength);
  int cjd = jnyjd + days - 1;
  return (cjd).toDouble();
}

DateTime JulianDateToCopticCalendar(double jd) {
  int cop_j_bar = (jd + 0.5).floor() + 124;

  int cop_y_bar = intPart((4 * cop_j_bar + 3) / 1461);
  int cop_t_bar = intPart(((4 * cop_j_bar + 3) % 1461) / 4);
  int cop_m_bar = intPart((1 * cop_t_bar + 0) / 30);
  int cop_d_bar = intPart(((1 * cop_t_bar + 0) % 30) / 1);
  int cop_d = cop_d_bar + 1;
  int cop_m = (cop_m_bar + 1 - 1) % 13 + 1;
  int cop_y = cop_y_bar - 4996 + intPart((13 + 1 - 1 - cop_m) / 13);
  return DateTime(cop_y, cop_m, cop_d);
}

double CopticCalendarToJulianDate(DateTime date) {
  int cop_d = date.day;
  int cop_m = date.month;
  int cop_y = date.year;

  int cop_y_bar = cop_y + 4996 - intPart((13 + 1 - 1 - cop_m) / 13);
  int cop_m_bar = (cop_m - 1 + 13) % 13;
  int cop_d_bar = cop_d - 1;

  int c = intPart((1461 * cop_y_bar + 0) / 4);
  int d = intPart((30 * cop_m_bar + 0) / 1);
  return (c + d + cop_d_bar - 124).toDouble();
}

class PotrzebieCalendarOutput{
  DateTime date;
  String suffix;

  PotrzebieCalendarOutput(this.date, this.suffix);
}

PotrzebieCalendarOutput JulianDateToPotrzebieCalendar(double jd) {
// Day 0 in the Potrzebie-System is 01.10.1952
// Before MAD - B.M.   -   zero   -   Cowzofski Madi C.M
  double jd_p_zero = GregorianCalendarToJulianDate(DateTime(1952, 10, 1));
  int diff = (jd - jd_p_zero).round();
  bool bm = (diff < 0);
  if (diff < 0) diff = diff * -1;
  int cow = diff ~/ 100;
  int mingo = 1 + (diff % 100) ~/ 10;
  int clarke = 1 + (diff % 100) % 10;

  var suffix = bm ? 'B.M.' : 'C.M.';
  return PotrzebieCalendarOutput(DateTime(cow, mingo, clarke), suffix);
}

double PotrzebieCalendarToJulianDate(DateTime date) {
  int p_d = date.day;
  int p_m = date.month;
  int p_y = date.year;

  int days = p_y * 100 + p_m * 10 + p_d;

  double jd_p_zero = GregorianCalendarToJulianDate(DateTime(1952, 10, 1)).floorToDouble() - 1;

  return jd_p_zero + days;
}