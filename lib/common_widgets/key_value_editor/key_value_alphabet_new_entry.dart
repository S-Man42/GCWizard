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
       void Function(KeyValueBase, BuildContext)? onNewEntryChanged,
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

  bool _isAddAndAdjustEnabled() {
    if (widget.entries.firstWhereOrNull((entry) => entry.key == _currentKey.toUpperCase()) != null) {
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
              _addNewLetter(KeyValueBase(null, _currentKey, _currentValue), adjust: false);
              //_addEntry(KeyValueBase(null, _currentKey, _currentValue));
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
            if (_isAddAndAdjustEnabled()) {
              setState(() {
                //if (widget.onAddEntry2 != null) widget.onAddEntry2!(KeyValueBase(null, _currentKeyInput, _currentValueInput), context);
                if (_addNewLetter(KeyValueBase(null, _currentKey, _currentValue), adjust: true)) {
                  _onNewEntryChanged(true);
                }
              });
            }
          }
        )
      );
  }

  bool _addNewLetter(KeyValueBase entry, {bool adjust = false}) {
    var returnValue = false;
    if (entry.key.isEmpty) return returnValue;

    entry.value = entry.value
        .split(',')
        .where((character) => character.isNotEmpty)
        .map((character) => character.toUpperCase())
        .join(',');

    if (entry.value.isEmpty) return returnValue;

    entry.key = entry.key.toUpperCase();
    if (widget.entries.firstWhereOrNull((_entry) => _entry.key == entry.key) != null) {
      showGCWDialog(context, i18n(context, 'alphabetvalues_edit_mode_customize_addletter_replace_title'),
          Text(i18n(context, 'alphabetvalues_edit_mode_customize_addletter_replace_text', parameters: [entry.key])), [
            GCWDialogButton(
                text: i18n(context, 'alphabetvalues_edit_mode_customize_addletter_replace'),
                onPressed: () {
                  setState(() {
                    widget.entries.add(KeyValueBase(null, entry.key, entry.value));
                    returnValue = true;
                  });
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
      widget.entries.add(KeyValueBase(null, entry.key, entry.value));
      returnValue = true;
      //_currentCustomizedAlphabet!.putIfAbsent(letter, () => value);
    }
    return returnValue;
  }

}

