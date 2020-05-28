import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:latlong/latlong.dart';

final double _k0 = 0.9996;
final double _drad = PI / 180.0;

UTMREF latLonToUTM(LatLng coord, Ellipsoid ells) {
  double a = ells.a;
  double b = ells.b;
  double e = ells.e;
  double lat = coord.latitude;
  double lon = coord.longitude;

  double phi = lat * _drad;

  UTMZone utmZone = getZone(coord);

  int zcm = 3 + 6 * (utmZone.lonZone - 1) - 180;
  double esq = (1 - (b / a) * (b / a));
  double e0sq = e * e / (1 - e * e);
  double N = a / sqrt(1 - pow(e * sin(phi), 2));
  double C = e0sq * pow(cos(phi), 2);
  double T = pow(tan(phi), 2);
  double A = (lon - zcm) * _drad * cos(phi);
  double M = phi * (1 - esq * (1 / 4.0 + esq * (3 / 64.0 + 5 * esq / 256.0)));
  M = M - sin(2 * phi) * (esq * (3 / 8.0 + esq * (3 / 32.0 + 45 * esq / 1024.0)));
  M = M + sin(4 * phi) * (esq * esq * (15 / 256.0 + esq * 45 / 1024.0));
  M = M - sin(6 * phi) * (esq * esq * esq * (35 / 3072.0));
  M = M * a;
  int M0 = 0;

  double easting = _k0 * N * A * (1 + A * A *((1 - T + C) / 6.0 + A * A * (5 - 18 * T + T * T + 72 * C - 58 * e0sq) / 120.0));
  easting = easting + 500000.0;

  double northing = _k0 * (M - M0 + N * tan(phi) * (A * A * (1 / 2.0 + A * A *((5 - T + 9 * C + 4 * C * C) / 24.0 + A * A *(61 - 58 * T + T * T + 600 * C - 330 * e0sq) / 720.0))));

  if (northing < 0){
    northing = 10000000.0 + northing;
  }

  return UTMREF(utmZone, easting, northing);
}

LatLng UTMREFtoLatLon(UTMREF coord, Ellipsoid ells) {

  double a = ells.a;
  double b = ells.b;
  double e = ells.e;

  double esq = (1.0 - (b / a) * (b / a));
  double e0sq = e * e / (1.0  - e * e);

  int zcm = 3 + 6 * (coord.zone.lonZone - 1) - 180;
  double e1 = (1.0 - sqrt(1.0 - e * e)) / (1.0 + sqrt(1.0 - e * e));

  double y = coord.northing;

  if (coord.hemisphere == HemisphereLatitude.South) {
    y -= 10000000.0;
  }

  double M = y / _k0;

  double mu = M / (a * (1.0 - esq * ( 1.0 / 4.0 + esq * (3.0 / 64.0 + 5.0 * esq / 256.0))));
  double phi1 = mu + e1*(3.0 / 2.0 - 27.0 * e1 * e1 / 32.0) * sin( 2.0 * mu) + e1 * e1 * (21.0 / 16.0 - 55.0 * e1 * e1 / 32.0) * sin(4.0 * mu);
  phi1 = phi1 + e1 * e1 * e1 * (sin(6.0 * mu) * 151.0 / 96.0 + e1 * sin(8 * mu) * 1097 / 512.0);

  double C1 = e0sq * pow(cos(phi1), 2.0);
  double T1 = pow(tan(phi1), 2.0);
  double N1 = a / sqrt(1.0 - pow(e * sin(phi1), 2.0));
  double R1 = N1 * (1.0 - e * e) / (1 - pow(e * sin(phi1), 2.0));
  double D = (coord.easting - 500000.0)/(N1 * _k0);

  double phi = (D * D) * (1.0 / 2.0 - D * D * (5.0 + 3.0 * T1 + 10.0 * C1 - 4.0 * C1 * C1 - 9.0 * e0sq) / 24.0);
  phi = phi + pow(D, 6.0) * (61.0 + 90.0 * T1 + 298.0 * C1 + 45.0 * T1 * T1 - 252.0 * e0sq - 3.0 * C1 * C1) / 720.0;
  phi = phi1 - (N1 * tan(phi1) / R1) * phi;
  double lat = phi / _drad;

  double lng = D * (1.0 + D * D * ((-1.0 - 2.0 * T1 - C1) / 6.0 + D * D *(5.0 - 2.0 * C1 + 28.0 * T1 - 3.0 * C1 * C1 + 8.0 * e0sq + 24.0 * T1 * T1) / 120.0))/cos(phi1);

  lng = zcm + lng / _drad;

  return LatLng(lat, lng);
}

UTMZone getZone(LatLng coord) {
  var lat = coord.latitude;
  var lon = coord.longitude;

  var latZone;
  var lonZoneRegular = 1 + ((lon + 180) / 6.0).floor();
  var lonZone = lonZoneRegular;

  if (lon == 180.0)
    lonZone = 60;

  if (lat < -80) {
    latZone = lonZone <= 0 ? 'A' : 'B';
  } else if (lat >= -80 && lat < 72) {
    latZone = ((lat + 80) / 8.0).floor();

    //Special zone, norway
    if (lat >= 56 && lat < 64) {
      if (lon >= 3 && lon < 12)
        lonZone = 32;
    }

    latZone = 'CDEFGHJKLMNPQRSTUVWX'[latZone];

  } else if (lat >= 72 && lat <= 84) {
    latZone = 'X';

    //Special zone, nothern europe/norway
    if (lon >= 0 && lon < 9) {
      lonZone = 31;
    } else if (lon >= 9 && lon < 21) {
      lonZone = 33;
    } else if (lon >= 21 && lon < 33) {
      lonZone = 35;
    } else if (lon >= 33 && lon < 42) {
      lonZone = 37;
    }
  } else {
    latZone = lonZone <= 0 ? 'Y' : 'Z';
  }

  return UTMZone(lonZoneRegular, lonZone, latZone);
}

String latLonToUTMString(LatLng coord, Ellipsoid ells) {
  UTMREF utm = latLonToUTM(coord, ells);
  return '${utm.zone.lonZone} ${utm.hemisphere == HemisphereLatitude.North ? 'N' : 'S'} ${doubleFormat.format(utm.easting)} ${doubleFormat.format(utm.northing)}';
}