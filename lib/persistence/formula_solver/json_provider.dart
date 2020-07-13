import 'dart:convert';

import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:prefs/prefs.dart';

void refreshFormulas() {
  var formulas = Prefs.getStringList('formulasolver_formulas');
  if (formulas == null || formulas.length == 0)
    return;

  formulaGroups = formulas
    .where((group) => group.length > 0)
    .map((group) {
      var g = FormulaGroup.fromJson(jsonDecode(group));
      return g;
    })
    .toList();
}

int _newID(List<int> existingIDs) {
  if (existingIDs.length == 0)
    return 1;

  existingIDs.sort();

  for (int i = 1; i <= existingIDs.length + 1; i++) {
    if (!existingIDs.contains(i))
      return i;
  }

  return null;
}

_saveData() {
  var jsonData = formulaGroups
    .map((group) => jsonEncode(group.toMap()))
    .toList();

  Prefs.setStringList('formulasolver_formulas', jsonData);
}

int insertGroup(FormulaGroup group) {
  var newID = _newID(
    formulaGroups
      .map((group) => group.id)
      .toList()
  );
  group.id = newID;
  formulaGroups.add(group);

  _saveData();

  return newID;
}

void updateFormulaGroups() {
  _saveData();
}

void deleteGroup(int groupId) {
  formulaGroups.removeWhere((group) => group.id == groupId);

  _saveData();
}

void _updateFormulaGroups(FormulaGroup group) {
  formulaGroups = formulaGroups.map((formulaGroup) {
    if (formulaGroup.id == group.id)
      return group;

    return formulaGroup;
  }).toList();
}

int insertFormula(Formula formula, FormulaGroup group) {
  var newID = _newID(
    group.formulas
      .map((formula) => formula.id)
      .toList()
  );
  formula.id = newID;
  group.formulas.add(formula);

  _updateFormulaGroups(group);
  _saveData();

  return newID;
}

void updateFormula(Formula formula, FormulaGroup group) {
  group.formulas = group.formulas.map((groupFormula) {
    if (groupFormula.id == formula.id)
      return formula;

    return groupFormula;
  }).toList();

  _updateFormulaGroups(group);
  _saveData();
}

int insertFormulaValue(FormulaValue formulaValue, FormulaGroup group) {
  var newID = _newID(
    group.values
      .map((value) => value.id)
      .toList()
  );
  formulaValue.id = newID;
  group.values.add(formulaValue);

  _updateFormulaGroups(group);
  _saveData();

  return newID;
}

void updateFormulaValue(FormulaValue formulaValue, FormulaGroup group) {
  group.values = group.values.map((value) {
    if (value.id == formulaValue.id)
      return formulaValue;

    return value;
  }).toList();

  _updateFormulaGroups(group);
  _saveData();
}

void deleteFormula(int formulaId, FormulaGroup group) {
  group.formulas.removeWhere((formula) => formula.id == formulaId);

  _updateFormulaGroups(group);
  _saveData();
}

void deleteFormulaValue(int formulaValueId, FormulaGroup group) {
  group.values.removeWhere((value) => value.id == formulaValueId);

  _updateFormulaGroups(group);
  _saveData();
}
