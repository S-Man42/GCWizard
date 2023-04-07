part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

bool _isLetter(String vname) {
  return [
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
  return ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].contains(vname);
}

bool _isNotDouble(dynamic value) {
  return (value.runtimeType.toString() != 'double');
}

bool _isDouble(dynamic value) {
  return (value.runtimeType.toString() == 'double');
}

bool _isNotInt(dynamic value) {
  return (value.runtimeType.toString() != 'int');
}

bool _isInt(dynamic value) {
  return (value.runtimeType.toString() == 'int');
}

bool _isNotString(dynamic value) {
  return (value.runtimeType.toString() != 'String');
}

bool _isString(dynamic value) {
  return (value.runtimeType.toString() == 'String');
}

bool _differentDataTypes(dynamic x, dynamic y) {
  return (x.runtimeType.toString() != y.runtimeType.toString());
}
