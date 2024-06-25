part of 'package:gc_wizard/tools/coords/_common/logic/external_libs/pkohut.geoformulas/geoformulas.dart';

/****************************************************************************/
/*  Port of Geoformulas https://github.com/pkohut/GeoFormulas               */
/*  FindLinearRoot.cpp                                                      */
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

double _findLinearRoot(List<double> x, List<double> errArray) {
  double root;

  if (x[0] == x[1]) {
    root = double.nan;
  } else if (errArray[0] == errArray[1]) {
    if (_isNearZero(errArray[0] - errArray[1], epsilon: 1e-15)) {
      root = x[0];
    } else {
      root = double.nan;
    }
  } else {
    root = -errArray[0] * (x[1] - x[0]) / (errArray[1] - errArray[0]) + x[0];
  }

  return root;
}