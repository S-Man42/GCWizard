/*
 * Dart port of: https://github.com/mitre/geodetic_library (Apache-2.0 license)
 * Copyright 2007-2011 The MITRE Corporation.
 */

part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library.dart';

// ignore_for_file: unused_local_variable

/* Calculate points of intersection of arc and geodesic.  The arc is treated as a full
* circle and geodesic is treated as unbounded.  Bounds of either object must
* be applied by the parent function, when applicable.
* @param pt1 Starting point of geodesic (LLPoint)
* @param crs1 Azimuth of geodesic at pt1, in radians (double)
* @param center Center of arc (LLPoint)
* @param radius Radius of arc, in nmi (double)
* @param intx Two-element array of LLPoint objects that will be updated with
*               intersections' coordinates. (LLPointPair*)
* @param n Pointer to number of intersections found (result. 0, 1, or 2) (double*)
* @param tol Accuracy tolerance in nmi (max distance from found solution to true solution) (double)
* @param eps Convergence tolerance for Vincenty forward/inverse algorithms (double)
* @return Returns error code that indicates success or cause of failure; updates given memory
* addresses with calculated values.
* @retval SUCCESS Indicates successful execution.
* @retval CONCENTRIC_CIRCLE_ERR Indicates that two arcs or circles either do not intersect or are identical. Used as a status code.
* @retval TOL_TOO_SMALL_ERR Indicates that the requested tolerance cannot be met due to large requested Vincenty algorithm precision.
* @retval ITERATION_MAX_REACHED_ERR Indicates that a method has looped more than the allowed iteration count.
* @retval ERROR_MAX_REACHED_ERR Indicates that an error value has grown larger than allowed.
 */

List<_LLPoint> _geoArcIntx(_LLPoint pt1, double crs1, _LLPoint center, double radius, double tol, Ellipsoid ellipsoid) {
  _LLPoint perpPt;
  _LLPoint newStart;
  int i, k, j = 0;

  double perpDist, perpCrs; // Distance & crs from center to perp. point
  List<double> dist = [double.nan, double.nan]; // Distance from perpendicular point to approx. point
  List<double> crs = [double.nan, double.nan], bcrs = [double.nan, double.nan]; // Course and backcourse from perp. point to approx point
  double rcrs, brcrs; // Course and backcourse from intx to arc center point
  List<double> distarray = [double.nan, double.nan], errarray = [double.nan, double.nan];
  double A, B, c, error, radDist;
  double tempCrs, newCrs; // throw-away course value
  double stepSize = 9.0e99;

  double sphereRad = ellipsoid.sphereRadius;

  int n = 0; /* initialize number of intersections found */
  _LLPointPair intx = [_LLPoint(), _LLPoint()];

  /* Handle case if center and pt1 are essentially same point */
  /* Find dist from center to pt1 */
  radDist = distanceBearing(pt1.toLatLng(), center.toLatLng(), ellipsoid).distance;

  if (radDist < _TOL) {
    /* center and pt1 are indistinguishable */
    var intx0 = _LLPoint.fromLatLng(projectionRadian(center.toLatLng(), crs1, radius, ellipsoid));
    var intx1 = _LLPoint.fromLatLng(projectionRadian(center.toLatLng(), _modcrs(crs1 + _M_PI), radius, ellipsoid));
    return [intx0, intx1];
  }
  else if (radDist < radius) {
    /* pt1 is inside circle, numerical accuracy may not be good */
    /* Move start of line outside circle for better accuracy */
    /* New start will be at least one mile from circle */
    newStart = _LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), crs1 + _M_PI, 2.0 * radius + 10.0, ellipsoid));

    var distBear = distanceBearing(pt1.toLatLng(), center.toLatLng(), ellipsoid);
    newCrs = distBear.bearingAToBInRadian;
    tempCrs = distBear.bearingBToAInRadian;
    pt1 = newStart;
    crs1 = newCrs;
  }

  /* project center of arc onto geodesic */
  _ProjectToGeoReturn ptGeo = _projectToGeo(pt1, crs1, center, tol, ellipsoid);
  perpPt = ptGeo.pt2;
  perpCrs = ptGeo.crsFromPoint;
  perpDist = ptGeo.distFromPoint;

  /* calc distance & crs from pt1 to projected point */
  var distBear = distanceBearing(perpPt.toLatLng(), pt1.toLatLng(), ellipsoid);
  crs[0] = distBear.bearingAToBInRadian;
  bcrs[0] = distBear.bearingBToAInRadian;
  crs[1] = _modcrs(crs[0] + _M_PI);

  if ((perpDist - radius).abs() < tol) {
    /* Line is tangent to circle */
    return [perpPt];
  } else if (perpDist > radius) {
    /* no intersections -- line too far from circle */
    return <_LLPoint>[];
  } else if (_ptsAreSame(perpPt,center,tol,ellipsoid)) {
    /* Line goes through center of arc.  This is a special case where
           * we can project the intersection points directly. Find azimuth of geodesic
           * at arc center, then project out radius distance along this azimuth (in
           * both directions) to find two intersections with arc. */
    double azFromCenter, azToCenter;
    /* Find azimuth of geodesic at arc center */
    var distBear = distanceBearing(center.toLatLng(), pt1.toLatLng(), ellipsoid);
    azFromCenter = distBear.bearingAToBInRadian;
    azToCenter = distBear.bearingBToAInRadian;
    radDist = _modcrs(crs[0] + _M_PI);

    if (radDist < 100.0) {
      /* line start is less than 100 meters from center point, so azimuth will not
                 * be very precise.  Use precise given azimuth to move start of geodesic farther away
                 * and then update pt1 to this location */
      if ((_modlon(crs1-azToCenter)).abs()<_M_PI_2) {
        /* Arc center lies in crs1 direction from pt1, so move pt1 backward 1.0 NM */
        pt1 = _LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), crs1 + _M_PI, 1.0 * _NMI_IN_METERS, ellipsoid));
      } else {
        /* Arc center lies "behind" pt1, so move pt1 forward 1 NM */
        pt1 = _LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), crs1, 1.0 * _NMI_IN_METERS, ellipsoid));
      }
      /* Recompute azimuth */
      var distBear = distanceBearing(center.toLatLng(), pt1.toLatLng(), ellipsoid);
      azFromCenter = distBear.bearingAToBInRadian;
      azToCenter = distBear.bearingBToAInRadian;
      radDist = _modcrs(crs[0] + _M_PI);
    }

    intx[0] = _LLPoint.fromLatLng(projectionRadian(center.toLatLng(), azFromCenter, radius, ellipsoid));
    intx[1] = _LLPoint.fromLatLng(projectionRadian(center.toLatLng(), _modcrs(azFromCenter+_M_PI), radius, ellipsoid));
    return [intx[0], intx[1]];
  }

  if (cos(perpDist / sphereRad) > 0) {
    dist[0] = sphereRad * acos(cos(radius / sphereRad) / cos(perpDist / sphereRad));
  } else {
    /* Arc and geodesic describe the same great circle.
           * Intersection is entire arc. */
    return <_LLPoint>[];
  }

  /* move first approximate point to line */
  intx[0] = _LLPoint.fromLatLng(projectionRadian(perpPt.toLatLng(), crs[0], dist[0], ellipsoid));

  /* Iterate to improve approximations */
  for (i = 0; i < 2; i++) {

    if (i == 1) {
      // Use solution to first point to find approximation to second point
      dist[1] = dist[0];
      intx[1] = _LLPoint.fromLatLng(projectionRadian(perpPt.toLatLng(), crs[1], dist[1], ellipsoid));
    }

    k = 0;
    /* Calculate distance from center to approx. intersection point */
    var distBear = distanceBearing(intx[i].toLatLng(), center.toLatLng(), ellipsoid);
    rcrs = distBear.bearingAToBInRadian;
    brcrs = distBear.bearingBToAInRadian;
    radDist = _modcrs(crs[0] + _M_PI);
    /* error in approximation is difference between approx. distance and
           * arc radius */
    error = radius - radDist;

    /* Preload array to enable linear extrapolation/interpolation of
           * solution */
    distarray[1] = dist[i];
    errarray[1] = error;

    /* calculate distance adjustment */
    while ((k == 0) || //force entry to ensure at least one iteration
        (((error.abs() > tol) || (stepSize > tol)) &&
            (k < _MAX_ITERATIONS) )) {

      if (k == 0) {
        /* On first pass, improve approximation using triangle */
        var distBear = distanceBearing(intx[i].toLatLng(), perpPt.toLatLng(), ellipsoid);
        bcrs[i] = distBear.bearingAToBInRadian;
        tempCrs = distBear.bearingBToAInRadian;
        B = (_modlon(bcrs[i] - rcrs)).abs(); // into range [0,pi]

        /* C = 90 degrees             |\
                         a = error                  |A\
                         c = length adjustment      |  \
                                                   b|   \c
                       |    \
                                                    |     \
                                                    |90___B\
                                                       a
                       */
        /* Formulae for spherical triangles */
        /* NOTE: this uses a great circle to approximate small portion of
                       * arc near the intersection (side b in diagram). */
        A = acos(sin(B) * cos(error.abs() / sphereRad));
        if ((sin(A)).abs() < _INTERNAL_ZERO) {
          /* case where line is close to diameter */
          c = error;
        } else if (A.abs() < _INTERNAL_ZERO) {
          /* case where line is nearly tangent */
          c = error / cos(B);
        } else {
          /* normal case */
          c = sphereRad * asin(sin(error / sphereRad) / sin(A));
        }

        /* We move in different directions depending on which side of circle we are on */
        if (error > 0) {
          /* if intx[i] is inside circle, move away from perpendicular point */
          dist[i] += c.abs();
        } else {
          dist[i] -= c.abs();
        }

      } else {
        /* Subsequent approximations use linear extrapolation/interpolation */
        /* Can't do this on first pass -- need two points for linear approx */
        dist[i] = _findRootSecantMethod(distarray, errarray);
      }

      /* Place i-th approximate intersection point on geodesic */
      intx[i] = _LLPoint.fromLatLng(projectionRadian(perpPt.toLatLng(), crs[i], dist[i], ellipsoid));
      /* Calculate distance from center of circle to approx. intersection */
      var distBear = distanceBearing(intx[i].toLatLng(), center.toLatLng(), ellipsoid);
      rcrs = distBear.bearingAToBInRadian;
      brcrs = distBear.bearingBToAInRadian;
      radDist = distBear.distance;

      error = radius - radDist;

      /* This function uses the secant root finding method. If the secant method gets
                 * stuck crossing back and forth over the root (see bug 33554) we switch to the
                 * regula falsi method and insure that the two points used in the method have
                 * opposite sign in the errarray. If that gets stuck we switch back to the
                 * secant method.
                 */
      if((_sgn(errarray[0]) == _sgn(errarray[1])) || (error == 0) || k < 5 || j.abs() == 2) {
        distarray[0] = distarray[1];
        distarray[1] = dist[i];
        errarray[0] = errarray[1];
        errarray[1] = error;
        j = 0;
      } else if (_sgn(error) == errarray[0]){
        errarray[0] = error;
        distarray[0] = dist[i];
        j++;
      } else {
        errarray[1] = error;
        distarray[1] = dist[i];
        j--;
      }

      stepSize = (distarray[1] - distarray[0]).abs();

      k++;
    } /* end while */

    n = n + 1;
  } /* end for(i) */

  var out = <_LLPoint>[];
  for (int i = 0; i < n; i++) {
    out.add(intx[i]);
  }

  return out;
}