part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueTypeNewEntry extends GCWKeyValueNewEntry {

  const GCWKeyValueTypeNewEntry(
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
  GCWKeyValueNewEntryState createState() => GCWKeyValueTypeNewEntryState();
}

class GCWKeyValueTypeNewEntryState extends GCWKeyValueNewEntryState {
  var _currentType = FormulaValueType.FIXED;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _keyWidget(),
            _arrowIcon(),
            _valueWidget(),
            _typeButton(),
            _addIcon(),
          ],
        ),
      ],
    );
  }

  Widget _typeButton() {
    return Expanded(
      flex: 1,
      child: Container(
      padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
      child: GCWPopupMenu(
        iconData: _formulaValueTypeIcon(_currentType),
        rotateDegrees: _currentType == FormulaValueType.TEXT ? 0.0 : 90.0,
        menuItemBuilder: (context) => [
          GCWPopupMenuItem(
              child: iconedGCWPopupMenuItem(context, Icons.vertical_align_center_outlined,
                  i18n(context, 'formulasolver_values_type_fixed'),
                  rotateDegrees: 90.0),
              action: (index) => setState(() {
                _currentType = FormulaValueType.FIXED;
              })),
          GCWPopupMenuItem(
              child: iconedGCWPopupMenuItem(
                  context, Icons.expand, i18n(context, 'formulasolver_values_type_interpolated'),
                  rotateDegrees: 90.0),
              action: (index) => setState(() {
                _currentType = FormulaValueType.INTERPOLATED;
              })),
          GCWPopupMenuItem(
              child: iconedGCWPopupMenuItem(
                  context, Icons.text_fields, i18n(context, 'formulasolver_values_type_text')),
              action: (index) => setState(() {
                _currentType = FormulaValueType.TEXT;
              })),
        ],
      )));
  }

  @override
  bool _validInput() {
    if (_currentType == FormulaValueType.INTERPOLATED) {
      if (!VARIABLESTRING.hasMatch(_currentValue.toLowerCase())) {
        showToast(i18n(context, 'formulasolver_values_novalidinterpolated'));
        return false;
      }
    }
    return true;
  }

  @override
  void _addEntry(KeyValueBase entry, {bool clearInput = true}) {
    var _entry = _getNewEntry(entry);
    if (_entry != null) {
      (_entry as FormulaValue).type = _currentType;
      widget.entries.add(_entry);

      _finishAddEntry(_entry, clearInput);
    }
  }
}



