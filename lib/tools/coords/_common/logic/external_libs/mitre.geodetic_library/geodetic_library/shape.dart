/*
 * Dart port of: https://github.com/mitre/geodetic_library (Apache-2.0 license)
 * Copyright 2007-2011 The MITRE Corporation.
 */

part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library.dart';

typedef _LLPointPair = List<_LLPoint>;

class _LLPoint {
  /* Coordinates must be in radians. */
  double latitude; /**< Number representing the latitude. Valid range is \f$[-\pi/2,\pi/2]\f$.
      A positive latitude indicates a position in the northern hemisphere*/
  double longitude; /**< Number representing the longitude.
                          * Valid range is \f$[-\pi,\pi]\f$.  A positive longitude indicates a position in the eastern hemisphere */

  _LLPoint({this.latitude = 0.0, this.longitude = 0.0});

  void set(double dLat, double dLon) {
    latitude = dLat;
    longitude = dLon;
  }

  static _LLPoint fromLatLng(LatLng latlng) {
    return _LLPoint(latitude: latlng.latitudeInRad, longitude: latlng.longitudeInRad);
  }

  LatLng toLatLng() {
    return LatLng(radianToDeg(latitude), radianToDeg(longitude));
  }

  String toString() {
    return latitude.toString() + ", " + longitude.toString();
  }
}

enum _LineType {SEGMENT, SEMIINFINITE, INFINITE}