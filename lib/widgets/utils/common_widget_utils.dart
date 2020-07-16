import 'dart:convert';

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

List<Widget> columnedMultiLineOutput(List<List<dynamic>> data, {List<int> flexValues = const []}) {
  var odd = true;
  return data.where((row) => row != null).map((rowData) {
    Widget output;

    var columns = rowData.asMap().map((index, column) {
      return MapEntry(
        index,
        Expanded(
          child: GCWText(
              text: column.toString()
          ),
          flex: index < flexValues.length ? flexValues[index] : 1
        )
      );
    }).values.toList();

    var row = Container(
      child: Row(
        children: columns
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

insertIntoGCWClipboard(String text) {
  var gcwClipboard = Prefs.getStringList('clipboard_items');

  var existingText = gcwClipboard.firstWhere((item) => jsonDecode(item)['text'] == text, orElse: () => null);

  if (existingText != null) {
    gcwClipboard.remove(existingText);
    gcwClipboard.insert(0, jsonEncode({'text': jsonDecode(existingText)['text'], 'created': DateTime.now().millisecondsSinceEpoch.toString()}));
  } else {
    gcwClipboard.insert(0, jsonEncode({'text': text, 'created': DateTime.now().millisecondsSinceEpoch.toString()}));
    while (gcwClipboard.length > Prefs.get('clipboard_max_items'))
      gcwClipboard.removeLast();
  }

  Prefs.setStringList('clipboard_items', gcwClipboard);
}