/*
 * Dart port of: https://github.com/mitre/geodetic_library (Apache-2.0 license)
 * Copyright 2007-2011 The MITRE Corporation.
 */

part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library.dart';

double modlon(double x) {
  x = (x >= 0 ? x : x + M_2PI);
  return modpos(x + M_PI, M_2PI) - M_PI;
}

double modcrs(double crs) {
  /* Map [-pi,pi] to [0,2*pi] */
  return modpos(crs + M_2PI, M_2PI);
}

double modpos(double x, double y) {
  /* returns positive remainder of x/y. */

  x = x % y;
  if (x < 0.0) {
    x = x + y;
  }
  return x;
}