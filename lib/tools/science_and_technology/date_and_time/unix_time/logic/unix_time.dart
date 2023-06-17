//https://de.wikipedia.org/wiki/Unixzeit

String DateTimeToUnixTime(DateTime currentDateTime) {
  /** Konvertiert gegliederte UTC-Angaben in Unix-Zeit.
   * Parameter und ihre Werte-Bereiche:
   * - jahr [1970..2038]
   * - monat [1..12]
   * - tag [1..31]
   * - stunde [0..23]
   * - minute [0..59]
   * - sekunde [0..59]
   */
  //long long unixzeit(int jahr, int monat, int tag,
  //    int stunde, int minute, int sekunde)
  int jahr = currentDateTime.year;
  int monat = currentDateTime.month;
  int tag = currentDateTime.day;
  int stunde = currentDateTime.hour;
  int minute = currentDateTime.minute;
  int sekunde = currentDateTime.second;

  const tage_seit_jahresanfang = /* Anzahl der Tage seit Jahresanfang ohne Tage des aktuellen Monats und ohne Schalttag */
      [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

  int schaltjahre = (((jahr - 1) - 1968) / 4 /* Anzahl der Schaltjahre seit 1970 (ohne das evtl. laufende Schaltjahr) */
          -
          ((jahr - 1) - 1900) / 100 +
          ((jahr - 1) - 1600) / 400)
      .toInt();

  int tage_seit_1970 = (jahr - 1970) * 365 + schaltjahre + tage_seit_jahresanfang[monat - 1] + tag - 1;

  if ((monat > 2) && (jahr % 4 == 0 && (jahr % 100 != 0 || jahr % 400 == 0))) {
    tage_seit_1970 += 1;
  } /* +Schalttag, wenn jahr Schaltjahr ist */

  return (sekunde + 60 * (minute + 60 * (stunde + 24 * tage_seit_1970))).toString();
}

String UnixTimeToDateTime(int unixtime) {
  return DateTime(1970, 1, 1, 0, 0, 0).add(Duration(seconds: unixtime)).toString() + ' UTC 0' ;
}
