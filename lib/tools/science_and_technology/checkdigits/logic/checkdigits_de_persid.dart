// https://www.php-einfach.de/diverses/personalausweis-ueberpruefen/
// http://www.pruefziffernberechnung.de/P/Personalausweis-DE.shtml

part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';


CheckDigitOutput _CheckDEPersIDNumber(String number){
  if (number.length == 25) {
    if (_checkNumber(number, _checkDEPersID)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, _CalculateNumber(number.substring(0, number.length - 1), _CalculateDEPersIDNumber), _CalculateGlitch(number, _checkDEPersID));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String _CalculateDEPersIDNumber(String number){

  return '';
}

List<String> _CalculateDEPersIDDigits(String number){

  return [''];
}

bool _checkDEPersID(String number) {
  String cdSerial = _calcCD(number.substring(0, 10));
  String cdDateBirth = _calcCD(number.substring(10, 16));
  String cdDateValid = _calcCD(number.substring(17, 23));
  String cdTotal = _calcCD(number.substring(0,24));

  if (cdSerial == number[9] && cdDateBirth == number[16] && cdDateValid == number[23] && cdTotal == number[24]) {
    return true;
  } else {
    return false;
  }
}

String _calcCD(String number){
  int result = 0;
  final weight = {0 : 7, 1 : 3, 2: 1};

  for (int i = 0; i < number.length; i++) {
    result = result + _number(number[i]) * weight[i % 3]! % 10;
  }
  result = result % 10;
  return result.toString();
}

int _number(String digit){
  if (int.tryParse(digit) == null) {
    return int.parse(ID_LETTERCODE[digit] as String);
  } else {
    return int.parse(digit);
  }
}