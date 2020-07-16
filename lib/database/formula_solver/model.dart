import 'package:gc_wizard/database/formula_solver/names.dart';

class FormulaGroup {
  int id;
  String name;

  FormulaGroup(
    this.name,
    {
      this.id
    }
  );

  Map<String, dynamic> toInsertMap() => {
    TABLE_GROUPS_COLUMN_NAME_NAME : name,
  };

  factory FormulaGroup.fromDatabaseMap(Map<String, dynamic> group) => FormulaGroup(
    group[TABLE_GROUPS_COLUMN_NAME_NAME],
    id: group[TABLE_GROUPS_COLUMN_NAME_ID],
  );

  @override
  String toString() {
    return {
      'id': id,
      'name': name,
    }.toString();
  }
}

List<FormulaGroup> formulaGroups = [];

FormulaGroup getFormulaGroupById(int id) {
  return formulaGroups.firstWhere((group) => group.id == id);
}

class Formula {
  int id;
  String formula;
  FormulaGroup group;

  Formula(
    this.formula,
    this.group,
    {
      this.id,
    }
  );

  Map<String, dynamic> toInsertMap() => {
    TABLE_FORMULAS_COLUMN_NAME_FORMULA : formula,
    TABLE_FORMULAS_COLUMN_NAME_GROUP : group.id
  };

  factory Formula.fromDatabaseMap(Map<String, dynamic> entry) => Formula(
    entry[TABLE_FORMULAS_COLUMN_NAME_FORMULA],
    getFormulaGroupById(entry[TABLE_FORMULAS_COLUMN_NAME_GROUP]),
    id: entry[TABLE_FORMULAS_COLUMN_NAME_ID]
  );

  @override
  String toString() {
    return {
      'id': id,
      'formula': formula,
      'group' : group,
    }.toString();
  }
}

class FormulaValue {
  int id;
  String key;
  String value;
  FormulaGroup group;

  FormulaValue(
    this.key,
    this.value,
    this.group,
    {
      this.id,
    }
  );

  Map<String, dynamic> toInsertMap() => {
    TABLE_VALUES_COLUMN_NAME_KEY : key,
    TABLE_VALUES_COLUMN_NAME_VALUE : value,
    TABLE_VALUES_COLUMN_NAME_GROUP : group.id
  };

  factory FormulaValue.fromDatabaseMap(Map<String, dynamic> entry) => FormulaValue(
    entry[TABLE_VALUES_COLUMN_NAME_KEY],
    entry[TABLE_VALUES_COLUMN_NAME_VALUE],
    getFormulaGroupById(entry[TABLE_FORMULAS_COLUMN_NAME_GROUP]),
    id: entry[TABLE_VALUES_COLUMN_NAME_ID]
  );

  @override
  String toString() {
    return {
      'id': id,
      'key': key,
      'value': value,
      'group' : group,
    }.toString();
  }
}