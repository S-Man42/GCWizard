import 'package:gc_wizard/tools/coords/data/logic/ellipsoid.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/astronomie_info/logic/astronomy.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/logic/julian_date.dart';
import 'package:latlong2/latlong.dart';

class MoonRiseSet {
  double rise;
  double transit;
  double set;

  MoonRiseSet(LatLng coords, JulianDate julianDate, Duration timezone, Ellipsoid ellipsoid) {
    RiseSet riseSet = moonRise(julianDate.julianDateUTCNoon, julianDate.deltaT, coords.longitudeInRad,
        coords.latitudeInRad, timezone.inMinutes / 60.0, false, ellipsoid);

    rise = riseSet.rise;
    transit = riseSet.transit;
    set = riseSet.set;
  }
}
