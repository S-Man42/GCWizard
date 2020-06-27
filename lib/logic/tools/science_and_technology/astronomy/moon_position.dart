import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/calsky/astronomy.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/utils.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:latlong/latlong.dart';

class MoonPosition {
  final LUNATION = 29.530589;

  double distanceToEarthCenter;
  double distanceToObserver;
  double eclipticLongitude;
  double eclipticLatitude;
  double rightAscension;
  double declination;
  double azimuth;
  double altitude;
  double diameter;
  double phase;
  MoonPhases phaseName;
  double age;
  AstrologicalSigns astrologicalSign;
  double illumination;

  MoonPosition(LatLng coords, JulianDate julianDate, Ellipsoid ellipsoid) {
    var greenwichSiderealTime = GMST(julianDate.julianDate);
    var localSiderealTime = GMST2LMST(greenwichSiderealTime, coords.longitudeInRad);

    Coor sunPos = sunPosition(
      julianDate.terrestrialDynamicalTime,
      ellipsoid.a / 1000.0,
      coords.latitudeInRad,
      degreesToRadian(localSiderealTime * 15.0),
      true
    );

    var observerCart = observer2EquCart(coords.longitudeInRad, coords.latitudeInRad, 0, greenwichSiderealTime, ellipsoid);

    Coor moonPos = moonPosition(
      sunPos,
      julianDate.terrestrialDynamicalTime,
      observerCart,
      degreesToRadian(localSiderealTime * 15.0),
      true
    );

    eclipticLongitude = radianToDegrees(moonPos.lon);
    eclipticLatitude = radianToDegrees(moonPos.lat);
    rightAscension = radianToDegrees(moonPos.ra) / 15.0;
    declination = radianToDegrees(moonPos.dec);
    azimuth = radianToDegrees(moonPos.az);
    altitude = radianToDegrees(moonPos.alt) + refraction(moonPos.alt);
    diameter = radianToDegrees(moonPos.diameter) * 60.0;

    distanceToEarthCenter = moonPos.distance;
    var moonCart = equPolar2Cart(moonPos.raGeocentric, moonPos.decGeocentric, moonPos.distance);
    distanceToObserver = sqrt(pow(moonCart.x - observerCart.x, 2) + pow(moonCart.y - observerCart.y, 2) + pow(moonCart.z - observerCart.z, 2));

    astrologicalSign = moonPos.sign;
    illumination = moonPos.phase * 100;
    phaseName = moonPos.moonPhase;
    age = moonPos.moonAge * LUNATION / (2 * pi);
  }
}
//
//main() {
//  JulianDate jd = JulianDate(DateTime(2020, 6, 27, 12, 38, 35), Duration(hours: 2));
//  var s = MoonPosition(LatLng(50, 10), jd, getEllipsoidByName(ELLIPSOID_NAME_WGS84));
//
//  print(s.eclipticLongitude);
//  print(s.eclipticLatitude);
//  print(s.rightAscension);
//  print(s.declination);
//  print(s.azimuth);
//  print(s.altitude);
//  print(s.astrologicalSign);
//  print(s.diameter);
//  print(s.distanceToEarthCenter);
//  print(s.distanceToObserver);
//  print(s.phaseName);
//  print(s.age);
//  print(s.illumination);
//}