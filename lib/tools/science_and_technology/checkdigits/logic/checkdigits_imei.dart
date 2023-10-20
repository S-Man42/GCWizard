part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

CheckDigitOutput CheckIMEINumber(String number){
  if (number.length == 15) {
    if (checkNumber(number, checkIMEI)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, CalculateNumber(number.substring(0, number.length - 1), CalculateIMEINumber), CalculateGlitch(number, checkIMEI));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String CalculateIMEINumber(String number){
  if (number.length == 14) {
    return number + calculateIMEICheckDigit(number);
  }
  return 'checkdigits_invalid_length';
}

List<String> CalculateIMEIDigits(String number){
  if (number.length == 15 && int.tryParse(number[number.length - 1]) != null) {
    return CalculateDigits(number, checkIMEI);
  } else {
    return ['checkdigits_invalid_length'];
  }
}


bool checkIMEI(String number) {
  return (number[14] == calculateIMEICheckDigit(number.substring(0, number.length - 1)));
}

String  calculateIMEICheckDigit(String number) {
  int sum = 0;
  int product = 0;
  for (int i = 0; i < number.length; i++) {
    if (i % 2 == 0) {
      product = 1 * int.parse(number[i]);
    } else {
      product = 2 * int.parse(number[i]);
    }
    sum = sum + product ~/ 10 + product % 10;
  }
  if (sum >= 100) {
    sum = sum % 100;
  }
  sum = sum % 10;
  sum = 10 - sum;
  return sum.toString();
}