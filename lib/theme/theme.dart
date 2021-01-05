import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

final FONT_SIZE_MIN = 10;
final FONT_SIZE_MAX = 30;

final DEFAULT_MARGIN = 2.0;
final DOUBLE_DEFAULT_MARGIN = 2 * DEFAULT_MARGIN;
final DEFAULT_DESCRIPTION_MARGIN = 10.0;

final DEFAULT_LISTITEM_SIZE = 42.0;
final DEFAULT_POPUPBUTTON_SIZE = 40.0;

TextStyle gcwTextStyle() {
 return TextStyle(
   color: themeColors().mainFont(),
   fontSize: defaultFontSize(),
   fontFamily: 'Roboto Condensed'
 );
}

TextStyle gcwMonotypeTextStyle() {
  return TextStyle(
    fontSize: defaultFontSize(),
    fontFamily: 'Courier',
    fontWeight: FontWeight.bold
  );
}

TextStyle gcwHyperlinkTextStyle() {
  return TextStyle(
    color: themeColors().hyperLinkText(),
    decoration: TextDecoration.underline
  );
}

TextStyle gcwDescriptionTextStyle() {
  return gcwTextStyle().copyWith(
    color: themeColors().listSubtitle(),
    fontSize: defaultFontSize() - 2,
  );
}

TextStyle gcwDialogTextStyle() {
  return gcwTextStyle().copyWith(
    color: themeColors().dialogText()
  );
}

const roundedBorderRadius = 4.0;

ThemeData buildTheme() {
  final ThemeColors colors = themeColors();
  final ThemeData base = colors.base();
  return ThemeData(
    scaffoldBackgroundColor: colors.primaryBackground(),
    primaryColor: colors.primaryBackground(),
    accentColor: colors.accent(),
    textTheme: base.textTheme,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: colors.accent(),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(roundedBorderRadius)),
      )
    ),
    canvasColor: colors.inputBackground(), //background of DropDownButton
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      hintStyle: TextStyle(color: colors.textFieldHintText()),
      fillColor: colors.inputBackground(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.focused(), width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(roundedBorderRadius))
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.accent(), width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(roundedBorderRadius))
      ),
      contentPadding: EdgeInsets.all(10.0),
    ),
    unselectedWidgetColor: colors.accent(),
    cardColor: colors.messageBackground()
  );
}