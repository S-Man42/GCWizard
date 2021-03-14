import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/persistence/formula_solver/json_provider.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/gcw_key_value_editor.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class FormulaSolverFormulaValues extends StatefulWidget {
  final FormulaGroup group;

  const FormulaSolverFormulaValues({Key key, this.group}) : super(key: key);

  @override
  FormulaSolverFormulaValuesState createState() => FormulaSolverFormulaValuesState();
}

class FormulaSolverFormulaValuesState extends State<FormulaSolverFormulaValues> {
  TextEditingController _newKeyController;

  @override
  void initState() {
    super.initState();
    _newKeyController = TextEditingController(text: _maxLetter());

    refreshFormulas();
  }

  @override
  void dispose() {
    _newKeyController.dispose();

    super.dispose();
  }

  String _maxLetter() {
    int maxLetterIndex = 0;
    widget.group.values.forEach((value) {
      if (value.key.length != 1)
        return;

      maxLetterIndex = max(maxLetterIndex, alphabet_AZ[value.key.toUpperCase()]);
    });

    if (maxLetterIndex < 26) {
      return alphabet_AZIndexes[maxLetterIndex + 1];
    }

    return '';
  }

  _updateValue(FormulaValue value) {
    updateFormulaValue(value, widget.group);
  }

  _addEntry(String currentFromInput, String currentToInput, BuildContext context) {
    if (currentFromInput.length > 0) {
      var newValue = FormulaValue(currentFromInput, currentToInput);
      insertFormulaValue(newValue, widget.group);

      _newKeyController.text = _maxLetter();;
    }
  }

  _updateEntry(dynamic id, String key, String value) {
    var entry = widget.group.values.firstWhere((element) => element.id == id);
    entry.key = key;
    entry.value = value;
    _updateValue(entry);
  }

  _removeEntry(dynamic id, BuildContext context) {
    deleteFormulaValue(id, widget.group);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'formulasolver_values_newvalue')
        ),
        GCWKeyValueEditor(
          keyHintText: i18n(context, 'formulasolver_values_key'),
          keyController: _newKeyController,
          valueHintText: i18n(context, 'formulasolver_values_value'),
          valueFlex: 2,
          onAddEntry: _addEntry,

          listHeaderWidget: GCWTextDivider(text: i18n(context, 'formulasolver_values_currentvalues')),

          formulaValueList: widget.group.values,
          onUpdateEntry: _updateEntry,
          onRemoveEntry: _removeEntry,
        ),
      ],
    );
  }
}