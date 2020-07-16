import 'dart:io';

import 'package:gc_wizard/database/formula_solver/database_provider.dart';
import 'package:gc_wizard/database/logs/database_provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


const String DATABASE_FILE_NAME = 'gcwizard.db';

abstract class IDatabaseProvider {
  Future onOpenDatabase(Database db);
  Future onCreateDatabase(Database db, int version);
}

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider provider = DatabaseProvider._();

  static Database _database;

  static final List<IDatabaseProvider> _providerRegistry = [
    LogsDbProvider(),
    FormulaSolverDbProvider()
  ];

  Future<Database> get database async {
    if (_database != null && _database.isOpen)
      return _database;

    // if _database is null we instantiate it
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_FILE_NAME);
    return await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) async {
        for (var registeredProvider in _providerRegistry) {
          await registeredProvider.onOpenDatabase(db);
        }
      },
      onCreate: (Database db, int version) async {
        for (var registeredProvider in _providerRegistry) {
          await registeredProvider.onCreateDatabase(db, version);
        }
      }
    );
  }

  close() async {
    var db = await database;
    await db.close();
  }
}