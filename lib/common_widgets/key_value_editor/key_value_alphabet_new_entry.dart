part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueAlphabetNewEntry extends GCWKeyValueNewEntry {

  const GCWKeyValueAlphabetNewEntry(
     {Key? key,
       required List<KeyValueBase> entries,
       String? keyHintText,
       required String valueHintText,
       TextEditingController? keyController,
       List<TextInputFormatter>? keyInputFormatters,
       List<TextInputFormatter>? valueInputFormatters,
       KeyValueBase? Function(KeyValueBase)? onGetNewEntry,
       void Function(KeyValueBase)? onNewEntryChanged,
       void Function(KeyValueBase)? onUpdateEntry,
       required bool addOnDispose,
       int? valueFlex,
       void Function()? onSetState,
     })
     : super(
        key: key,
        entries: entries,
        keyHintText: keyHintText,
        valueHintText: valueHintText,
        keyController: keyController,
        keyInputFormatters: keyInputFormatters,
        valueInputFormatters: valueInputFormatters,
        onGetNewEntry: onGetNewEntry,
        onNewEntryChanged: onNewEntryChanged,
        onUpdateEntry: onUpdateEntry,
        addOnDispose: addOnDispose,
        valueFlex: valueFlex,
        onSetState: onSetState,
  );

  @override
  GCWKeyValueNewEntryState createState() => GCWKeyValueAlphabetNewEntryState();
}

class GCWKeyValueAlphabetNewEntryState extends GCWKeyValueNewEntryState {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _keyWidget(),
            _arrowIcon(),
            _valueWidget(),
            _alphabetAddLetterButton(),
            _alphabetAddAndAdjustLetterButton(),
          ],
        ),
      ],
    );
  }

  bool _isAddAndAdjustEnabled(KeyValueBase entry) {
    if (widget.entries.firstWhereOrNull((_entry) => _entry.key == entry.key) != null) {
      return false;
    } else if (_currentValue.contains(',')) {
      return false;
    } else {
      return true;
    }
  }

  Widget _alphabetAddLetterButton() {
    return Container(
        padding: const EdgeInsets.only(left: 4, right: 2),
        child: GCWButton(
          text: i18n(context, 'alphabetvalues_edit_mode_customize_addletter'),
          onPressed: () {
            setState(() {
              var entry = KeyValueBase(null, _currentKey.toUpperCase(), _currentValue);
              _addNewLetter(entry, adjust: false);
             });
          },
        ));
  }

  Widget _alphabetAddAndAdjustLetterButton() {
    return Container(
        padding: const EdgeInsets.only(left: 4, right: 2),
        child: GCWButton(
          text: i18n(context, 'alphabetvalues_edit_mode_customize_addandadjustletter'),
          onPressed: () {
            var entry = KeyValueBase(null, _currentKey.toUpperCase(), _currentValue);
            if (_isAddAndAdjustEnabled(entry)) {
              setState(() {
                _addNewLetter(entry, adjust: true);
              });
            }
          }
        )
      );
  }

  void _addNewLetter(KeyValueBase entry, {bool adjust = false}) {
    if (entry.key.isEmpty) return;

    entry.value = entry.value
        .split(',')
        .where((character) => character.isNotEmpty)
        .map((character) => character.toUpperCase())
        .join(',');

    if (entry.value.isEmpty) return;

    var existEntry = widget.entries.firstWhereOrNull((_entry) => _entry.key == entry.key);
    if (existEntry != null) {
      showGCWDialog(context, i18n(context, 'alphabetvalues_edit_mode_customize_addletter_replace_title'),
          Text(i18n(context, 'alphabetvalues_edit_mode_customize_addletter_replace_text', parameters: [entry.key])), [
            GCWDialogButton(
                text: i18n(context, 'alphabetvalues_edit_mode_customize_addletter_replace'),
                onPressed: () {
                  existEntry.key = entry.key;
                  existEntry.value = entry.value;

                  _finishAddEntry(existEntry, true);
                })
          ]);
    } else {
      if (adjust) {
        var insertedValue = int.tryParse(entry.value);
        if (insertedValue != null) {
          for (var entry in widget.entries) {
            var newValue = entry.value.split(',').map((value) {
              var intValue = int.tryParse(value);
              if (intValue == null) return '';
              if (intValue >= insertedValue) intValue++;

              return intValue.toString();
            }).join(',');

            entry.value = newValue;
          }
        }
      }
      _addEntry(entry);
    }
  }
}

