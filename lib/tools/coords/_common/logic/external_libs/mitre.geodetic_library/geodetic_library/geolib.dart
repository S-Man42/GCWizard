/*
 * Dart port of: https://github.com/mitre/geodetic_library (Apache-2.0 license)
 * Copyright 2007-2011 The MITRE Corporation.
 */

part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/mitre.geodetic_library/geodetic_library.dart';

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

class GeoArcIntxReturn {
  LLPointPair intx;
  int n;

  GeoArcIntxReturn(this.intx, this.n);
}

GeoArcIntxReturn geoArcIntx(LLPoint pt1, double crs1, LLPoint center, double radius, Ellipsoid ellipsoid) {
  LLPoint perpPt;
  LLPoint newStart;
  int i, k, j = 0;

  double perpDist, perpCrs; // Distance & crs from center to perp. point
  List<double> dist; // Distance from perpendicular point to approx. point
  List<double> crs, bcrs; // Course and backcourse from perp. point to approx point
  double rcrs, brcrs; // Course and backcourse from intx to arc center point
  List<double> distarray, errarray;
  double A, B, c, error, radDist;
  double tempCrs, newCrs; // throw-away course value
  double stepSize = 9.0e99;

  double sphereRad = ellipsoid.sphereRadius;

  int n = 0; /* initialize number of intersections found */
  LLPointPair intx = [];

  /* Handle case if center and pt1 are essentially same point */
  /* Find dist from center to pt1 */
  radDist = distanceBearing(pt1.toLatLng(), center.toLatLng(), ellipsoid).distance;

  if (radDist < TOL) {
    /* center and pt1 are indistinguishable */
    n = 2;

    var intx0 = LLPoint.fromLatLng(projectionRadian(center.toLatLng(), crs1, radius, ellipsoid));
    var intx1 = LLPoint.fromLatLng(projectionRadian(center.toLatLng(), modcrs(crs1 + M_PI), radius, ellipsoid));
    return GeoArcIntxReturn([intx0, intx1], 2);
  }
  else if (radDist < radius) {
    /* pt1 is inside circle, numerical accuracy may not be good */
    /* Move start of line outside circle for better accuracy */
    /* New start will be at least one mile from circle */
    newStart = LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), crs1 + M_PI, 2.0 * radius + 10.0, ellipsoid));

    var distBear = distanceBearing(pt1.toLatLng(), center.toLatLng(), ellipsoid);
    newCrs = distBear.bearingAToBInRadian;
    tempCrs = distBear.bearingBToAInRadian;
    pt1 = newStart;
    crs1 = newCrs;
  }

  /* project center of arc onto geodesic */
  if (err |= projectToGeo(pt1, crs1, center, &perpPt, &perpCrs, &perpDist, tol, eps))
  return err;
  /* calc distance & crs from pt1 to projected point */
  if (err |= invCrs(perpPt, pt1, &crs[0], &bcrs[0], eps))
  return err;
  crs[1] = modcrs(crs[0] + M_PI);

  if (fabs(perpDist - radius) < tol)
  {
  /* Line is tangent to circle */
  *n = 1;
  intx[0] = perpPt;
  return 0;
  }
  else if (perpDist > radius)
  {
  /* no intersections -- line too far from circle */
  *n = 0;
  return err;
  }
  else if (ptsAreSame(perpPt,center,tol))
  {
  /* Line goes through center of arc.  This is a special case where
         * we can project the intersection points directly. Find azimuth of geodesic
         * at arc center, then project out radius distance along this azimuth (in
         * both directions) to find two intersections with arc. */
  double azFromCenter, azToCenter;
  /* Find azimuth of geodesic at arc center */
  err |= inverse(center,pt1,&azFromCenter,&azToCenter,&radDist,eps);
  if (radDist < 100.0/1852.0)
  {
  /* line start is less than 100 meters from center point, so azimuth will not
             * be very precise.  Use precise given azimuth to move start of geodesic farther away
             * and then update pt1 to this location */
  if (fabs(modlon(crs1-azToCenter))<M_PI_2) {
  /* Arc center lies in crs1 direction from pt1, so move pt1 backward 1.0 NM */
  direct(pt1,crs1+M_PI,1.0,&pt1,eps);
  }
  else {
  /* Arc center lies "behind" pt1, so move pt1 forward 1 NM */
  direct(pt1,crs1,1.0,&pt1,eps);
  }
  /* Recompute azimuth */
  err |= inverse(center,pt1,&azFromCenter,&azToCenter,&radDist,eps);
  }

  *n = 2;
  err |= direct(center,azFromCenter,radius,&intx[0],eps);
  err |= direct(center,modcrs(azFromCenter+M_PI),radius,&intx[1],eps);

  return err;

  }

  if (cos(perpDist / sphereRad) > 0)
  {

  dist[0] = sphereRad * acos(cos(radius / sphereRad) / cos(perpDist
  / sphereRad));
  }
  else
  {
  /* Arc and geodesic describe the same great circle.
         * Intersection is entire arc. */
  //        err |= CONCENTRIC_CIRCLE_ERR;
  return err;
  }

  /* move first approximate point to line */
  if (err |= direct(perpPt, crs[0], dist[0], &intx[0], eps))
  return err;

  /* Iterate to improve approximations */

  for (i = 0; i < 2; i++)
  {

  if (i == 1)
  {
  // Use solution to first point to find approximation to second point
  dist[1] = dist[0];
  err |= direct(perpPt, crs[1], dist[1], &intx[1], eps);
  }

  k = 0;
  /* Calculate distance from center to approx. intersection point */
  if (err |= inverse(intx[i], center, &rcrs, &brcrs, &radDist, eps))
  return err;
  /* error in approximation is difference between approx. distance and
         * arc radius */
  error = radius - radDist;

  /* Preload array to enable linear extrapolation/interpolation of
         * solution */
  distarray[1] = dist[i];
  errarray[1] = error;

  /* calculate distance adjustment */
  while ((k == 0) || //force entry to ensure at least one iteration
  (((fabs(error) > tol) || (stepSize > tol)) &&
  (k < MAX_ITERATIONS) ))
  {

  if (k == 0)
  {
  /* On first pass, improve approximation using triangle */
  if (err
  |= invCrs(intx[i], perpPt, &bcrs[i], &tempCrs, eps))
  return err;

  B = fabs(modlon(bcrs[i] - rcrs)); // into range [0,pi]

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
  A = acos(sin(B) * cos(fabs(error) / sphereRad));
  if (fabs(sin(A)) < INTERNAL_ZERO)
  {
  /* case where line is close to diameter */
  c = error;
  }
  else if (fabs(A) < INTERNAL_ZERO)
  {
  /* case where line is nearly tangent */
  //TODO Is this a dead if condition?
  c = error / cos(B);
  }
  else
  {
  /* normal case */
  c = sphereRad * asin(sin(error / sphereRad) / sin(A));
  }

  /* We move in different directions depending on which side of circle we are on */
  if (error > 0)
  {
  /* if intx[i] is inside circle, move away from perpendicular point */
  dist[i] += fabs(c);
  }
  else
  {
  dist[i] -= fabs(c);
  }
  }
  else
  {
  /* Subsequent approximations use linear extrapolation/interpolation */
  /* Can't do this on first pass -- need two points for linear approx */
  dist[i] = findRootSecantMethod(distarray, errarray, &err);
  // DEBUG
  //                 printf("%20.15f, %20.15f, %20.15f, %20.15f, %20.15f \n", distarray[0],
  //                        errarray[0],distarray[1],errarray[1],dist[i]);
  }

  /* Place i-th approximate intersection point on geodesic */
  if (err |= direct(perpPt, crs[i], dist[i], &intx[i], eps))
  return err;
  /* Calculate distance from center of circle to approx. intersection */
  if (err |= inverse(intx[i], center, &rcrs, &brcrs, &radDist,
  eps))
  return err;
  error = radius - radDist;

  /* This function uses the secant root finding method. If the secant method gets
             * stuck crossing back and forth over the root (see bug 33554) we switch to the
             * regula falsi method and insure that the two points used in the method have
             * opposite sign in the errarray. If that gets stuck we switch back to the
             * secant method.
             */
  if((sgn(errarray[0]) == sgn(errarray[1])) || (error == 0) || k < 5 || abs(j) == 2){
  distarray[0] = distarray[1];
  distarray[1] = dist[i];
  errarray[0] = errarray[1];
  errarray[1] = error;
  j = 0;
  } else if (sgn(error) == errarray[0]){
  errarray[0] = error;
  distarray[0] = dist[i];
  j++;
  } else {
  errarray[1] = error;
  distarray[1] = dist[i];
  j--;
  }

  stepSize = fabs(distarray[1] - distarray[0]);

  k++;

  } /* end while */

  if (k >= MAX_ITERATIONS)
  {
  err |= ITERATION_MAX_REACHED_ERR;
//            printf("Error: ITERATION_MAX_REACHED in %s\n",__FUNCTION__);

  }

  if (fabs(error) >= MAX_DISTANCE_ERROR)
  {
  err |= ERROR_MAX_REACHED_ERR;
  }

  *n = *n + 1;

  } /* end for(i) */

  return err;

}