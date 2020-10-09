import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:prefs/prefs.dart';

String className(Widget widget) {
  return widget.runtimeType.toString();
}

enum SpinnerLayout {HORIZONTAL, VERTICAL}

String printErrorMessage(BuildContext context, String message) {
  return i18n(context, 'common_error') + ': ' + i18n(context, message);
}

defaultFontSize() {
  var fontSize = Prefs.get('theme_font_size');

  if (fontSize < FONT_SIZE_MIN) {
    Prefs.setDouble('theme_font_size', FONT_SIZE_MIN.toDouble());
    return FONT_SIZE_MIN;
  }

  if (fontSize > FONT_SIZE_MAX) {
    Prefs.setDouble('theme_font_size', FONT_SIZE_MAX.toDouble());
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
        color: themeColors().outputListOddRows(),
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

buildPopupItem(BuildContext context, IconData icon, String i18nKey) {
  var color = themeColors().dialogText();

  return  Row(
    children: [
      Container(
        child: Icon(icon, color: color),
        padding: EdgeInsets.only(
          right: 10
        ),
      ),
      Text(
        i18n(context, i18nKey),
        style: TextStyle(
          color: color
        )
      )
    ],
  );
}

String insertText(String input, String currentText, TextEditingController textController) {
  var cursorPosition = max(textController.selection.end, 0);

  currentText = currentText.substring(0, cursorPosition) + input + currentText.substring(cursorPosition);
  textController.text = currentText;
  textController.selection = TextSelection.collapsed(offset: cursorPosition + input.length);

  return currentText;
}

String backSpace(String currentText, TextEditingController textController) {
  var cursorPosition = max(textController.selection.end, 0);
  if (cursorPosition == 0)
    return currentText;

  currentText = currentText.substring(0, cursorPosition - 1) + currentText.substring(cursorPosition);
  textController.text = currentText;
  textController.selection = TextSelection.collapsed(offset: cursorPosition - 1);

  return currentText;
}