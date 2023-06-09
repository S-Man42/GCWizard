import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/gcw_popup_menu.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/tools/formula_solver/widget/key_value_type_item.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/utils/variable_string_expander.dart';


class GCWKeyValueTypeInput extends GCWKeyValueInput {

  GCWKeyValueTypeInput({Key? key}) : super(key: key);

  @override
  GCWKeyValueInputState createState() => _GCWKeyValueTypeNewEntryState();
}

class _GCWKeyValueTypeNewEntryState extends GCWKeyValueInputState {
  var _currentType = FormulaValueType.FIXED;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            keyWidget(),
            arrowIcon(),
            valueWidget(),
            _typeButton(),
            addIcon(),
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
        iconData: formulaValueTypeIcon(_currentType),
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
  bool validInput() {
    if (_currentType == FormulaValueType.INTERPOLATED) {
      if (!VARIABLESTRING.hasMatch(currentValue.toLowerCase())) {
        showToast(i18n(context, 'formulasolver_values_novalidinterpolated'));
        return false;
      }
    }
    return true;
  }

  @override
  void addEntry(KeyValueBase entry, {bool clearInput = true}) {
    var _entry = getNewEntry(entry);
    if (_entry != null) {
      (_entry as FormulaValue).type = _currentType;
      widget.entries.add(_entry);

      finishAddEntry(_entry, clearInput);
    }
  }
}



