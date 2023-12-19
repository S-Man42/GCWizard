part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// https://de.wikipedia.org/wiki/Pr%C3%BCfziffer#:~:text=Berechnung%20der%20Pr%C3%BCfziffer%3A%201%20Von%20links%20nach%20rechts,unmittelbar%20nach%20der%20Produktbildung%20erfolgen.%20Weitere%20Artikel...%20
// https://www.activebarcode.de/codes/checkdigit/modulo10.html

CheckDigitOutput _CheckEANNumber(String number){
  if (number == '') {
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
  }

  number = number.replaceAll('#', '');
  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18) {
    if (_checkNumber(number, _checkEAN)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, _CalculateNumber(number.substring(0, number.length - 1), _CalculateEANNumber), _CalculateGlitch(number, _checkEAN));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String _CalculateEANNumber(String number){
  if (number == '') {
    return 'checkdigits_invalid_length';
  }

  if (number.length == 7 || number.length == 12 || number.length == 13 || number.length == 17) {
    return number + _calculateCheckDigit(number, _calculateEANCheckDigit);
  }
  else {
    return 'checkdigits_invalid_length';
  }
}

List<String> _CalculateEANDigits(String number){
  if ( number == '') {
    return ['checkdigits_invalid_length'];
  }

  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18 && int.tryParse(number[number.length - 1]) != null) {
    return _CalculateDigits(number, _checkEAN);
  } else {
    return ['checkdigits_invalid_length'];
  }
}

bool _checkEAN(String number) {
  return (number[number.length - 1] == _calculateEANCheckDigit(number.substring(0, number.length - 1)));
}

String  _calculateEANCheckDigit(String number) {
  int sum = 0;
  for (int i = 0; i < number.length; i++) {
    if (i % 2 == 0) {
      sum = sum + 1 * int.parse(number[i]);
    } else {
      sum = sum + 3 * int.parse(number[i]);
    }
  }
  if (sum >= 100) {
    sum = sum % 100;
  }
  sum = sum % 10;
  sum = 10 - sum;
  return sum.toString();
}