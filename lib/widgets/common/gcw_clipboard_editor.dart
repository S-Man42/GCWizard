import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:prefs/prefs.dart';

const _PREFS_KEY_CLIPBOARD_ITEMS = 'clipboard_items';

class GCWClipboardEditor extends StatefulWidget {
  final FormulaGroup group;

  const GCWClipboardEditor({Key key, this.group}) : super(key: key);

  @override
  GCWClipboardEditorState createState() => GCWClipboardEditorState();
}

class GCWClipboardEditorState extends State<GCWClipboardEditor> {
  TextEditingController _editController;
  int _currentEditId;
  String _currentEditText = '';

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text:_currentEditText);
  }

  @override
  void dispose() {
    _editController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var entries = Prefs.getStringList(_PREFS_KEY_CLIPBOARD_ITEMS);

    var children = <Widget>[
      GCWIntegerSpinner(
        title: i18n(context, 'settings_general_clipboard_maxitems'),
        value: Prefs.getInt('clipboard_max_items'),
        min: 1,
        max: 100,
        onChanged: (value) {
          setState(() {
            Prefs.setInt('clipboard_max_items', value);
          });
        },
      ),
      GCWIntegerSpinner(
        title: i18n(context, 'settings_general_clipboard_keep.entries.in.days'),
        value: Prefs.getInt('clipboard_keep_entries_in_days'),
        min: 1,
        max: 1000,
        onChanged: (value) {
          setState(() {
            Prefs.setInt('clipboard_keep_entries_in_days', value);
          });
        },
      ),
      GCWButton(
        text: i18n(context, 'clipboardeditor_clear_title'),
        onPressed: () {
          showGCWAlertDialog(
            context,
            i18n(context, 'clipboardeditor_clear_title'),
            i18n(context, 'clipboardeditor_clear_text'),
            () {
              setState(() {
                Prefs.setStringList(_PREFS_KEY_CLIPBOARD_ITEMS, []);
              });
            }
          );
        },
      ),
      GCWTextDivider(
        text: i18n(context, 'clipboardeditor_entries')
      )
    ];

    children.addAll(entries.asMap().map((index, entry) {
      var item = jsonDecode(entry);

      var child;

      if (_currentEditId != null && _currentEditId == index) {
        child = Row(
          children: [
            Expanded(
              child: GCWTextField(
                controller: _editController,
                autofocus: true,
                onChanged: (text) {
                  setState(() {
                    _currentEditText = text;
                  });
                },
              )
            ),
            Container(width: 10),
            GCWIconButton(
              iconData: Icons.check,
              onPressed: () {
                setState(() {
                  if (_currentEditText != null && _currentEditText.isNotEmpty) {
                    item['text'] = _currentEditText;

                    var newEntries = List<String>.from(entries);
                    newEntries[index] = jsonEncode(item);
                    Prefs.setStringList(_PREFS_KEY_CLIPBOARD_ITEMS, newEntries);
                  }

                  _currentEditId = null;
                  _editController.clear();
                });
              },
            ),
          ]
        );
      } else {
        child = Row(
          children: [
            Expanded(
                child: GCWText(
                  text: item['text']
                )
            ),
            Container(width: 10),
            GCWIconButton(
              iconData: Icons.edit,
              onPressed: () {
                setState(() {
                  _currentEditId = index;
                  _editController.text = item['text'];
                });
              },
            ),
            GCWIconButton(
              iconData: Icons.remove,
              onPressed: () {
                var text = item['text'];
                if (text.length > 50) text = item['text'].substring(0, 47) + '...';

                showDeleteAlertDialog(context, text, () {
                  setState(() {
                    var newEntries = List<String>.from(entries);
                    newEntries.removeAt(index);
                    Prefs.setStringList(_PREFS_KEY_CLIPBOARD_ITEMS, newEntries);
                  });
                });
              },
            ),
          ]
        );
      }

      if (index % 2 == 0) {
        child = Container(color: themeColors().outputListOddRows(), child: child);
      } else {
        child = Container(child: child);
      }

      return MapEntry(index, child as Widget);
    }).values.toList());

    return Column(
      children: children
    );
  }
}
