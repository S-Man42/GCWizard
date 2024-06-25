part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/pkohut.geoformulas/geoformulas.dart';

/****************************************************************************/
/*  Port of Geoformulas https://github.com/pkohut/GeoFormulas               */
/*  Conversions.h                                                           */
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

bool _isNearZero(double a, {double epsilon = 2e-6}) {
  return (a.abs() < epsilon);
}

bool _isApprox(double a, double b, {double precision = 1e-11}) {
  return (a - b).abs() <= precision * min<double>(a.abs(), b.abs());
}

double _nmToMeters(double dNm) {
  return dNm * 1852.0;
}