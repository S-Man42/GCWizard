part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

bool _isLetter(String vname) {
  return const [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ].contains(vname.toUpperCase());
}

bool _isDigit(String vname) {
  return const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].contains(vname);
}

bool _isNotDouble(Object? value) {
  return !_isDouble(value); //.runtimeType.toString() != 'double');
}

bool _isDouble(Object? value) {
  return (value is double); //.runtimeType.toString() == 'double');
}

bool _isNotInt(Object? value) {
  return !_isInt(value); // .runtimeType.toString() != 'int');
}

bool _isInt(Object? value) {
  return (value is int); //.runtimeType.toString() == 'int');
}

bool _isNotString(Object? value) {
  return !_isString(value); //.runtimeType.toString() != 'String');
}

bool _isString(Object? value) {
  return (value is String); //.runtimeType.toString() == 'String');
}

bool _isNumber(Object? value) {
  return _isInt(value) || _isDouble(value); //.runtimeType.toString() == 'String');
}

bool _isNotNumber(Object? value) {
  return _isNotInt(value) && _isNotDouble(value); //.runtimeType.toString() == 'String');
}

bool _isList(Object? value){
  return (value.runtimeType.toString() == '_GCWList');
}

bool _isNotList(Object? value){
  return !_isList(value);
}

