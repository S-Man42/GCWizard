import 'package:gc_wizard/logic/tools/science_and_technology/check_digits/base/check_digits.dart';
import 'ean.dart';


CheckDigitOutput CheckISBNNumber(String number){
  number = number.replaceAll('#', '').toUpperCase();
  if (number == null || number == '')
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);

  if (number.length == 10 || number.length == 13) {
    if (checkNumber(number, checkISBN))
      return CheckDigitOutput(true, '', ['']);
    else {
      return CheckDigitOutput(false, CalculateNumber(number.substring(0, number.length - 1), CalculateISBNNumber), CalculateGlitch(number, checkISBN));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String CalculateISBNNumber(String number){
  if (number.length == 9)
    return number + calculateCheckDigit(number, calculateISBNCheckDigit);
  else
  if (number.length == 12)
    if (int.tryParse(number) == null)
      return 'checkdigits_invalid_format';
    else
      return number + calculateCheckDigit(number, calculateEANCheckDigit);
  else
    return 'checkdigits_invalid_length';
}

List<String> CalculateISBNDigits(String number){
  number = number.toUpperCase();
  if (number.length == 10 || number.length == 13 && (int.tryParse(number[number.length - 1]) != null || number[number.length - 1] == 'X')) {
    return CalculateDigits(number, checkISBN);
  } else
    return ['checkdigits_invalid_length'];
}


bool checkISBN(String number) {
  if (number.length > 10 && int.tryParse(number) == null)
    return false;
  else
    return (number[number.length - 1] == calculateCheckDigit(number.substring(0, number.length - 1), calculateISBNCheckDigit));
}

String  calculateISBNCheckDigit(String number) {
  if(number.length == 9) {
    int sum = 0;
    for (int i = 1; i < 10; i++) {
      sum = sum + i * int.parse(number[i]);
      sum = sum % 11;
      if (sum == 10)
        return 'X';
      else
        return sum.toString();
    }
    if (sum >= 100)
      sum = sum % 100;
    sum = sum % 10;
    sum = 10 - sum;
  } else {
    if (int.tryParse(number) == null)
      return '';
    else
      return calculateCheckDigit(number, calculateEANCheckDigit);
  }
}