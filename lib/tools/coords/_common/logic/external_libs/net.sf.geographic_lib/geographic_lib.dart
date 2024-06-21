// imports
import 'dart:math';

import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/data_type_utils/double_type_utils.dart';

// parts
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/aux_angle.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/aux_latitude.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/d_aux_latitude.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/ellipsoid.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/elliptic_function.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/geo_math.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/geodesic.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/geodesic_data.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/geodesic_line.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/geodesic_mask.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/intersect.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/lambert_conformal_conic.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/math.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/pair.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/rhumb.dart';
part 'package:gc_wizard/tools/coords/_common/logic//external_libs/net.sf.geographic_lib/geographic_lib/transverse_mercator.dart';


void main() {

  var a = 6378137.0;
  var f = 1/298.257223563;

  var lata = -3.6236782323;
  var lona = -42.4567898765;
  var azia = 50.84710421371222;

  var latb = 13.0151562647;
  var lonb = 63.78912318;
  var azib = 302.6533419640445;

  var _x = Intersect(a, f);
  var x = _x.closest(lata, lona, azia, latb, lonb, azib);

  print(x.first);

  GeodesicData projected = Geodesic(a, f).direct(lata, lona, azia, x.first);
  print(projected.lat2);
  print(projected.lon2);
  

  print(x.second);

  projected = Geodesic(a, f).direct(latb, lonb, azib, x.second);
  print(projected.lat2);
  print(projected.lon2);

}