import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:prefs/prefs.dart';

void initDefaultSettings() {
  if (Prefs.get('coord_default_ellipsoid_type') == null) {
    Prefs.setString('coord_default_ellipsoid_type', EllipsoidType.STANDARD.toString());
    Prefs.setString('coord_default_ellipsoid_name', ELLIPSOID_NAME_WGS84);
  }

  if (Prefs.get('coord_default_format') == null) {
    Prefs.setString('coord_default_format', keyCoordsDEG);
  }

  if (Prefs.get('coord_default_hemisphere_latitude') == null) {
    Prefs.setString('coord_default_hemisphere_latitude', HemisphereLatitude.North.toString());
  }

  if (Prefs.get('coord_default_hemisphere_longitude') == null) {
    Prefs.setString('coord_default_hemisphere_longitude', HemisphereLongitude.East.toString());
  }

  if (Prefs.get('log_keep_entries_in_days') == null) {
    Prefs.setInt('log_keep_entries_in_days', 5);
  }

  if (Prefs.get('font_size') == null) {
    Prefs.setDouble('font_size', 16.0);
  }
}