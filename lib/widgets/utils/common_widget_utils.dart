import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:prefs/prefs.dart';

String className(Widget widget) {
  return widget.runtimeType.toString();
}

enum SpinnerLayout {horizontal, vertical}

String printErrorMessage(BuildContext context, String message) {
  return i18n(context, 'common_error') + ': ' + i18n(context, message);
}

defaultFontSize() {
  var fontSize = Prefs.get('font_size');

  if (fontSize < FONT_SIZE_MIN) {
    Prefs.setDouble('font_size', FONT_SIZE_MIN.toDouble());
    return FONT_SIZE_MIN;
  }

  if (fontSize > FONT_SIZE_MAX) {
    Prefs.setDouble('font_size', FONT_SIZE_MAX.toDouble());
    return FONT_SIZE_MAX;
  }

  return fontSize;
}

List<Widget> twoColumnMultiLineOutput(
    BuildContext context,
    Map<String, dynamic> data,
    {
      flexLeft: 1,
      flexRight: 1
    }) {
  var odd = true;
  return data.entries.map((entry) {
    Widget output;

    var row = Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: GCWText(
              text: i18n(context, entry.key)
            ),
            flex: flexLeft,
          ),
          Expanded(
            child: GCWText(
              text: entry.value.toString()
            ),
            flex: flexRight,
          ),
        ],
      ),
      margin: EdgeInsets.only(
        top : 6,
        bottom: 6
      ),
    );

    if (odd) {
      output = Container(
        color: ThemeColors.oddRows,
        child: row
      );
    } else {
      output = Container(
        child: row
      );
    }
    odd = !odd;

    return output;
  }).toList();
}