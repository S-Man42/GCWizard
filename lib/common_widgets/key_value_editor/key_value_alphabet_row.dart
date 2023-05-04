part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueAlphabetRow extends GCWKeyValueRow {

  GCWKeyValueAlphabetRow(
     {Key? key,
       required List<KeyValueBase> entries,
       required KeyValueBase keyValueEntry,
       required _KeyValueEditorControl keyValueEditorControl,

       required bool odd,
       List<TextInputFormatter>? keyInputFormatters,
       List<TextInputFormatter>? valueInputFormatters,
       bool editAllowed = true,
       void Function(KeyValueBase)? onUpdateEntry,
       void Function()? onSetState,
     })
     : super(
        key: key,
        entries: entries,
        keyValueEntry: keyValueEntry,
        keyValueEditorControl: keyValueEditorControl,
        odd: odd,
        keyInputFormatters: keyInputFormatters,
        valueInputFormatters: valueInputFormatters,
        editAllowed: editAllowed,
        onUpdateEntry: onUpdateEntry,
        onSetState: onSetState,
  );

  @override
  GCWKeyValueRowState createState() => GCWKeyValueAlphabetRowState();
}

class GCWKeyValueAlphabetRowState extends GCWKeyValueRowState {

  @override
  void _removeEntry() {
    widget.entries.remove(widget.keyValueEntry);
    if (widget.onUpdateEntry != null) widget.onUpdateEntry!(widget.keyValueEntry);

    var _isList = widget.keyValueEntry.value.contains(',');

    var buttons = [
      GCWDialogButton(
          text: i18n(context, 'alphabetvalues_edit_mode_customize_deleteletter_remove'),
          onPressed: () {
            setState(() {
              widget.entries.remove(widget.keyValueEntry);
            });
          })
    ];

    if (!_isList) {
      var deleteValue = int.tryParse(widget.keyValueEntry.value);

      buttons.add(GCWDialogButton(
        text: i18n(context, 'alphabetvalues_edit_mode_customize_deleteletter_removeandadjust'),
        onPressed: () {
          if (deleteValue != null) {
            for (var entry in (widget as GCWKeyValueAlphabetNewEntry).entries) {
              var newValue = entry.value.split(',').map((value) {
                var intValue = int.tryParse(value);
                if (intValue == null) return '';
                if (intValue > deleteValue) intValue--;

                return intValue.toString();
              }).join(',');

              entry.value = newValue;
            }
            setState(() {
              widget.entries.remove(widget.keyValueEntry);
            });
          }
        },
      ));
    }

    showGCWDialog(context, i18n(context, 'alphabetvalues_edit_mode_customize_deleteletter_title'),
        Text(i18n(context, 'alphabetvalues_edit_mode_customize_deleteletter_text', parameters: [widget.keyValueEntry.id])), buttons);
  }
}


