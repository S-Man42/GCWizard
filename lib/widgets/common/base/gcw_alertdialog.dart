import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

showAlertDialog(BuildContext context, String title, String text, Function onOKPressed) {
  TextStyle _textStyle = TextStyle(
    fontFamily: gcwTextStyle().fontFamily,
    fontSize: defaultFontSize(),
    color: ThemeColors.darkgrey
  );

  TextStyle _boldTextStyle = TextStyle(
    fontFamily: _textStyle.fontFamily,
    fontSize: _textStyle.fontSize,
    color: _textStyle.color,
    fontWeight: FontWeight.bold
  );

  Widget _okButton = FlatButton(
    child: Text(
      i18n(context, 'common_ok'),
      style: _boldTextStyle,
    ),
    onPressed: () {
      Navigator.of(context).pop();
      onOKPressed();
    }
  );

  Widget _cancelButton = FlatButton(
    child: Text(
      i18n(context, 'common_cancel'),
      style: _boldTextStyle,
    ),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      _cancelButton,
      _okButton,
    ],
    backgroundColor: ThemeColors.accent,
    titleTextStyle: _boldTextStyle,
    contentTextStyle: _textStyle
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}