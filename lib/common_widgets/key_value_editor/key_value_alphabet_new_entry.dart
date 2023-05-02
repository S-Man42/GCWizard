part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueAlphabetNewEntry extends GCWKeyValueNewEntry {
  final List<KeyValueBase> entries;

  const GCWKeyValueAlphabetNewEntry(
     {Key? key,
       String? keyHintText,
       required String valueHintText,
       TextEditingController? keyController,
       List<TextInputFormatter>? keyInputFormatters,
       List<TextInputFormatter>? valueInputFormatters,
       void Function(KeyValueBase, FormulaValueType, BuildContext)? onAddEntry,
       void Function(KeyValueBase, BuildContext)? onNewEntryChanged,
       int? valueFlex,
       required this.entries,
     })
     : super(
        key: key,
        keyHintText: keyHintText,
        valueHintText: valueHintText,
        keyController: keyController,
        keyInputFormatters: keyInputFormatters,
        valueInputFormatters: valueInputFormatters,
        onAddEntry: onAddEntry,
        onNewEntryChanged: onNewEntryChanged,
        valueFlex: valueFlex
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
            _valueWidget(),
            _alphabetAddLetterButton(),
            _alphabetAddAndAdjustLetterButton(),
          ],
        ),
      ],
    );
  }

  bool _isAddAndAdjustEnabled() {
    if ((widget as GCWKeyValueAlphabetNewEntry).entries
        .firstWhereOrNull((entry) => entry.key == _currentKey.toUpperCase()) != null) {
      return false;
    }
    if (_currentValue.contains(',')) return false;

    return true;
  }

  Widget _alphabetAddLetterButton() {
    return Container(
        padding: const EdgeInsets.only(left: 4, right: 2),
        child: GCWButton(
          text: i18n(context, 'alphabetvalues_edit_mode_customize_addletter'),
          onPressed: () {
            setState(() {
              _addEntry(KeyValueBase(null, _currentKeyInput, _currentValueInput));
            });
          },
        ));
  }

  Widget _alphabetAddAndAdjustLetterButton() {
    return Container(
        padding: const EdgeInsets.only(left: 4, right: 2),
        child: GCWButton(
          text: i18n(context, 'alphabetvalues_edit_mode_customize_addandadjustletter'),
          onPressed: () => _isAddAndAdjustEnabled()
              ? () {
            setState(() {
              if (widget.onAddEntry2 != null) widget.onAddEntry2!(KeyValueBase(null, _currentKeyInput, _currentValueInput), context);

              _onNewEntryChanged(true);
            });
          }
              : null,
        ));
  }
}



