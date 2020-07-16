import 'package:gc_wizard/database/common/database_provider.dart';
import 'package:gc_wizard/database/formula_solver/model.dart';
import 'package:gc_wizard/database/formula_solver/names.dart';
import 'package:sqflite/sqflite.dart';

class FormulaSolverDbProvider implements IDatabaseProvider {

  @override
  Future onCreateDatabase(Database db, int version) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $TABLE_GROUPS_NAME ("
          "  $TABLE_GROUPS_COLUMN_NAME_ID INTEGER PRIMARY KEY,"
          "  $TABLE_GROUPS_COLUMN_NAME_NAME TEXT"
          ")"
    );

    await db.execute(
      "CREATE TABLE IF NOT EXISTS $TABLE_FORMULAS_NAME ("
          "  $TABLE_FORMULAS_COLUMN_NAME_ID INTEGER PRIMARY KEY,"
          "  $TABLE_FORMULAS_COLUMN_NAME_FORMULA TEXT,"
          "  $TABLE_FORMULAS_COLUMN_NAME_GROUP INTEGER,"
          "  FOREIGN KEY($TABLE_FORMULAS_COLUMN_NAME_GROUP) REFERENCES $TABLE_GROUPS_NAME($TABLE_GROUPS_COLUMN_NAME_ID) ON DELETE CASCADE"
          ")"
    );

    await db.execute(
      "CREATE TABLE IF NOT EXISTS $TABLE_VALUES_NAME ("
          "  $TABLE_VALUES_COLUMN_NAME_ID INTEGER PRIMARY KEY,"
          "  $TABLE_VALUES_COLUMN_NAME_KEY TEXT,"
          "  $TABLE_VALUES_COLUMN_NAME_VALUE TEXT,"
          "  $TABLE_VALUES_COLUMN_NAME_GROUP INTEGER,"
          "  FOREIGN KEY($TABLE_VALUES_COLUMN_NAME_GROUP) REFERENCES $TABLE_GROUPS_NAME($TABLE_GROUPS_COLUMN_NAME_ID) ON DELETE CASCADE"
          ")"
    );
  }

  @override
  Future onOpenDatabase(Database db) async {
    // SQLite does not enable foreign keys per default. You need to enable this once every database connection
    // https://stackoverflow.com/a/5901100/3984221
    await db.execute(
        "PRAGMA foreign_keys = ON"
    );
  }

  insertGroup(FormulaGroup group) async {
    var db = await DatabaseProvider.provider.database;
    var newId = await db.insert(TABLE_GROUPS_NAME, group.toInsertMap());
    await DatabaseProvider.provider.close();

    return newId;
  }

  updateGroup(FormulaGroup group) async {
    var db = await DatabaseProvider.provider.database;
    await db.update(TABLE_GROUPS_NAME, group.toInsertMap(), where: '$TABLE_GROUPS_COLUMN_NAME_ID = ?', whereArgs: [group.id]);
    await DatabaseProvider.provider.close();
  }

  deleteGroup(FormulaGroup group) async {
    var db = await DatabaseProvider.provider.database;
    await db.delete(TABLE_GROUPS_NAME, where: '$TABLE_GROUPS_COLUMN_NAME_ID = ?', whereArgs: [group.id]);
    await DatabaseProvider.provider.close();
  }

  insertFormula(Formula formula) async {
    var db = await DatabaseProvider.provider.database;
    var newId = await db.insert(TABLE_FORMULAS_NAME, formula.toInsertMap());
    await DatabaseProvider.provider.close();

    return newId;
  }

  updateFormula(Formula formula) async {
    var db = await DatabaseProvider.provider.database;
    await db.update(TABLE_FORMULAS_NAME, formula.toInsertMap(), where: '$TABLE_FORMULAS_COLUMN_NAME_ID = ?', whereArgs: [formula.id]);
    await DatabaseProvider.provider.close();
  }

  deleteFormula(Formula formula) async {
    var db = await DatabaseProvider.provider.database;
    await db.delete(TABLE_FORMULAS_NAME, where: '$TABLE_FORMULAS_COLUMN_NAME_ID = ?', whereArgs: [formula.id]);
    await DatabaseProvider.provider.close();
  }

  insertValue(FormulaValue value) async {
    var db = await DatabaseProvider.provider.database;
    var newId = await db.insert(TABLE_VALUES_NAME, value.toInsertMap());
    await DatabaseProvider.provider.close();

    return newId;
  }

  updateValue(FormulaValue value) async {
    var db = await DatabaseProvider.provider.database;
    await db.update(TABLE_VALUES_NAME, value.toInsertMap(), where: '$TABLE_VALUES_COLUMN_NAME_ID = ?', whereArgs: [value.id]);
    await DatabaseProvider.provider.close();
  }

  deleteValue(FormulaValue value) async {
    var db = await DatabaseProvider.provider.database;
    await db.delete(TABLE_VALUES_NAME, where: '$TABLE_VALUES_COLUMN_NAME_ID = ?', whereArgs: [value.id]);
    await DatabaseProvider.provider.close();
  }

  Future<List<FormulaGroup>> getGroups() async {
    var db = await DatabaseProvider.provider.database;
    var result = await db.query(TABLE_GROUPS_NAME);
    await DatabaseProvider.provider.close();

    List<FormulaGroup> groups = result.isNotEmpty ? result.map((group) => FormulaGroup.fromDatabaseMap(group)).toList() : [];
    return groups;
  }

  Future<List<Formula>> getFormulas() async {
    var db = await DatabaseProvider.provider.database;
    var result = await db.query(TABLE_FORMULAS_NAME);
    await DatabaseProvider.provider.close();

    List<Formula> formulas = result.isNotEmpty ? result.map((formula) => Formula.fromDatabaseMap(formula)).toList() : [];
    return formulas;
  }

  Future<List<Formula>> getFormulasByGroup(FormulaGroup group) async {
    var db = await DatabaseProvider.provider.database;
    var result = await db.query(TABLE_FORMULAS_NAME, where: '$TABLE_FORMULAS_COLUMN_NAME_GROUP = ?', whereArgs: [group.id]);

    await DatabaseProvider.provider.close();

    List<Formula> formulas = result.isNotEmpty ? result.map((formula) => Formula.fromDatabaseMap(formula)).toList() : [];
    return formulas;
  }

  Future<List<FormulaValue>> getFormulaValuesByGroup(FormulaGroup group) async {
    var db = await DatabaseProvider.provider.database;
    var result = await db.query(TABLE_VALUES_NAME, where: '$TABLE_VALUES_COLUMN_NAME_GROUP = ?', whereArgs: [group.id]);
    await DatabaseProvider.provider.close();

    List<FormulaValue> values = result.isNotEmpty ? result.map((value) => FormulaValue.fromDatabaseMap(value)).toList() : [];
    return values;
  }
}

