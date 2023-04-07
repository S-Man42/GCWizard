part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

CheckDigitOutput CheckUICNumber(String number){
  if (number.length == 12) {
    if (checkNumber(number, checkUIC)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, CalculateNumber(number.substring(0, number.length - 1), CalculateUICNumber), CalculateGlitch(number, checkUIC));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String CalculateUICNumber(String number){
  if (number.length == 11) {
    return number + calculateUICCheckDigit(number);
  }
  return 'checkdigits_invalid_length';
}

List<String> CalculateUICDigits(String number){
  if (number.length == 12 && int.tryParse(number[number.length - 1]) != null) {
    return CalculateDigits(number, checkUIC);
  } else {
    return ['checkdigits_invalid_length'];
  }
}


bool checkUIC(String number) {
  return (number[11] == calculateUICCheckDigit(number.substring(0, number.length - 1)));
}

String  calculateUICCheckDigit(String number) {
  int sum = 0;
  int product = 0;
  int checkdigit = 0;
  String digits = '';
  for (int i = 0; i < number.length; i++) {
    if (i % 2 == 0) {
      product = 1 * int.parse(number[i]);
    } else {
      product = 2 * int.parse(number[i]);
    }
    digits = digits + product.toString();
  }
  for (int i = 0; i < digits.length; i++) {
    sum = sum + int.parse(digits[i]);
  }
  return (10 * (sum /~ 10 + 1) - sum).toString();
}