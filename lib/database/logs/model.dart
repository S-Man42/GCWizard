import 'package:gc_wizard/database/logs/names.dart';

class LogType {
  int id;
  String name;

  LogType({this.id, this.name});
}

final LogType logTypeERROR = LogType(id: 1, name: 'ERROR');
final LogType logTypeWARNING = LogType(id: 2, name: 'WARNING');
final LogType logTypeINFO = LogType(id: 3, name: 'INFO');

List<LogType> logTypes = [
  logTypeERROR,
  logTypeWARNING,
  logTypeINFO
];

LogType getLogTypeById(int id) {
  return logTypes.firstWhere((logType) => logType.id == id);
}

class LogEntry {
  int id;
  DateTime timestamp;
  LogType type;
  String message;
  String stackTrace;

  LogEntry(
    this.type,
    this.message,
    this.stackTrace,
    {
      this.id,
      this.timestamp
    }
  );

  Map<String, dynamic> toInsertMap() => {
    TABLE_LOGS_COLUMN_NAME_TYPE : type.id,
    TABLE_LOGS_COLUMN_NAME_MESSAGE : message,
    TABLE_LOGS_COLUMN_NAME_STACKTRACE : stackTrace
  };

  factory LogEntry.fromDatabaseMap(Map<String, dynamic> entry) => LogEntry(
    getLogTypeById(entry[TABLE_LOGS_COLUMN_NAME_TYPE]),
    entry[TABLE_LOGS_COLUMN_NAME_MESSAGE],
    entry[TABLE_LOGS_COLUMN_NAME_STACKTRACE],
    id: entry[TABLE_LOGS_COLUMN_NAME_ID],
    timestamp: DateTime.tryParse(entry[TABLE_LOGS_COLUMN_NAME_TIMESTAMP])
  );

  @override
  String toString() {
    return {
      'id': id,
      'timestamp': timestamp,
      'type' : type,
      'message': message,
      //'stackTrace' : stackTrace
    }.toString();
  }
}