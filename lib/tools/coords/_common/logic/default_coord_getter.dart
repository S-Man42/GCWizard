import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/lambert.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coord_format_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:prefs/prefs.dart';

const defaultLambertType = CoordFormatKey.LAMBERT93;
const defaultGaussKruegerType = CoordFormatKey.GAUSS_KRUEGER_GK1;
const defaultSlippyZoom = 10.0;

Map<String, String> defaultCoordFormat() {
  var format = Prefs.get(PREFERENCE_COORD_DEFAULT_FORMAT);
  var subtype = Prefs.get(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE);

  var subtypeChanged = false;
  switch (format) {
    case CoordFormatKey.GAUSS_KRUEGER:
      if (![
        CoordFormatKey.GAUSS_KRUEGER_GK1,
        CoordFormatKey.GAUSS_KRUEGER_GK2,
        CoordFormatKey.GAUSS_KRUEGER_GK3,
        CoordFormatKey.GAUSS_KRUEGER_GK4,
        CoordFormatKey.GAUSS_KRUEGER_GK5
      ].contains(subtype)) {
        subtype = getGaussKruegerTypKeyFromCode();
        subtypeChanged = true;
      }
      break;
    case CoordFormatKey.SLIPPY_MAP:
      if (int.tryParse(subtype) == null) {
        subtype = defaultSlippyZoom.toString();
        subtypeChanged = true;
      }
      break;
  }

  if (subtypeChanged) {
    Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE, subtype);
  }

  return {'format': format, 'subtype': subtype};
}

int defaultHemiphereLatitude() {
  return Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE) == HemisphereLatitude.North.toString() ? 1 : -1;
}

int defaultHemiphereLongitude() {
  return Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE) == HemisphereLongitude.East.toString() ? 1 : -1;
}

Ellipsoid defaultEllipsoid() {
  String type = Prefs.get(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE);

  if (type == EllipsoidType.STANDARD.toString()) {
    return getEllipsoidByName(Prefs.get(PREFERENCE_COORD_DEFAULT_ELLIPSOID_NAME));
  }

  if (type == EllipsoidType.USER_DEFINED.toString()) {
    double a = Prefs.get(PREFERENCE_COORD_DEFAULT_ELLIPSOID_A);
    double invf = Prefs.get(PREFERENCE_COORD_DEFAULT_ELLIPSOID_INVF);
    return Ellipsoid(null, a, invf, type: EllipsoidType.USER_DEFINED);
  }
}