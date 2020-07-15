import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/persistence/formula_solver/json_provider.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class FormulaSolverFormulaValues extends StatefulWidget {
  final FormulaGroup group;

  const FormulaSolverFormulaValues({Key key, this.group}) : super(key: key);

  @override
  FormulaSolverFormulaValuesState createState() => FormulaSolverFormulaValuesState();
}

class FormulaSolverFormulaValuesState extends State<FormulaSolverFormulaValues> {
  var _newKeyController;
  var _newValueController;
  var _editKeyController;
  var _editValueController;
  var _currentNewKey = '';
  var _currentNewValue = '';
  var _currentEditedKey = '';
  var _currentEditedValue = '';
  var _currentEditId;

  @override
  void initState() {
    super.initState();
    _newKeyController = TextEditingController(text: _currentNewKey);
    _newValueController = TextEditingController(text: _currentNewValue);
    _editKeyController = TextEditingController(text: _currentEditedKey);
    _editValueController = TextEditingController(text: _currentEditedValue);

    refreshFormulas();

    _currentNewKey = _maxLetter();
    _newKeyController.text = _currentNewKey;
  }

  @override
  void dispose() {
    _newKeyController.dispose();
    _newValueController.dispose();
    _editKeyController.dispose();
    _editValueController.dispose();

    super.dispose();
  }

  String _maxLetter() {
    int maxLetterIndex = 0;
    widget.group.values.forEach((value) {
      if (value.key.length > 1)
        return;

      maxLetterIndex = max(maxLetterIndex, alphabet_AZ[value.key.toUpperCase()]);
    });

    if (maxLetterIndex < 26) {
      return alphabet_AZIndexes[maxLetterIndex + 1];
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'formulasolver_values_newvalue')
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'formulasolver_values_key'),
                controller: _newKeyController,
                onChanged: (text) {
                  setState(() {
                    _currentNewKey = text;
                  });
                },
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: ThemeColors.gray,
            ),
            Expanded(
              child: Padding (
                child: GCWTextField(
                  hintText: i18n(context, 'formulasolver_values_value'),
                  controller: _newValueController,
                  onChanged: (text) {
                    setState(() {
                      _currentNewValue = text;
                    });
                  },
                ),
                padding: EdgeInsets.only(
                  right: 2,
                ),
              )
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: () {
                _addNewValue();

                setState(() {
                  _currentNewKey = _maxLetter();
                  _newKeyController.text = _currentNewKey;
                });
              },
            )
          ],
        ),
        _buildGroupList(context)
      ],
    );
  }

  _addNewValue() {
    if (_currentNewKey.length > 0) {
      var newValue = FormulaValue(_currentNewKey, _currentNewValue);
      insertFormulaValue(newValue, widget.group);

      _newKeyController.clear();
      _newValueController.clear();
      _currentNewKey = '';
      _currentNewValue = '';
    }
  }

  _updateValue(FormulaValue value) {
    updateFormulaValue(value, widget.group);
  }

  _removeValue(FormulaValue value) {
    deleteFormulaValue(value.id, widget.group);
  }

  _buildGroupList(BuildContext context) {
    var odd = true;
    var rows = widget.group.values.map((value) {
      Widget output;

      var row = Container(
        child: Row (
          children: <Widget>[
            Expanded(
              child: _currentEditId == value.id
               ? GCWTextField(
                  controller: _editKeyController,
                  onChanged: (text) {
                    setState(() {
                      _currentEditedKey = text;
                    });
                  },
                )
              : GCWText (
                  text: value.key
                ),
              flex: 1,
            ),
            Icon(
              Icons.arrow_forward,
              color: ThemeColors.gray,
            ),
            Expanded(
              child: _currentEditId == value.id
               ? Padding (
                  child:GCWTextField(
                    controller: _editValueController,
                    autofocus: true,
                    onChanged: (text) {
                      setState(() {
                        _currentEditedValue = text;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(
                    right: 2,
                  ),
                )
              : GCWText (
                  text: value.value
                ),
              flex: 1
            ),
            _currentEditId == value.id
             ? GCWIconButton(
                iconData: Icons.check,
                onPressed: () {
                  value.key = _currentEditedKey;
                  value.value = _currentEditedValue;
                  _updateValue(value);

                  setState(() {
                    _currentEditId = null;
                    _editKeyController.clear();
                    _editValueController.clear();
                  });
                },
              )
            : GCWIconButton(
              iconData: Icons.edit,
              onPressed: () {
                setState(() {
                  _currentEditId = value.id;
                  _editKeyController.text = value.key;
                  _editValueController.text = value.value;
                  _currentEditedKey = value.key;
                  _currentEditedValue = value.value;
                });
              },
            ),
            GCWIconButton(
              iconData: Icons.remove,
              onPressed: () {
                showDeleteAlertDialog(context, value.key, () {
                  _removeValue(value);

                  setState(() {});
                },);
              },
            )
          ],
        ),
      );

      if (odd) {
        output = Container(
            color: ThemeColors.oddRows,
            child: row
        );
      } else {
        output = Container(
            child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    if (rows.length > 0) {
      rows.insert(0,
        GCWTextDivider(
          text: i18n(context, 'formulasolver_values_currentvalues')
        )
      );
    }

    return Column(
      children: rows
    );
  }
}