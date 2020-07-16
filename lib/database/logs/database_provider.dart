import 'package:gc_wizard/database/common/database_provider.dart';
import 'package:gc_wizard/database/logs/model.dart';
import 'package:gc_wizard/database/logs/names.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';
import 'package:sqflite/sqflite.dart';

class LogsDbProvider implements IDatabaseProvider {

  @override
  Future onCreateDatabase(Database db, int version) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $TABLE_TYPES_NAME ("
          "  $TABLE_TYPES_COLUMN_NAME_ID INTEGER PRIMARY KEY,"
          "  $TABLE_LOGS_COLUMN_NAME_TYPE TEXT"
          ")"
    );

    var _logTypeValues = logTypes.map((logType) => '(${logType.id}, \'${logType
        .name}\')').join(',');

    await db.execute(
      "INSERT INTO $TABLE_TYPES_NAME("
          "  $TABLE_TYPES_COLUMN_NAME_ID, "
          "  $TABLE_LOGS_COLUMN_NAME_TYPE"
          ") VALUES $_logTypeValues"
    );

    await db.execute(
      "CREATE TABLE IF NOT EXISTS $TABLE_LOGS_NAME ("
          "  $TABLE_LOGS_COLUMN_NAME_ID INTEGER PRIMARY KEY,"
          "  $TABLE_LOGS_COLUMN_NAME_TIMESTAMP DATETIME DEFAULT (strftime('%Y-%m-%d %H:%M:%f', 'now')),"
          "  $TABLE_LOGS_COLUMN_NAME_TYPE INTEGER,"
          "  $TABLE_LOGS_COLUMN_NAME_MESSAGE TEXT,"
          "  $TABLE_LOGS_COLUMN_NAME_STACKTRACE TEXT,"
          "  FOREIGN KEY($TABLE_LOGS_COLUMN_NAME_TYPE) REFERENCES $TABLE_TYPES_NAME($TABLE_TYPES_COLUMN_NAME_ID)"
          ")"
    );
  }

  @override
  Future onOpenDatabase(Database db) async {
    //remove too old entries
    var dateTimeBeforeDelete = DateTime.now().subtract(Duration(days: Prefs.getInt('log_keep_entries_in_days')));
    var formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dateTimeBeforeDelete);

    await db.delete(TABLE_LOGS_NAME, where: '$TABLE_LOGS_COLUMN_NAME_TIMESTAMP < ?', whereArgs: [formattedDateTime]);
  }

  insert(LogEntry logEntry) async {
    var db = await DatabaseProvider.provider.database;
    var newId = await db.insert(TABLE_LOGS_NAME, logEntry.toInsertMap());
    await DatabaseProvider.provider.close();

    return newId;
  }

  getLogs() async {
    var db = await DatabaseProvider.provider.database;
    var result = await db.query(TABLE_LOGS_NAME);
    await DatabaseProvider.provider.close();

    List<LogEntry> logs = result.isNotEmpty ? result.map((logEntry) => LogEntry.fromDatabaseMap(logEntry)).toList() : [];
    return logs;
  }
}

