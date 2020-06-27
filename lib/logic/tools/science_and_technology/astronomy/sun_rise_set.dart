import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/calsky/astronomy.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
import 'package:latlong/latlong.dart';

class SunRiseSet {
  double astronomicalMorning;
  double nauticalMorning;
  double civilMorning;
  double rise;
  double transit;
  double set;
  double civilEvening;
  double nauticalEvening;
  double astronomicalEvening;

  SunRiseSet(LatLng coords, JulianDate julianDate, Duration timezone, Ellipsoid ellipsoid) {
    RiseSet riseSet = sunRise(
      julianDate.julianDateUTCNoon,
      julianDate.deltaT,
      coords.longitudeInRad,
      coords.latitudeInRad,
      timezone.inMinutes / 60.0,
      false,
      ellipsoid
    );

    astronomicalMorning = riseSet.astronomicalTwilightMorning;
    astronomicalEvening = riseSet.astronomicalTwilightEvening;
    civilMorning = riseSet.civilTwilightMorning;
    civilEvening = riseSet.civilTwilightEvening;
    nauticalMorning = riseSet.nauticalTwilightMorning;
    nauticalEvening = riseSet.nauticalTwilightEvening;

    rise = riseSet.rise;
    transit = riseSet.transit;
    set = riseSet.set;
  }
}
//
//main() {
//  JulianDate jd = JulianDate(DateTime(2020, 6, 27, 12, 38, 35), Duration(hours: 2));
////  print(jd.julianDate);
//
//  var s = SunRiseSet(LatLng(50, 10), jd, Duration(hours: 2), getEllipsoidByName(ELLIPSOID_NAME_WGS84));
//
//  print(s.astronomicalMorning);
//  print(s.nauticalMorning);
//  print(s.civilMorning);
//  print(s.rise);
//  print(s.transit);
//  print(s.set);
//  print(s.civilEvening);
//  print(s.nauticalEvening);
//  print(s.astronomicalEvening);
//}