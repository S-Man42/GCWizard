/***********************************************************************
    Dart port of C++ implementation of
    ======================
    GeographicLib
    ======================

 * Copyright (c) Charles Karney (2012-2022) <charles@karney.com> and licensed
 * under the MIT/X11 License.  For more information, see
 * https://geographiclib.sourceforge.io/
 * https://sourceforge.net/projects/geographiclib/

 **********************************************************************/

part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/net.sf.geographic_lib/geographic_lib.dart';

class _Ellipsoid {
  // : stol_(real(0.01) * sqrt(numeric_limits<real>::epsilon()))
  late double _a;
  late double _f;

  _Ellipsoid(double _a, double _f);

  double get _f1 {
    return 1 - _f;
  }

  double get _f12 {
    return _GeoMath.sq(_f1);
  }

  double get _e2 {
    return _f * (2 - _f);
  }

  double get _es {
    return (_f < 0 ? -1 : 1) * sqrt(_e2.abs());
  }

  double get _e12 {
    return _e2 / (1 - _e2);
  }

  double get _n {
    return _f / (2  - _f);
  }

  double get _b {
    return _a * _f1;
  }

  _TransverseMercator get _tm {
    return _TransverseMercator(_a, _f, 1.0);
  }

  _EllipticFunction get _ell {
    return _EllipticFunction(-_e12);
  }

  // // , _au(_a, _f, real(0), real(1), real(0), real(1), real(1))
  // double get _au {
  //   ???
  // }

  double _Area() {
    return 4 * _GeoMath.pi() *
    ((_GeoMath.sq(_a) + _GeoMath.sq(_b) *
    (_e2 == 0 ? 1 :
    (_e2 > 0 ? _GeoMath.atanh(sqrt(_e2)) : atan(sqrt(-_e2))) /
    sqrt(_e2.abs())))/2);
  }

  double _QuarterMeridian() {
    return _b * _ell.E0();
  }

  double _InverseParametricLatitude(double beta) {
    return _GeoMath.atand(_GeoMath.tand(_GeoMath.LatFix(beta)) / _f1);
  }

  double _InverseRectifyingLatitude(double mu) {
    if ((mu).abs() == _GeoMath.qd) return mu;
    return _InverseParametricLatitude(_ell.Einv(mu * _ell.E0() / _GeoMath.qd) / _GeoMath.degree());
  }

  List<double> RectifyingToConformalCoeffs() {
    return _tm._bet;
  }
}