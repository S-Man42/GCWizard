import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors_dark.dart';

enum ThemeType {DARK, LIGHT}

abstract class ThemeColors {
  ThemeData base();

  Color mainFont();

  Color primaryBackground();
  Color inputBackground();
  Color accent();
  Color focused();

  Color textFieldSelectionControlBackground();
  Color textFieldHintText();

  Color outputListOddRows();

  Color symbolTableImageBackground();

  Color popupMenu();
  Color popupMenuText();
}

ThemeType type = ThemeType.DARK;

ThemeColors themeColors() {
  switch (type) {
    case ThemeType.DARK: return ThemeColorsDark();
    // case ThemeType.LIGHT: return ThemeColorsLight();
    default: return null;
  }
}