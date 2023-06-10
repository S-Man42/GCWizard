part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

String _date() {
  return DateFormat('yyyy/MM/dd').format(DateTime.now());
}

String _time() {
  DateTime now = DateTime.now();
  return DateFormat('HH:mm:ss').format(DateTime.now());
}