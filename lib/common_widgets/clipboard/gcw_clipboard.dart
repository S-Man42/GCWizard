import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:prefs/prefs.dart';
import 'package:collection/collection.dart';

class ClipboardItem {
  String text;
  DateTime datetime;

  ClipboardItem(this.text, this.datetime);

  static ClipboardItem? fromJson(String jsonString) {
    var decoded = jsonDecode(jsonString);
    if (decoded == null || !(decoded is Map<String, Object?>))
      return null;

    var created = decoded['created'];
    if (created == null || !(created is String))
      created = '0';

    int createdValue = int.tryParse(created) ?? 0;
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(createdValue);

    var text = decoded['text'];
    if (text == null || !(text is String))
      text = '';

    return ClipboardItem(text, datetime);
  }
}

void insertIntoGCWClipboard(BuildContext context, String text, {bool useGlobalClipboard = true}) {
  if (useGlobalClipboard) Clipboard.setData(ClipboardData(text: text));

  var gcwClipboard = Prefs.getStringList(PREFERENCE_CLIPBOARD_ITEMS);

  String? existingText = gcwClipboard.firstWhereOrNull((item) => jsonDecode(item)['text'] == text);

  if (existingText != null) {
    gcwClipboard.remove(existingText);
    gcwClipboard.insert(
        0,
        jsonEncode(
            {'text': jsonDecode(existingText)['text'], 'created': DateTime.now().millisecondsSinceEpoch.toString()}));
  } else {
    gcwClipboard.insert(0, jsonEncode({'text': text, 'created': DateTime.now().millisecondsSinceEpoch.toString()}));
    while (gcwClipboard.length > Prefs.getInt(PREFERENCE_CLIPBOARD_MAX_ITEMS)) gcwClipboard.removeLast();
  }

  Prefs.setStringList(PREFERENCE_CLIPBOARD_ITEMS, gcwClipboard);

  if (useGlobalClipboard) showToast(i18n(context, 'common_clipboard_copied') + ':\n' + text);
}