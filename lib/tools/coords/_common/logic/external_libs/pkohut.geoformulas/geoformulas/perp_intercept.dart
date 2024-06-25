part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/pkohut.geoformulas/geoformulas.dart';

/****************************************************************************/
/*  Port of Geoformulas https://github.com/pkohut/GeoFormulas               */
/*  PerpIntercept.cpp                                                       */
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

_PerpInterceptReturn _perpIntercept(_LLPoint llPt1, double dCrs13, _LLPoint llPt2, double dTol, Ellipsoid ells) {
  double kSphereRadius = ells.sphereRadius;

  _LLPoint pt1 = llPt1;
  _LLPoint pt2 = llPt2;

  var result = distanceBearing(pt1.toLatLng(), pt2.toLatLng(), ells);

  if (result.distance <= dTol) {
    // pt1, pt2 and projected pt3 are all the same;
    return _PerpInterceptReturn(pt1);
  }

  final double dAngle = (_signAzimuthDifference(dCrs13, result.bearingAToBInRadian)).abs();
  double dist13 = kSphereRadius * atan(tan(result.distance / kSphereRadius) * cos(dAngle));

  if (dAngle > pi / 2) {
    _LLPoint newPoint = _LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), dCrs13 + pi, dist13 + _nmToMeters(150.0), ells));
    dist13 = _nmToMeters(150.0);

    result = distanceBearing(newPoint.toLatLng(), pt1.toLatLng(), ells);
    dCrs13 = result.bearingAToBInRadian;
    pt1 = newPoint;
  } else if ((dist13).abs() < _nmToMeters(150.0)) {
    _LLPoint newPoint = _LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), dCrs13 + pi, _nmToMeters(150.0), ells));
    dist13 += _nmToMeters(150.0);

    result = distanceBearing(newPoint.toLatLng(), pt1.toLatLng(), ells);
    dCrs13 = result.bearingAToBInRadian;
    pt1 = newPoint;
  }

  _LLPoint pt3 = _LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), dCrs13, dist13, ells));
  result = distanceBearing(pt3.toLatLng(), pt1.toLatLng(), ells);
  double crs31 = result.bearingAToBInRadian;

  result = distanceBearing(pt3.toLatLng(), pt2.toLatLng(), ells);
  double crs32 = result.bearingAToBInRadian;
  double dist23 = result.distance;

  List<double> errarray = [0.0, 0.0];
  List<double> distarray = [0.0, 0.0];
  errarray[0] = (_signAzimuthDifference(crs31, crs32)).abs() - pi / 2;
  distarray[0] = dist13;
  distarray[1] = (distarray[0] + errarray[0] * dist23).abs();

  pt3 = _LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), dCrs13,  distarray[1], ells));
  result = distanceBearing(pt3.toLatLng(), pt1.toLatLng(), ells);
  crs31 = result.bearingAToBInRadian;

  result = distanceBearing(pt3.toLatLng(), pt2.toLatLng(), ells);
  crs32 = result.bearingAToBInRadian;

  errarray[1] = (_signAzimuthDifference(crs31, crs32)).abs() - pi / 2;

  int k = 0;
  double dError = 0.0;
  while (k == 0 || ((dError > dTol) && (k < 15))) {
    double oldDist13 = dist13;
    dist13 = _findLinearRoot(distarray, errarray);
    if (dist13.isNaN) dist13 = oldDist13;

    pt3 = _LLPoint.fromLatLng(projectionRadian(pt1.toLatLng(), dCrs13, dist13, ells));
    result = distanceBearing(pt3.toLatLng(), pt1.toLatLng(), ells);
    crs31 = result.bearingAToBInRadian;

    result = distanceBearing(pt3.toLatLng(), pt2.toLatLng(), ells);
    dist23 = result.distance;
    crs32 = result.bearingAToBInRadian;

    distarray[0] = distarray[1];
    distarray[1] = dist13;
    errarray[0] = errarray[1];
    errarray[1] = (_signAzimuthDifference(crs31, crs32)).abs() - pi / 2;
    dError = (distarray[1] - distarray[0]).abs();
    k++;
  }

  return _PerpInterceptReturn(pt3, dDistFromPt: dist23, dCrsFromPt: crs32);
}

class _PerpInterceptReturn {
  final _LLPoint coordinate;
  final double dDistFromPt;
  final double dCrsFromPt;

  _PerpInterceptReturn(this.coordinate, {this.dDistFromPt = 0.0, this.dCrsFromPt = 0.0});
}