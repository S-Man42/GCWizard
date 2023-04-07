part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _date() {
  DateTime now = DateTime.now();
  return now.year.toString() + "/" + now.month.toString() + "/" + now.day.toString();
}

String _time() {
  DateTime now = DateTime.now();
  return now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString();
}