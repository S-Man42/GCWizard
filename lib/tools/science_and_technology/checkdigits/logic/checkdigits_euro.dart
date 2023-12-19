part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// https://www.geldschein.at/euro-banknoten/euro_seriennummer.html
// https://kryptografie.de/kryptografie/chiffre/euro-banknote.htm
// http://www.pruefziffernberechnung.de/B/Banknoten-EUR.shtml

bool _isLetter(String letter){
return 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.contains(letter.toUpperCase());
}

int _checkEuroSeries(String number){
  if (_isLetter(number[0]) && _isLetter(number[1])) {
    return 2;
  } else {
    return 1;
  }
}

CheckDigitOutput _CheckEURONumber(String number){
  if (number.length == 12) {
    if (_checkNumber(number, _checkEURO)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, _CalculateNumber(number.substring(0, number.length - 1), _CalculateEURONumber), _CalculateGlitch(number, _checkEURO));
    }
  }
  return CheckDigitOutput(false, '', ['']);
}

String _CalculateEURONumber(String number){
  if (number == '') {
    return 'checkdigits_invalid_length';
  }

  if (number.length == 11) {
    return number + _calculateCheckDigit(number, _calculateEUROCheckDigit);
  }
  else {
    return 'checkdigits_invalid_length';
  }
}

List<String> _CalculateEURODigits(String number){
  if ( number == '') {
    return ['checkdigits_invalid_length'];
  }

  if (number.length == 12) {
    return _CalculateDigits(number, _checkEURO);
  } else {
    return ['checkdigits_invalid_length'];
  }
}

bool _checkEURO(String number) {
  return (number[number.length - 1] == _calculateEUROCheckDigit(number.substring(0, number.length - 1)));
}

String  _calculateEUROCheckDigit(String number) {
  String result = '';
  int qSum = 0;
  switch (_checkEuroSeries(number)) {
    case 1:
      int n1 = alphabet_AZ[number[0].toUpperCase()]!;
      qSum = sum([int.parse(n1.toString() + number.substring(1, number.length))]).toInt();
      qSum = 8 - (qSum % 9);
      if (qSum == 0) {
        result = '9';
      } else {
        result = qSum.toString();
      }
      break;
    case 2:
      int n1 = alphabet_AZ[number[0].toUpperCase()]!;
      int n2 = alphabet_AZ[number[1].toUpperCase()]!;
      qSum = sum([int.parse(n1.toString() + n2.toString() + number.substring(2, number.length))]).toInt();
      qSum = 7 - (qSum % 9);
      if (qSum == -1) {
        result = '8';
      } else if (qSum == 0) {
        result = '9';
      } else {
        result = qSum.toString();
      }
      break;
  }
  return result;
}