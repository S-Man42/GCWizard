part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// https://de.wikipedia.org/wiki/UIC-Kennzeichnung_der_Triebfahrzeuge
// https://de.wikipedia.org/wiki/UIC-L%C3%A4ndercode


CheckDigitOutput _CheckUICNumber(String number){
  if (number.length == 12) {
    if (_checkNumber(number, _checkUIC)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, _CalculateNumber(number.substring(0, number.length - 1), _CalculateUICNumber), _CalculateGlitch(number, _checkUIC));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String _CalculateUICNumber(String number){
  if (number.length == 11) {
    return number + _calculateUICCheckDigit(number);
  }
  return 'checkdigits_invalid_length';
}

List<String> _CalculateUICDigits(String number){
  if (number.length == 12 && int.tryParse(number[number.length - 1]) != null) {
    return _CalculateDigits(number, _checkUIC);
  } else {
    return ['checkdigits_invalid_length'];
  }
}


bool _checkUIC(String number) {
  return (number[11] == _calculateUICCheckDigit(number.substring(0, number.length - 1)));
}

String  _calculateUICCheckDigit(String number) {
  int sum = 0;
  int product = 0;
  String digits = '';
  for (int i = 0; i < number.length; i++) {
    if (i % 2 == 0) {
      product = 2 * int.parse(number[i]);
    } else {
      product = 1 * int.parse(number[i]);
    }
    digits = digits + product.toString();
  }
  for (int i = 0; i < digits.length; i++) {
    sum = sum + int.parse(digits[i]);
  }
  return (10 * (sum ~/ 10 + 1) - sum).toString();
}