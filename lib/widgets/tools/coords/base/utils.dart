import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:prefs/prefs.dart';

CoordinateFormat getCoordFormatByKey(String key, {BuildContext context: null}) {
  CoordinateFormat coordFormat = allCoordFormats.firstWhere((coordFormat) => coordFormat.key == key);

  switch (coordFormat.key) {
    case keyCoordsGaussKrueger1:
      coordFormat.name = i18n(context, 'coords_formatconverter_gausskrueger_gk1');
      break;
    case keyCoordsGaussKrueger2:
      coordFormat.name = i18n(context, 'coords_formatconverter_gausskrueger_gk2');
      break;
    case keyCoordsGaussKrueger3:
      coordFormat.name = i18n(context, 'coords_formatconverter_gausskrueger_gk3');
      break;
    case keyCoordsGaussKrueger4:
      coordFormat.name = i18n(context, 'coords_formatconverter_gausskrueger_gk4');
      break;
    case keyCoordsGaussKrueger5:
      coordFormat.name = i18n(context, 'coords_formatconverter_gausskrueger_gk5');
      break;
  }

  return coordFormat;
}

defaultCoordFormat() {
  return Prefs.get('coord_default_format');
}

defaultHemiphereLatitude() {
  return Prefs.getString('coord_default_hemisphere_latitude') == HemisphereLatitude.North.toString() ? 1 : -1;
}

defaultHemiphereLongitude() {
  return Prefs.getString('coord_default_hemisphere_longitude') == HemisphereLongitude.East.toString() ? 1 : -1;
}

defaultEllipsoid() {
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