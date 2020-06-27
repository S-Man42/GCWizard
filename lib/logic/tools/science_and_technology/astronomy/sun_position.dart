import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/calsky/astronomy.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/utils.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:latlong/latlong.dart';

class SunPosition {
  double distanceToEarthCenter;
  double distanceToObserver;
  double eclipticLongitude;
  double rightAscension;
  double declination;
  double azimuth;
  double altitude;
  double diameter;
  AstrologicalSigns astrologicalSign;

  SunPosition(LatLng coords, JulianDate julianDate, Ellipsoid ellipsoid) {
    var greenwichSiderealTime = GMST(julianDate.julianDate);
    var localSiderealTime = GMST2LMST(greenwichSiderealTime, coords.longitudeInRad);

    Coor sunPos = sunPosition(
      julianDate.terrestrialDynamicalTime,
      ellipsoid.a / 1000.0,
      coords.latitudeInRad,
      degreesToRadian(localSiderealTime * 15.0),
      true
    );

    eclipticLongitude = radianToDegrees(sunPos.lon);
    rightAscension = radianToDegrees(sunPos.ra) / 15.0;
    declination = radianToDegrees(sunPos.dec);
    azimuth = radianToDegrees(sunPos.az);
    altitude = radianToDegrees(sunPos.alt) + refraction(sunPos.alt);
    astrologicalSign = sunPos.sign;
    diameter = radianToDegrees(sunPos.diameter) * 60.0;
    distanceToEarthCenter = sunPos.distance;

    var sunCart = equPolar2Cart(sunPos.ra, sunPos.dec, sunPos.distance);
    var observerCart = observer2EquCart(coords.longitudeInRad, coords.latitudeInRad, 0, greenwichSiderealTime, ellipsoid);
    distanceToObserver = sqrt(pow(sunCart.x - observerCart.x, 2) + pow(sunCart.y - observerCart.y, 2) + pow(sunCart.z - observerCart.z, 2));
  }
}
//
//main() {
//  JulianDate jd = JulianDate(DateTime(2020, 6, 27, 12, 38, 35), Duration(hours: 2));
//  var s = SunPosition(LatLng(50, 10), jd, getEllipsoidByName(ELLIPSOID_NAME_WGS84));
//
//  print(s.eclipticLongitude);
//  print(s.rightAscension);
//  print(s.declination);
//  print(s.azimuth);
//  print(s.altitude);
//  print(s.astrologicalSign);
//  print(s.diameter);
//  print(s.distanceToEarthCenter);
//  print(s.distanceToObserver);
//}