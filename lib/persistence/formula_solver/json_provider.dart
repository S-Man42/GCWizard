import 'dart:convert';

import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:prefs/prefs.dart';

void refreshFormulas() {
  formulaGroups = Prefs.getStringList('formulasolver_formulas')
    .map((object) => jsonDecode(object))
    .toList();
}

int _newID() {
  if (formulaGroups.length == 0)
    return 1;

  var existingIDs = formulaGroups
    .map((group) => group.id)
    .toList();

  existingIDs.sort();

  for (int i = 1; i <= formulaGroups.length + 1; i++) {
    if (!existingIDs.contains(i))
      return i;
  }
}

_saveData() {
  var jsonObjects = formulaGroups
    .map((group) => jsonEncode(group.toMap()))
    .toList();

  Prefs.setStringList('formulasolver_formulas', jsonObjects);
}

int insertGroup(FormulaGroup group) {
  group.id = _newID();
  formulaGroups.add(group);

  _saveData();

  return group.id;
}

void update() {
  _saveData();
}

void deleteGroup(int groupId) {
  formulaGroups.removeWhere((group) => group.id == groupId);

  _saveData();
}

