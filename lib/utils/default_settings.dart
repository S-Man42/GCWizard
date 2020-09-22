import 'dart:convert';

import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:prefs/prefs.dart';

void initDefaultSettings() {
  if (Prefs.get('alphabetvalues_custom_alphabets') == null) {
    Prefs.setStringList('alphabetvalues_custom_alphabets', []);
  }

  if (Prefs.get('alphabetvalues_default_alphabet') == null) {
    Prefs.setString('alphabetvalues_default_alphabet', alphabetAZ.key);
  }

  if (Prefs.get('app_count_opened') == null) {
    Prefs.setInt('app_count_opened', 1);
  } else {
    Prefs.setInt('app_count_opened', Prefs.getInt('app_count_opened') + 1);
  }

  if (Prefs.get('clipboard_max_items') == null) {
    Prefs.setInt('clipboard_max_items', 10);
  }

  if (Prefs.get('clipboard_keep_entries_in_days') == null) {
    Prefs.setInt('clipboard_keep_entries_in_days', 7);
  }

  var clipboardData = Prefs.getStringList('clipboard_items');
  if (clipboardData == null) {
    Prefs.setStringList('clipboard_items', []);
  } else {
    clipboardData.removeWhere((item) {
      try {
        var created = DateTime.fromMillisecondsSinceEpoch(int.tryParse(jsonDecode(item)['created']));
        return created.isBefore(DateTime.now().subtract(Duration(days: Prefs.get('clipboard_keep_entries_in_days'))));
      } catch(e) {
        return true;
      }
    });
    Prefs.setStringList('clipboard_items', clipboardData);
  }

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

  if (Prefs.get('coord_variablecoordinate_formulas') == null) {
    Prefs.setStringList('coord_variablecoordinate_formulas', []);
  }

  if (Prefs.get('formulasolver_formulas') == null) {
    Prefs.setStringList('formulasolver_formulas', []);
  }

  if (Prefs.get('symboltables_countcolumns_portrait') == null) {
    Prefs.setInt('symboltables_countcolumns_portrait', 6);
  }

  if (Prefs.get('symboltables_countcolumns_landscape') == null) {
    Prefs.setInt('symboltables_countcolumns_landscape', 10);
  }

  if (Prefs.get('tabs_use_default_tab') == null) {
    Prefs.setBool('tabs_use_default_tab', false);
  }

  if (Prefs.get('tabs_default_tab') == null) {
    Prefs.setInt('tabs_default_tab', 0);
  }

  if (Prefs.get('tabs_last_viewed_tab') == null) {
    Prefs.setInt('tabs_last_viewed_tab', 0);
  }

  if (Prefs.get('theme_color') == null) {
    Prefs.setString('theme_color', ThemeType.DARK.toString());
  }

  if (Prefs.get('theme_font_size') == null) {
    Prefs.setDouble('theme_font_size', Prefs.get('font_size') ?? 16.0); //font_size == pre version 1.2.0
  }

  if (Prefs.get('toollist_show_descriptions') == null) {
    Prefs.setBool('toollist_show_descriptions', true);
  }

  if (Prefs.get('toollist_show_examples') == null) {
    Prefs.setBool('toollist_show_examples', true);
  }
}