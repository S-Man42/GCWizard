import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';


CheckDigitOutput CheckDETaxIDNumber(String number){
  if (number.length == 11) {
    if (checkDETaxID(number))
      return CheckDigitOutput(true, '', ['']);
    else {
      return CheckDigitOutput(false, CalculateNumber(number.substring(0, number.length - 1), CalculateDETaxIDNumber), CalculateGlitch(number, checkDETaxID));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String CalculateDETaxIDNumber(String number){
  if (number.length == 10) {
    return number + calculateDETaxIDCheckDigit(number);
  }
  return 'checkdigits_invalid_length';
}

List<String> CalculateDETaxIDDigits(String number){
  if (number.length == 11) {
    return CalculateDigits(number, checkDETaxID);
  } else
    return ['checkdigits_invalid_length'];
}


bool checkDETaxID(String number) {
  return (number[10] == calculateDETaxIDCheckDigit(number.substring(0, number.length - 1)));
}


String  calculateDETaxIDCheckDigit(String number) {
  int product = 10;
  int sum = 0;
  int pz = 0;
  for (int i = 0; i < 10; i++){
    sum = (int.parse(number[i]) + product) % 10;
    if (sum == 0)
      sum = 10;
    product = (sum * 2) % 11;
  }
  pz = 11 - product;
  if (pz == 10)
    pz = 0;
  return pz.toString();
}