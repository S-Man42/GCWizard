import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors_dark.dart';

enum ThemeType {DARK, LIGHT}

ThemeColors _themeColors;

abstract class ThemeColors {
  ThemeData base();

  Color mainFont();

  Color primaryBackground();
  Color inputBackground();
  Color accent();
  Color focused();

  Color textFieldSelectionControlBackground();
  Color textFieldHintText();
  Color textFieldFill();

  Color switchThumb1();
  Color switchTrack1();
  Color switchThumb2();
  Color switchTrack2();

  Color outputListOddRows();

  Color listSubtitle();

  Color iconImageBackground();

  Color dialog();
  Color dialogText();

  Color sudokuBackground();
}

ThemeType type = ThemeType.DARK;

ThemeColors themeColors({refresh: false}) {
  if (refresh)
    _themeColors = null;

  if (_themeColors != null)
    return _themeColors;

  switch (type) {
    case ThemeType.DARK:
      _themeColors = ThemeColorsDark();
      break;
    // case ThemeType.LIGHT: return ThemeColorsLight();
    default: return null;
  }

  return _themeColors;
}