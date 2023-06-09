import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_popup_menu.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:gc_wizard/utils/variable_string_expander.dart';

class GCWKeyValueTypeItem extends GCWKeyValueItem {

  GCWKeyValueTypeItem(
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
  GCWKeyValueItemState createState() => _GCWKeyValueTypeItemState();
}

class _GCWKeyValueTypeItemState extends GCWKeyValueItemState {
  var _currentType = FormulaValueType.FIXED;

  @override
  void initValues() {
    super.initValues();
    _currentType = (widget.keyValueEntry is FormulaValue)
                    ? (widget.keyValueEntry as FormulaValue).type ?? _currentType
                    : _currentType;
  }

  @override
  Widget build(BuildContext context) {
    Widget output;

    var row = Row(
      children: <Widget>[
        keyWidget(),
        arrowIcon(),
        valueWidget(),
        _typeButton(),
        editButton(),
        removeButton(),
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
                ))
                : Transform.rotate(
                  angle: degreesToRadian(_currentType == FormulaValueType.TEXT ? 0.0 : 90.0),
                  child: Icon(formulaValueTypeIcon(_currentType), color: themeColors().mainFont()),
                )
            )
    );
  }

  @override
  void updateEntry() {
    if (_currentType == FormulaValueType.INTERPOLATED) {
      if (!VARIABLESTRING.hasMatch(currentValue.toLowerCase())) {
        showToast(i18n(context, 'formulasolver_values_novalidinterpolated'));
        return;
      }
    }
    if (widget.keyValueEntry is FormulaValue) {
      (widget.keyValueEntry as FormulaValue).type = _currentType;
    }

    super.updateEntry();
  }
}

IconData formulaValueTypeIcon(FormulaValueType? formulaValueType) {
  switch (formulaValueType) {
    case FormulaValueType.TEXT:
      return Icons.text_fields;
    case FormulaValueType.INTERPOLATED:
      return Icons.expand;
    default: // case FormulaValueType.FIXED:
      return Icons.vertical_align_center_outlined;
  }
}


