part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

CheckDigitOutput CheckEURONumber(String number){
  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18) {

    if (checkNumber(number, checkEURO)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, CalculateNumber(number.substring(0, number.length - 1), CalculateEURONumber), CalculateGlitch(number, checkEURO));
    }
  }
  return CheckDigitOutput(false, '', ['']);
}

String CalculateEURONumber(String number){
  if (number.length == 7 || number.length == 12 || number.length == 13 || number.length == 17) {
    return number + calculateEUROCheckDigit(number);
  }
  return '';
}

List<String> CalculateEURODigits(String number){
  if (number.length == 8 || number.length == 13 || number.length == 14 || number.length == 18 && int.tryParse(number[number.length - 1]) != null) {
    return CalculateDigits(number, checkEURO);
  } else {
    return [''];
  }
}

bool checkEURO(String number) {
  return (number[number.length - 1] == calculateEUROCheckDigit(number.substring(0, number.length - 1)));
}

String  calculateEUROCheckDigit(String number) {
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