import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class ThemeColorsDark extends ThemeColors {
  static const _lightGray = Color(0xFFD8D8D8);
  static const _gray = Color(0x40D8D8D8);
  static const _darkGray = Color(0xFF26282F);

  ThemeData _base;

  @override
  ThemeData base() {
    if (_base == null)
      _base = ThemeData.dark();

    return _base;
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
    return Colors.white;
  }

  @override
  Color outputListOddRows() {
    return _gray;
  }

  @override
  Color dialog() {
    return Colors.orangeAccent;
  }

  @override
  Color dialogText() {
    return Colors.black;
  }

  @override
  Color primaryBackground() {
    return Color(0xFF33333D);
  }

  @override
  Color iconImageBackground() {
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

  @override
  Color switchThumb1() {
    return _lightGray;
  }

  @override
  Color switchTrack1() {
    return _darkGray;
  }

  @override
  Color switchThumb2() {
    return accent();
  }

  @override
  Color switchTrack2() {
    return accent().withOpacity(0.5);
  }

  @override
  Color listSubtitle() {
    return _lightGray;
  }

  @override
  Color sudokuBackground() {
    return Color.fromARGB(255, 85, 85, 85);
  }

  @override
  Color hyperLinkText() {
    return accent();
  }
}