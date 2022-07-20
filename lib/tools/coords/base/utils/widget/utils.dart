import 'package:gc_wizard/tools/coords/data/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/data/logic/ellipsoid.dart';
import 'package:prefs/prefs.dart';

Map<String, String> defaultCoordFormat() {
  var format = Prefs.get('coord_default_format');
  var subtype = Prefs.get('coord_default_format_subtype');

  if (subtype == null) {
    switch (format) {
      case keyCoordsGaussKrueger:
        subtype = keyCoordsGaussKruegerGK1;
        break;
      case keyCoordsSlippyMap:
        subtype = '10';
        break;
    }
  }

  return {'format': format, 'subtype': subtype};
}

int defaultHemiphereLatitude() {
  return Prefs.getString('coord_default_hemisphere_latitude') == HemisphereLatitude.North.toString() ? 1 : -1;
}

int defaultHemiphereLongitude() {
  return Prefs.getString('coord_default_hemisphere_longitude') == HemisphereLongitude.East.toString() ? 1 : -1;
}

Ellipsoid defaultEllipsoid() {
  String type = Prefs.get('coord_default_ellipsoid_type');

  if (type == EllipsoidType.STANDARD.toString()) {
    return getEllipsoidByName(Prefs.get('coord_default_ellipsoid_name'));
  }

  if (type == EllipsoidType.USER_DEFINED.toString()) {
    double a = Prefs.get('coord_default_ellipsoid_a');
    double invf = Prefs.get('coord_default_ellipsoid_invf');
    return Ellipsoid(null, a, invf, type: EllipsoidType.USER_DEFINED);
  }
}
