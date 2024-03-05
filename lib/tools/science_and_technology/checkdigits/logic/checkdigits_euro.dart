part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// https://www.geldschein.at/euro-banknoten/euro_seriennummer.html
// https://kryptografie.de/kryptografie/chiffre/euro-banknote.htm
// http://www.pruefziffernberechnung.de/B/Banknoten-EUR.shtml

const EUROBILLDATA = {
  1: {
    'B': ['', 'common_country_Lithuania'],
    'C': ['', 'common_country_Latvia'],
    'D': ['', 'common_country_Estonia'],
    'E': ['', 'common_country_Slovakia'],
    'F': ['', 'common_country_Malta'],
    'G': ['', 'common_country_Cyprus'],
    'H': ['', 'common_country_Slovenia'],
    'J': ['', 'common_country_UnitedKingdom'],
    'K': ['', 'common_country_Sweden'],
    'L': ['', 'common_country_Finland'],
    'M': ['', 'common_country_Portugal'],
    'N': ['', 'common_country_Austria'],
    'P': ['', 'common_country_Netherlands'],
    'R': ['', 'common_country_Luxembourg'],
    'S': ['', 'common_country_Italy'],
    'T': ['', 'common_country_Ireland'],
    'U': ['', 'common_country_France'],
    'V': ['', 'common_country_Spain'],
    'W': ['', 'common_country_Denmark'],
    'X': ['', 'common_country_Germany'],
    'Y': ['', 'common_country_Greece'],
    'Z': ['', 'common_country_Belgium'],
  },
  2: {
    'D': ['Polska Wytwórnia Papierów Wartosciowych', 'common_country_Poland'],
    'E': ['Francois Charles Oberthur Fiduciaire', 'common_country_France'],
    'F': ['Oberthur Bulgarien', 'common_country_Bulgaria'],
    'H': ['De La Rue Currency (Loughton)', 'common_country_UnitedKingdom'],
    'J': ['De La Rue Currency (Gateshead)', 'common_country_UnitedKingdom'],
    'M': ['Valora', 'common_country_Portugal'],
    'N': ['Österreichische Banknoten- und Sicherheitsdruck GmbH', 'common_country_Austria'],
    'P': ['Johan Enschede Security Printing BV', 'common_country_Netherlands'],
    'R': ['Bundesdruckerei GmbH', 'common_country_Germany'],
    'S': ['Banca d’Italia', 'common_country_Italy'],
    'T': ['Central Bank of Ireland', 'common_country_Ireland'],
    'U': ['Banque de France', 'common_country_France'],
    'V': ['Fàbrica National de Mondea y Timbre', 'common_country_Spain'],
    'W': ['Giesecke & Devrient (Leipzig)', 'common_country_Germany'],
    'X': ['Giesecke & Devrient (München)', 'common_country_Germany'],
    'Y': ['Bank of Greece', 'common_country_Greece'],
    'Z': ['Banque Nationale de Belgique', 'common_country_Belgium'],
  },
};

bool _isLetter(String letter) {
  return 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.contains(letter.toUpperCase());
}

int checkEuroSeries(String number) {
  if (_isLetter(number[0]) && _isLetter(number[1])) {
    return 2;
  } else {
    return 1;
  }
}

CheckDigitOutput _CheckEURONumber(String number) {
  if (number == '') {
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
  }

  if (number.length == 12) {
    if (_checkNumber(number, _checkEURO)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, _CalculateCheckDigitAndNumber(number.substring(0, number.length - 1), _CalculateEURONumber),
          _CalculateGlitch(number, _checkEURO));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String _CalculateEURONumber(String number) {
  if (number == '') {
    return 'checkdigits_invalid_length';
  }

  if (number.length == 11) {
    return number + _calculateCheckDigit(number, _calculateEUROCheckDigit);
  } else {
    return 'checkdigits_invalid_length';
  }
}

List<String> _CalculateEURODigits(String number) {
  if (number == '') {
    return ['checkdigits_invalid_length'];
  }

  if (number.length == 12) {
    return _CalculateDigits(number, _checkEURO);
  } else {
    return ['checkdigits_invalid_length'];
  }
}

bool _checkEURO(String number) {
  if (EUROBILLDATA[checkEuroSeries(number)]![number[0]] == null) {
    return false;
  } else{
    return (number[number.length - 1] == _calculateEUROCheckDigit(number.substring(0, number.length - 1)));
  }
}

String _calculateEUROCheckDigit(String number) {
  String result = '';
  int qSum = 0;
  switch (checkEuroSeries(number)) {
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
