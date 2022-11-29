import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/astronomie_info/astronomy.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
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
