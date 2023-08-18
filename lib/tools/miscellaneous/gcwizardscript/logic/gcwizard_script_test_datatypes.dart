part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

bool _isALetter(String vname) {
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

bool _isADigit(String vname) {
  return const ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].contains(vname);
}

bool _isNotADouble(Object? value) {
  return !_isADouble(value); //.runtimeType.toString() != 'double');
}

bool _isADouble(Object? value) {
  return (value is double); //.runtimeType.toString() == 'double');
}

bool _isNotAInt(Object? value) {
  return !_isAInt(value); // .runtimeType.toString() != 'int');
}

bool _isAInt(Object? value) {
  return (value is int); //.runtimeType.toString() == 'int');
}

bool _isNotAString(Object? value) {
  return !_isAString(value); //.runtimeType.toString() != 'String');
}

bool _isAString(Object? value) {
  return (value is String); //.runtimeType.toString() == 'String');
}

bool _isANumber(Object? value) {
  return _isAInt(value) || _isADouble(value); //.runtimeType.toString() == 'String');
}

bool _isNotANumber(Object? value) {
  return _isNotAInt(value) && _isNotADouble(value); //.runtimeType.toString() == 'String');
}

bool _isAList(Object? value){
  return (value.runtimeType.toString() == '_GCWList');
}

bool _isNotAList(Object? value){
  return !_isAList(value);
}

