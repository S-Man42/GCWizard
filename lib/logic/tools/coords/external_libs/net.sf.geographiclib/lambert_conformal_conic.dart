import 'dart:math';

import 'package:dart_numerics/dart_numerics.dart';
import 'package:gc_wizard/logic/tools/coords/external_libs/net.sf.geographiclib/geo_math.dart';
import 'package:gc_wizard/logic/tools/coords/external_libs/net.sf.geographiclib/math.dart';

/***********************************************************************
    Dart port of C++ implementation of
    ======================
    GeographicLib
    ======================

 * \file LambertConformalConic.hpp
 * \brief Header for GeographicLib::LambertConformalConic class
 *
 * Copyright (c) Charles Karney (2010, 2011) <charles@karney.com> and licensed
 * under the MIT/X11 License.  For more information, see
 * http://geographiclib.sourceforge.net/
 **********************************************************************/

class LambertConformalConic {

  /**
   * \brief Lambert Conformal Conic Projection
   *
   * Implementation taken from the report,
   * - J. P. Snyder,
   *   <a href="http://pubs.er.usgs.gov/usgspubs/pp/pp1395"> Map Projections: A
   *   Working Manual</a>, USGS Professional Paper 1395 (1987),
   *   pp. 107&ndash;109.
   *
   * This is a implementation of the equations in Snyder except that divided
   * differences have been used to transform the expressions into ones which
   * may be evaluated accurately and that Newton's method is used to invert the
   * projection.  In this implementation, the projection correctly becomes the
   * Mercator_ projection or the polar sterographic projection when the standard
   * latitude is the equator or a pole.  The accuracy of the projections is
   * about 10 nm.
   *
   * The ellipsoid parameters, the standard parallels, and the scale on the
   * standard parallels are set in the constructor.  Internally, the case with
   * two standard parallels is converted into a single standard parallel, the
   * latitude of tangency (also the latitude of minimum scale), with a scale
   * specified on this parallel.  This latitude is also used as the latitude of
   * origin which is returned by LambertConformalConic::OriginLatitude.  The
   * scale on the latitude of origin is given by
   * LambertConformalConic::CentralScale.  The case with two distinct standard
   * parallels where one is a pole is singular and is disallowed.  The central
   * meridian (which is a trivial shift of the longitude) is specified as the
   * \e lon0 argument of the LambertConformalConic::Forward and
   * LambertConformalConic::Reverse functions.  There is no provision in this
   * class for specifying a false easting or false northing or a different
   * latitude of origin.  However these are can be simply included by the
   * calling function.  For example the Pennsylvania South state coordinate
   * system (<a href="http://www.spatialreference.org/ref/epsg/3364/">
   * EPSG:3364</a>) is obtained by:
      \code
      const double
      a = GeographicLib::Constants::WGS84_a<double>(),
      f = 1/298.257222101,                      // GRS80
      lat1 = 40 + 58/60.0, lat2 = 39 + 56/60.0, // standard parallels
      k1 = 1,                                   // scale
      lat0 = 39 + 20/60.0, lon0 =-77 - 45/60.0, // origin
      fe = 600000, fn = 0;                      // false easting and northing
      // Set up basic projection
      const GeographicLib::LambertConformalConic PASouth(a, f, lat1, lat2, k1);
      double x0, y0;
      {
      // Transform origin point
      PASouth.Forward(lon0, lat0, lon0, x0, y0);
      x0 -= fe; y0 -= fn;         // Combine result with false origin
      }
      double lat, lon, x, y;
      // Sample conversion from geodetic to PASouth grid
      std::cin >> lat >> lon;
      PASouth.Forward(lon0, lat, lon, x, y);
      x -= x0; y -= y0;
      std::cout << x << " " << y << "\n";
      // Sample conversion from PASouth grid to geodetic
      std::cin >> x >> y;
      x += x0; y += y0;
      PASouth.Reverse(lon0, x, y, lat, lon);
      std::cout << lat << " " << lon << "\n";
      \endcode
   **********************************************************************/

  double _a, _f, _r, _fm, _e2, _e, _e2m;
  double _sign, _n, _nc, _t0nm1, _scale, _lat0, _k0;
  double _scbet0, _tchi0, _scchi0, _psi0, _nrho0;
  double eps_;
  double epsx_;
  double tol_;
  double ahypover_;
  static final int numit_ = 5;

  static double hyp(double x) {
    return hypot(1.0, x);
  }

  // e * atanh(e * x) = log( ((1 + e*x)/(1 - e*x))^(e/2) ) if f >= 0
  // - sqrt(-e2) * atan( sqrt(-e2) * x)                    if f < 0
  double eatanhe(double x) {
    return _f >= 0 ? _e * GeoMath.atanh(_e * x) : - _e * atan(_e * x);
  }
  // Divided differences
  // Definition: Df(x,y) = (f(x)-f(y))/(x-y)
  // See: W. M. Kahan and R. J. Fateman,
  // Symbolic computation of divided differences,
  // SIGSAM Bull. 33(3), 7-28 (1999)
  // http://dx.doi.org/10.1145/334714.334716
  // http://www.cs.berkeley.edu/~fateman/papers/divdiff.pdf
  //
  // General rules
  // h(x) = f(g(x)): Dh(x,y) = Df(g(x),g(y))*Dg(x,y)
  // h(x) = f(x)*g(x):
  //        Dh(x,y) = Df(x,y)*g(x) + Dg(x,y)*f(y)
  //                = Df(x,y)*g(y) + Dg(x,y)*f(x)
  //                = Df(x,y)*(g(x)+g(y))/2 + Dg(x,y)*(f(x)+f(y))/2
  //
  // hyp(x) = sqrt(1+x^2): Dhyp(x,y) = (x+y)/(hyp(x)+hyp(y))
  static double Dhyp(double x, double y, double hx, double hy) {
    // hx = hyp(x)
    return (x + y) / (hx + hy);
  }

  // sn(x) = x/sqrt(1+x^2): Dsn(x,y) = (x+y)/((sn(x)+sn(y))*(1+x^2)*(1+y^2))
  static double Dsn(double x, double y, double sx, double sy) {
    // sx = x/hyp(x)
    double t = x * y;
    return t > 0
        ? (x + y) * GeoMath.sq( (sx * sy)/t ) / (sx + sy)
        : (x - y != 0 ? (sx - sy) / (x - y) : 1);
  }

  // // Dlog1p(x,y) = log1p((x-y)/(1+y)/(x-y)
  static double Dlog1p(double x, double y) {
    double t = x - y;

    if (t < 0) {
      t = -t;
      y = x;
    }

    return t != 0 ? GeoMath.log1p(t / (1 + y)) / t : 1 / (1 + x);
  }

  // Dexp(x,y) = exp((x+y)/2) * 2*sinh((x-y)/2)/(x-y)
  static double Dexp(double x, double y) {
    double t = (x - y)/2;
    return (t != 0 ? sinh(t)/t : 1.0) * exp((x + y)/2);
  }

  // Dsinh(x,y) = 2*sinh((x-y)/2)/(x-y) * cosh((x+y)/2)
  //   cosh((x+y)/2) = (c+sinh(x)*sinh(y)/c)/2
  //   c=sqrt((1+cosh(x))*(1+cosh(y)))
  //   cosh((x+y)/2) = sqrt( (sinh(x)*sinh(y) + cosh(x)*cosh(y) + 1)/2 )
  static double Dsinh(double x, double y, double sx, double sy, double cx, double cy) {
    // sx = sinh(x), cx = cosh(x)
    double t = (x  - y)/2;
    return (t != 0 ? sinh(t)/t : 1.0) * sqrt((sx * sy + cx * cy + 1) /2);
  }

  // Dasinh(x,y) = asinh((x-y)*(x+y)/(x*sqrt(1+y^2)+y*sqrt(1+x^2)))/(x-y)
  //             = asinh((x*sqrt(1+y^2)-y*sqrt(1+x^2)))/(x-y)
  static double Dasinh(double x, double y, double hx, double hy) {
    // hx = hyp(x)
    double t = x - y;
    return t != 0
        ? GeoMath.asinh(x*y > 0 ? t * (x+y) / (x*hy + y*hx) : x*hy - y*hx) / t
        : 1/hx;
  }

  // Deatanhe(x,y) = eatanhe((x-y)/(1-e^2*x*y))/(x-y)
  double Deatanhe(double x, double y) {
    double t = x - y, d = 1 - _e2 * x * y;
    return t != 0 ? eatanhe(t / d) / t : _e2 / d;
  }

  // /**
  //  * Constructor with a single standard parallel.
  //  *
  //  * @param[in] a equatorial radius of ellipsoid (meters)
  //  * @param[in] f flattening of ellipsoid.  Setting \e f = 0 gives a sphere.
  //  *   Negative \e f gives a prolate ellipsoid.  If \e f > 1, set flattening
  //  *   to 1/\e f.
  //  * @param[in] stdlat standard parallel (degrees), the circle of tangency.
  //  * @param[in] k0 scale on the standard parallel.
  //  *
  //  * An exception is thrown if \e a or \e k0 is not positive or if \e stdlat
  //  * is not in the range [-90, 90].
  //  **********************************************************************/
  // LambertConformalConic(double a, double f, double stdlat, double k0);

// /**
//  * Constructor with two standard parallels.
//  *
//  * @param[in] a equatorial radius of ellipsoid (meters)
//  * @param[in] f flattening of ellipsoid.  Setting \e f = 0 gives a sphere.
//  *   Negative \e f gives a prolate ellipsoid.  If \e f > 1, set flattening
//  *   to 1/\e f.
//  * @param[in] stdlat1 first standard parallel (degrees).
//  * @param[in] stdlat2 second standard parallel (degrees).
//  * @param[in] k1 scale on the standard parallels.
//  *
//  * An exception is thrown if \e a or \e k0 is not positive or if \e stdlat1
//  * or \e stdlat2 is not in the range [-90, 90].  In addition, if either \e
//  * stdlat1 or \e stdlat2 is a pole, then an exception is thrown if \e
//  * stdlat1 is not equal \e stdlat2.
//  **********************************************************************/
// LambertConformalConic(double a, double f, double stdlat1, double stdlat2, double k1);
//
// /**
//  * Constructor with two standard parallels specified by sines and cosines.
//  *
//  * @param[in] a equatorial radius of ellipsoid (meters)
//  * @param[in] f flattening of ellipsoid.  Setting \e f = 0 gives a sphere.
//  *   Negative \e f gives a prolate ellipsoid.  If \e f > 1, set flattening
//  *   to 1/\e f.
//  * @param[in] sinlat1 sine of first standard parallel.
//  * @param[in] coslat1 cosine of first standard parallel.
//  * @param[in] sinlat2 sine of second standard parallel.
//  * @param[in] coslat2 cosine of second standard parallel.
//  * @param[in] k1 scale on the standard parallels.
//  *
//  * This allows parallels close to the poles to be specified accurately.
//  * This routine computes the latitude of origin and the scale at this
//  * latitude.  In the case where \e lat1 and \e lat2 are different, the
//  * errors in this routines are as follows: if \e dlat = abs(\e lat2 - \e
//  * lat1) <= 160<sup>o</sup> and max(abs(\e lat1), abs(\e lat2)) <= 90 -
//  * min(0.0002, 2.2e-6(180 - \e dlat), 6e-8\e dlat<sup>2</sup>) (in
//  * degrees), then the error in the latitude of origin is less than
//  * 4.5e-14<sup>o</sup> and the relative error in the scale is less than
//  * 7e-15.
//  **********************************************************************/
// LambertConformalConic(double a, double f,
// double sinlat1, double coslat1,
// double sinlat2, double coslat2,
// double k1);
//
// /**
//  * Set the scale for the projection.
//  *
//  * @param[in] lat (degrees).
//  * @param[in] k scale at latitude \e lat (default 1).
//  *
//  * This allows a "latitude of true scale" to be specified.  An exception is
//  * thrown if \e k is not positive or if \e stdlat is not in the range [-90,
//  * 90]
//  **********************************************************************/
// void SetScale(double lat, double k = double(1));
//
// /**
//  * Forward projection, from geographic to Lambert conformal conic.
//  *
//  * @param[in] lon0 central meridian longitude (degrees).
//  * @param[in] lat latitude of point (degrees).
//  * @param[in] lon longitude of point (degrees).
//  * @param[out] x easting of point (meters).
//  * @param[out] y northing of point (meters).
//  * @param[out] gamma meridian convergence at point (degrees).
//  * @param[out] k scale of projection at point.
//  *
//  * The latitude origin is given by LambertConformalConic::LatitudeOrigin().
//  * No false easting or northing is added and \e lat should be in the range
//  * [-90, 90]; \e lon and \e lon0 should be in the range [-180, 360].  The
//  * error in the projection is less than about 10 nm (true distance) and the
//  * errors in the meridian convergence and scale are consistent with this.
//  * The values of \e x and \e y returned for points which project to
//  * infinity (i.e., one or both of the poles) will be large but finite.
//  **********************************************************************/
// void Forward(double lon0, double lat, double lon,
// double& x, double& y, double& gamma, double& k) const throw();
//
// /**
//  * Reverse projection, from Lambert conformal conic to geographic.
//  *
//  * @param[in] lon0 central meridian longitude (degrees).
//  * @param[in] x easting of point (meters).
//  * @param[in] y northing of point (meters).
//  * @param[out] lat latitude of point (degrees).
//  * @param[out] lon longitude of point (degrees).
//  * @param[out] gamma meridian convergence at point (degrees).
//  * @param[out] k scale of projection at point.
//  *
//  * The latitude origin is given by LambertConformalConic::LatitudeOrigin().
//  * No false easting or northing is added.  \e lon0 should be in the range
//  * [-180, 360].  The value of \e lon returned is in the range [-180, 180).
//  * The error in the projection is less than about 10 nm (true distance) and
//  * the errors in the meridian convergence and scale are consistent with
//  * this.
//  **********************************************************************/
// void Reverse(double lon0, double x, double y,
// double& lat, double& lon, double& gamma, double& k) const throw();
//
// /**
//  * LambertConformalConic::Forward without returning the convergence and
//  * scale.
//  **********************************************************************/
// void Forward(double lon0, double lat, double lon,
// double& x, double& y) const throw() {
// double gamma, k;
// Forward(lon0, lat, lon, x, y, gamma, k);
// }
//
// /**
//  * LambertConformalConic::Reverse without returning the convergence and
//  * scale.
//  **********************************************************************/
// void Reverse(double lon0, double x, double y,
// double& lat, double& lon) const throw() {
// double gamma, k;
// Reverse(lon0, x, y, lat, lon, gamma, k);
// }
//
// /** \name Inspector functions
//  **********************************************************************/
// ///@{
// /**
//  * @return \e a the equatorial radius of the ellipsoid (meters).  This is
//  *   the value used in the constructor.
//  **********************************************************************/
// double MajorRadius() const throw() { return _a; }
//
// /**
//  * @return \e f the  flattening of the ellipsoid.  This is the
//  *   value used in the constructor.
//  **********************************************************************/
// double Flattening() const throw() { return _f; }
//
// /**
//  * <b>DEPRECATED</b>
//  * @return \e r the inverse flattening of the ellipsoid.
//  **********************************************************************/
// double InverseFlattening() const throw() { return _r; }
//
// /**
//  * @return latitude of the origin for the projection (degrees).
//  *
//  * This is the latitude of minimum scale and equals the \e stdlat in the
//  * 1-parallel constructor and lies between \e stdlat1 and \e stdlat2 in the
//  * 2-parallel constructors.
//  **********************************************************************/
// double OriginLatitude() const throw() { return _lat0; }
//
// /**
//  * @return central scale for the projection.  This is the scale on the
//  *   latitude of origin.
//  **********************************************************************/
// double CentralScale() const throw() { return _k0; }
// ///@}
//
// /**
//  * A global instantiation of LambertConformalConic with the WGS84
//  * ellipsoid, \e stdlat = 0, and \e k0 = 1.  This degenerates to the
//  * Mercator_ projection.
//  **********************************************************************/
// static const LambertConformalConic Mercator;
// };

  GeographicLibLambert Forward(double lon0, double lat, double lon) {
    if (lon - lon0 >= 180)
      lon -= lon0 + 360;
    else if (lon - lon0 < -180)
      lon -= lon0 - 360;
    else
      lon -= lon0;

    lat *= _sign;
    // From Snyder, we have
    //
    // theta = n * lambda
    // x = rho * sin(theta)
    //   = (nrho0 + n * drho) * sin(theta)/n
    // y = rho0 - rho * cos(theta)
    //   = nrho0 * (1-cos(theta))/n - drho * cos(theta)
    //
    // where nrho0 = n * rho0, drho = rho - rho0
    // and drho is evaluated with divided differences
    double lam = lon * GeoMath.degree(),
    phi = lat * GeoMath.degree(),
    sphi = sin(phi), cphi = lat.abs() != 90 ? cos(phi) : epsx_,
    tphi = sphi/cphi, tbet = _fm * tphi, scbet = hyp(tbet),
    scphi = 1/cphi, shxi = sinh(eatanhe(sphi)),
    tchi = hyp(shxi) * tphi - shxi * scphi, scchi = hyp(tchi),
    psi = GeoMath.asinh(tchi),
    theta = _n * lam, stheta = sin(theta), ctheta = cos(theta),
    dpsi = Dasinh(tchi, _tchi0, scchi, _scchi0) * (tchi - _tchi0),
    drho = - _scale * (2 * _nc < 1 && dpsi != 0
        ? (exp(GeoMath.sq(_nc)/(1 + _n) * psi ) * (tchi > 0 ? 1/(scchi + tchi) : (scchi - tchi)) - (_t0nm1 + 1))/(-_n)
        : Dexp(-_n * psi, -_n * _psi0) * dpsi);

    var x = (_nrho0 + _n * drho) * (_n != 0 ? stheta / _n : lam);
    var y = _nrho0 * (_n != 0 ? (ctheta < 0 ? 1 - ctheta : GeoMath.sq(stheta)/(1 + ctheta)) / _n : 0) - drho * ctheta;
    var k = _k0 * (scbet/_scbet0) / (exp( - (GeoMath.sq(_nc)/(1 + _n)) * dpsi ) * (tchi >= 0 ? scchi + tchi : 1 / (scchi - tchi)) / (_scchi0 + _tchi0));
    y *= _sign;
    var gamma = _sign * theta / GeoMath.degree();

    return GeographicLibLambert(x, y, gamma, k);
  }

  GeographicLibLambertLatLon Reverse(double lon0, double x, double y) {
    // From Snyder, we have
    //
    //        x = rho * sin(theta)
    // rho0 - y = rho * cos(theta)
    //
    // rho = hypot(x, rho0 - y)
    // drho = (n*x^2 - 2*y*nrho0 + n*y^2)/(hypot(n*x, nrho0-n*y) + nrho0)
    // theta = atan2(n*x, nrho0-n*y)
    //
    // From drho, obtain t^n-1
    // psi = -log(t), so
    // dpsi = - Dlog1p(t^n-1, t0^n-1) * drho / scale
    y *= _sign;
    double nx = _n * x, ny = _n * y, y1 = _nrho0 - ny,
    den = GeoMath.hypot(nx, y1) + _nrho0, // 0 implies origin with polar aspect
    drho = den != 0 ? (x*nx - 2*y*_nrho0 + y*ny) / den : 0,
    tnm1 = _t0nm1 + _n * drho/_scale,
    dpsi = (den == 0 ? 0 : (tnm1 + 1 != 0 ? - Dlog1p(tnm1, _t0nm1) * drho / _scale : ahypover_));

    double tchi;
    if (2 * _n <= 1) {
      // tchi = sinh(psi)
      double
      psi = _psi0 + dpsi, tchia = sinh(psi), scchi = hyp(tchia),
      dtchi = Dsinh(psi, _psi0, tchia, _tchi0, scchi, _scchi0) * dpsi;
      tchi = _tchi0 + dtchi;    // Update tchi using divided difference
    } else {
      // tchi = sinh(-1/n * log(tn))
      //      = sinh((1-1/n) * log(tn) - log(tn))
      //      = + sinh((1-1/n) * log(tn)) * cosh(log(tn))
      //        - cosh((1-1/n) * log(tn)) * sinh(log(tn))
      // (1-1/n) = - nc^2/(n*(1+n))
      // cosh(log(tn)) = (tn + 1/tn)/2; sinh(log(tn)) = (tn - 1/tn)/2
      double tn = tnm1 + 1 == 0 ? epsx_ : tnm1 + 1,
      sh = sinh( -GeoMath.sq(_nc)/(_n * (1 + _n)) * (2 * tn > 1 ? GeoMath.log1p(tnm1) : log(tn)) );
      tchi = sh * (tn + 1/tn)/2 - hyp(sh) * (tnm1 * (tn + 1)/tn)/2;
    }
  
    // Use Newton's method to solve for tphi
    double tphi = tchi,
    stol = tol_ * max(1.0, tchi.abs());
    // min iterations = 1, max iterations = 2; mean = 1.99
    for (int i = 0; i < numit_; ++i) {
    double scphi = hyp(tphi),
    shxi = sinh( eatanhe( tphi / scphi ) ),
    tchia = hyp(shxi) * tphi - shxi * scphi,
    dtphi = (tchi - tchia) * (1 + _e2m * GeoMath.sq(tphi)) /
    ( _e2m * scphi * hyp(tchia) );
    tphi += dtphi;
    if (!(dtphi.abs() >= stol))
      break;
    }
    // log(t) = -asinh(tan(chi)) = -psi
    var gamma = atan2(nx, y1);
    double phi = _sign * atan(tphi),
    scbet = hyp(_fm * tphi), scchi = hyp(tchi),
    lam = _n != 0 ? gamma / _n : x / y1;
    var lat = phi / GeoMath.degree();
    var lon = lam / GeoMath.degree();

    // Avoid losing a bit of accuracy in lon (assuming lon0 is an integer)
    if (lon + lon0 >= 180)
      lon += lon0 - 360;
    else if (lon + lon0 < -180)
      lon += lon0 + 360;
    else
      lon += lon0;

    var k = _k0 * (scbet/_scbet0) / (exp(_nc != 0 ? - (GeoMath.sq(_nc)/(1 + _n)) * dpsi : 0) * (tchi >= 0 ? scchi + tchi : 1 / (scchi - tchi)) / (_scchi0 + _tchi0));
    gamma /= _sign * GeoMath.degree();

    return GeographicLibLambertLatLon(lat, lon, gamma, k);
  }

} // class GeographicLib

class GeographicLibLambert {
  final double x; 
  final double y; 
  final double gamma; 
  final double k;
  
  GeographicLibLambert(this.x, this.y, this.gamma, this.k);
}

class GeographicLibLambertLatLon {
  final double lat;
  final double lon;
  final double gamma;
  final double k;

  GeographicLibLambertLatLon(this.lat, this.lon, this.gamma, this.k);
}
