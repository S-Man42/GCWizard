/*
 * Dart port of: https://github.com/mitre/geodetic_library (Apache-2.0 license)
 * Copyright 2007-2011 The MITRE Corporation.
 */

part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library.dart';

double _modlon(double x) {
  x = (x >= 0 ? x : x + _M_2PI);
  return _modpos(x + _M_PI, _M_2PI) - _M_PI;
}

double _modcrs(double crs) {
  /* Map [-pi,pi] to [0,2*pi] */
  return _modpos(crs + _M_2PI, _M_2PI);
}

double _modpos(double x, double y) {
  /* returns positive remainder of x/y. */

  x = x % y;
  if (x < 0.0) {
    x = x + y;
  }
  return x;
}

double _findRootSecantMethod(List<double> x, List<double> y) {

  if (x[0] == x[1]) {
    return x[0];
  }
  if (y[0] == 0.0) {
    return x[0];
  }
  if (y[1] == 0.0) {
    return x[1];
  }
  if (y[0] == y[1]) {
    return 0.5 * (x[0] + x[1]);
  }

  return -y[0] * (x[1] - x[0]) / (y[1] - y[0]) + x[0];
}

/*
 *
 * DESCRIPTION:
 * 		This source file contains utility functions that are used for the
 * 		geolib project.  This source does not contain utility functions which are
 * 		strictly used for testing functions in the geolib project.
 *
 */

int _sgn(double x) {
  return x < 0.0 ? -1 : (x > 0.0 ? 1 : 0);
}