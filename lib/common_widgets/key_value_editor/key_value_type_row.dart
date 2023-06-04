part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueTypeRow extends GCWKeyValueRow {

  GCWKeyValueTypeRow(
     {Key? key,
       required List<KeyValueBase> entries,
       required KeyValueBase keyValueEntry,
       required KeyValueEditorControl keyValueEditorControl,

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
  _GCWKeyValueRowState createState() => _GCWKeyValueTypeRowState();
}

class _GCWKeyValueTypeRowState extends _GCWKeyValueRowState {
  var _currentType = FormulaValueType.FIXED;

  @override
  void _initValues() {
    super._initValues();
    _currentType = (widget.keyValueEntry is FormulaValue)
                    ? (widget.keyValueEntry as FormulaValue).type ?? _currentType
                    : _currentType;
  }

  @override
  Widget build(BuildContext context) {
    Widget output;

    var row = Row(
      children: <Widget>[
        _keyWidget(),
        _arrowIcon(),
        _valueWidget(),
        _typeButton(),
        _editButton(),
        _removeButton(),
      ],
    );

    if (widget.odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }

    return output;
  }

  Widget _typeButton() {
    return Expanded(
          flex: 1,
          child: Container(
            child: widget.keyValueEditorControl.currentInProgress == widget.keyValueEntry
              ? Container(
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
                ))
                : Transform.rotate(
                  angle: degreesToRadian(_currentType == FormulaValueType.TEXT ? 0.0 : 90.0),
                  child: Icon(_formulaValueTypeIcon(_currentType), color: themeColors().mainFont()),
                )
            )
    );
  }

  @override
  void _updateEntry() {
    if (_currentType == FormulaValueType.INTERPOLATED) {
      if (!VARIABLESTRING.hasMatch(_currentValue.toLowerCase())) {
        showToast(i18n(context, 'formulasolver_values_novalidinterpolated'));
        return;
      }
    }
    if (widget.keyValueEntry is FormulaValue) {
      (widget.keyValueEntry as FormulaValue).type = _currentType;
    }

    super._updateEntry();
  }
}

IconData _formulaValueTypeIcon(FormulaValueType? formulaValueType) {
  switch (formulaValueType) {
    case FormulaValueType.TEXT:
      return Icons.text_fields;
    case FormulaValueType.INTERPOLATED:
      return Icons.expand;
    default: // case FormulaValueType.FIXED:
      return Icons.vertical_align_center_outlined;
  }
}


