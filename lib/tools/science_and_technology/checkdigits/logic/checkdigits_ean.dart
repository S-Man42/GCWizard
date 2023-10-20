part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// https://de.wikipedia.org/wiki/Pr%C3%BCfziffer#:~:text=Berechnung%20der%20Pr%C3%BCfziffer%3A%201%20Von%20links%20nach%20rechts,unmittelbar%20nach%20der%20Produktbildung%20erfolgen.%20Weitere%20Artikel...%20
// https://www.activebarcode.de/codes/checkdigit/modulo10.html

CheckDigitOutput CheckEANNumber(String number){
  if (number == '') {
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
  }

  number = number.replaceAll('#', '');
  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18) {
    if (checkNumber(number, checkEAN)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, CalculateNumber(number.substring(0, number.length - 1), CalculateEANNumber), CalculateGlitch(number, checkEAN));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String CalculateEANNumber(String number){
  if (number == '') {
    return 'checkdigits_invalid_length';
  }

  if (number.length == 7 || number.length == 12 || number.length == 13 || number.length == 17) {
    return number + calculateCheckDigit(number, calculateEANCheckDigit);
  }
  else {
    return 'checkdigits_invalid_length';
  }
}

List<String> CalculateEANDigits(String number){
  if ( number == '') {
    return ['checkdigits_invalid_length'];
  }

  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18 && int.tryParse(number[number.length - 1]) != null) {
    return CalculateDigits(number, checkEAN);
  } else {
    return ['checkdigits_invalid_length'];
  }
}

bool checkEAN(String number) {
  return (number[number.length - 1] == calculateEANCheckDigit(number.substring(0, number.length - 1)));
}

String  calculateEANCheckDigit(String number) {
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