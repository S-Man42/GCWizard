part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/pkohut.geoformulas/geoformulas.dart';

/****************************************************************************/
/*  Port of Geoformulas https://github.com/pkohut/GeoFormulas               */
/*  GeodesicArcIntercept.cpp                                                */
/****************************************************************************/
/*                                                                          */
/*  Copyright 2008 - 2016 Paul Kohut                                        */
/*  Licensed under the Apache License, Version 2.0 (the "License"); you may */
/*  not use this file except in compliance with the License. You may obtain */
/*  a copy of the License at                                                */
/*                                                                          */
/*  http://www.apache.org/licenses/LICENSE-2.0                              */
/*                                                                          */
/*  Unless required by applicable law or agreed to in writing, software     */
/*  distributed under the License is distributed on an "AS IS" BASIS,       */
/*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or         */
/*  implied. See the License for the specific language governing            */
/*  permissions and limitations under the License.                          */
/*                                                                          */
/****************************************************************************/

List<_LLPoint> _geodesicArcIntercept(_LLPoint pt1, double crs1, _LLPoint center, double radius, double dTol, Ellipsoid ells) {
  double kSphereRadius = ells.sphereRadius;

  final _PerpInterceptReturn perpRet = _perpIntercept(pt1, crs1, center, dTol, ells);
  _LLPoint perpPt = perpRet.coordinate;

  var result = distanceBearing(perpPt.toLatLng(), center.toLatLng(), ells);

  if (result.distance > radius) return [];

  if ((result.distance - radius).abs() < dTol) {
    return [perpPt];
  }

  final double perpDist = result.distance;
  result = distanceBearing(perpPt.toLatLng(), pt1.toLatLng(), ells);

  if (_isApprox(cos(perpDist / kSphereRadius), 0.0, precision: 1e-8)) return [];

  double crs = result.bearingAToBInRadian;
  double dist = kSphereRadius * acos(cos(radius / kSphereRadius) / cos(perpDist / kSphereRadius));
  _LLPoint pt = _LLPoint.fromLatLng(projectionRadian(perpPt.toLatLng(), crs, dist, ells));

  List<_LLPoint> output = [];
  const int nIntersects = 2;
  for (int i = 0; i < nIntersects; i++) {
    result = distanceBearing(center.toLatLng(), pt.toLatLng(), ells);
    final double rcrs = result.bearingBToAInRadian;
    final double dErr = radius - result.distance;

    List<double> distarray = [0.0, 0.0];
    List<double> errarray = [0.0, 0.0];
    distarray[0] = dist;
    errarray[0] = dErr;

    result = distanceBearing(pt.toLatLng(), perpPt.toLatLng(), ells);
    final double bcrs = result.bearingAToBInRadian;

    result = distanceBearing(center.toLatLng(), pt.toLatLng(), ells);
    final double dAngle = (_signAzimuthDifference(result.bearingAToBInRadian, result.bearingBToAInRadian)).abs();
    final double B = (_signAzimuthDifference(bcrs, rcrs) + pi - dAngle).abs();
    final double A = acos(sin(B) * cos(dErr / kSphereRadius).abs());
    double c;
    if (sin(A).abs() < dTol) {
      c = dErr;
    } else if (A.abs() < dTol) {
      c = dErr / cos(B);
    } else {
      c = kSphereRadius * asin(sin(dErr / kSphereRadius) / sin(A));
    }

    dist = dErr > 0 ? dist + c : dist - c;
    pt = _LLPoint.fromLatLng(projectionRadian(perpPt.toLatLng(), crs, dist, ells));
    result = distanceBearing(center.toLatLng(), pt.toLatLng(), ells);
    distarray[1] = dist;
    errarray[1] = radius - result.distance;

    int k = 0;
    while (errarray[1].abs() > dTol && k < 10) {
      dist = _findLinearRoot(distarray, errarray);
      if (dist.isNaN) break;

      pt = _LLPoint.fromLatLng(projectionRadian(perpPt.toLatLng(), crs, dist, ells));
      result = distanceBearing(center.toLatLng(), pt.toLatLng(), ells);
      distarray[0] = distarray[1];
      errarray[0] = errarray[1];
      distarray[1] = dist;
      errarray[1] = radius - result.distance;
      k++;
    }

    output.add(pt);

    crs += pi;
    pt = _LLPoint.fromLatLng(projectionRadian(perpPt.toLatLng(), crs, dist, ells));
    result = distanceBearing(center.toLatLng(), pt.toLatLng(), ells);
    errarray[0] = radius - result.distance;
  }

  return output;
}