import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';

class GCWKeyValueAlphabetItem extends GCWKeyValueItem {

  GCWKeyValueAlphabetItem(
     {Key? key,
       required KeyValueBase keyValueEntry,
       required bool odd,
     })
     : super(
        key: key,
        keyValueEntry: keyValueEntry,
        odd: odd,
  );

  @override
  GCWKeyValueItemState createState() => _GCWKeyValueAlphabetEntryState();
}

class _GCWKeyValueAlphabetEntryState extends GCWKeyValueItemState {

  @override
  void removeEntry() {
    var _isList = widget.keyValueEntry.value.contains(',');

    var buttons = [
      GCWDialogButton(
          text: i18n(context, 'alphabetvalues_edit_mode_customize_deleteletter_remove'),
          onPressed: () {
            super.removeEntry();
          }
      )
    ];

    if (!_isList) {
      var deleteValue = int.tryParse(widget.keyValueEntry.value);

      buttons.add(GCWDialogButton(
        text: i18n(context, 'alphabetvalues_edit_mode_customize_deleteletter_removeandadjust'),
        onPressed: () {
          if (deleteValue != null) {
            for (var entry in widget.entries) {
              var newValue = entry.value.split(',').map((value) {
                var intValue = int.tryParse(value);
                if (intValue == null) return '';
                if (intValue > deleteValue) intValue--;

                return intValue.toString();
              }).join(',');

              entry.value = newValue;
            }
            super.removeEntry();
          }
        },
      ));
    }

    showGCWDialog(context, i18n(context, 'alphabetvalues_edit_mode_customize_deleteletter_title'),
        Text(i18n(context, 'alphabetvalues_edit_mode_customize_deleteletter_text', parameters: [widget.keyValueEntry.key])), buttons);
  }
}


