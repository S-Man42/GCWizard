import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class ThemeColorsDark extends ThemeColors {
  static const _lightGray = Color(0xFFD8D8D8);
  static const _gray = Color(0x40D8D8D8);
  static const _darkGray = Color(0xFF26282F);

  @override
  ThemeData base() {
    return ThemeData.dark();
  }

  @override
  Color accent() {
    return Colors.orangeAccent;
  }

  @override
  Color focused() {
    return Colors.greenAccent;
  }

  @override
  Color inputBackground() {
    return _darkGray;
  }

  @override
  Color mainFont() {
    return _lightGray;
  }

  @override
  Color outputListOddRows() {
    return _gray;
  }

  @override
  Color popupMenu() {
    // TODO: implement popupMenu
    throw UnimplementedError();
  }

  @override
  Color popupMenuText() {
    return Colors.black;
  }

  @override
  Color primaryBackground() {
    return Color(0xFF33333D);
  }

  @override
  Color symbolTableImageBackground() {
    return Colors.white;
  }

  @override
  Color textFieldHintText() {
    return _gray;
  }

  @override
  Color textFieldSelectionControlBackground() {
    return _darkGray;
  }
}