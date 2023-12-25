part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// https://www.bindb.com/bin-database
// https://www.bindb.com/identify-prepaid-cards
// https://www.bindb.com/card-schemes
// https://kreditkarte.net/ratgeber/kreditkartennummer/

// https://www.vccgenerator.org/de/credit-card-validator-result/

// http://www.pruefziffernberechnung.de/K/Kreditkarten.shtml

final Map<String, String> CHECKDIGITS_CREDITCARD_MMI = {
  '0': 'checkdigits_creditcard_major_industry_identifier_0',
  '1': 'checkdigits_creditcard_major_industry_identifier_1',
  '2': 'checkdigits_creditcard_major_industry_identifier_2',
  '3': 'checkdigits_creditcard_major_industry_identifier_3',
  '4': 'checkdigits_creditcard_major_industry_identifier_4',
  '5': 'checkdigits_creditcard_major_industry_identifier_5',
  '6': 'checkdigits_creditcard_major_industry_identifier_6',
  '7': 'checkdigits_creditcard_major_industry_identifier_7',
  '8': 'checkdigits_creditcard_major_industry_identifier_8',
  '9': 'checkdigits_creditcard_major_industry_identifier_9',
};

final Map<String, String> CHECKDIGITS_CREDITCARD_PREFIX = {
  '34': 'American Express',
  '35': 'Japan Credit Bureau',
  '36': 'Diners Club',
  '37': 'American Express',
  '38': 'Diners Club',
  '40': 'Visa',
  '41': 'Visa',
  '42': 'Visa',
  '43': 'Visa',
  '44': 'Visa',
  '45': 'Visa',
  '46': 'Visa',
  '47': 'Visa',
  '48': 'Visa',
  '49': 'Visa',
  '51': 'Mastercard',
  '52': 'Mastercard',
  '53': 'Mastercard',
  '54': 'Mastercard',
  '55': 'Mastercard',
  '60': 'Merchandising-Cards (International)',
  '61': 'Merchandising-Cards (International)',
  '62': 'China Union Pay',
  '63': 'Merchandising-Cards (International)',
  '64': 'Merchandising-Cards (International)',
  '65': 'Merchandising-Cards (International)',
  '66': 'Merchandising-Cards (International)',
  '67': 'Merchandising-Cards (International)',
  '68': 'Merchandising-Cards (International)',
  '69': 'Merchandising-Cards (International)',
};

final Map<String, int> CHECKDIGITS_CREDITCARD_LENGTH = {
  '34': 15,
  '37': 15,
  '36': 14,
  '38': 14,
};

CheckDigitOutput _CheckCreditCardNumber(String number) {
  print(number);
  if (_checkCreditCardNumberLength(number)) {
    if (_checkNumber(number, _checkCreditCard)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(
          false,
          _CalculateCheckDigitAndNumber(number.substring(0, number.length - 1), _CalculateCreditCardNumber),
          _CalculateGlitch(number, _checkCreditCard));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String _CalculateCreditCardNumber(String number) {
  if (_checkCreditCardNumberLengthWithoutCD(number)) {
    return number + _calculateCreditCardCheckDigit(number);
  }
  return 'checkdigits_invalid_length';
}

List<String> _CalculateCreditCardDigits(String number) {
  if (_checkCreditCardNumberLength(number)) {
    return _CalculateDigits(number, _checkCreditCard);
  } else {
    return ['checkdigits_invalid_length'];
  }
}

bool _checkCreditCard(String number) {
  return (number[number.length - 1] == _calculateCreditCardCheckDigit(number.substring(0, number.length - 1)));
}

String _calculateCreditCardCheckDigit(String number) {
  int sum = 0;
  int product = 0;
  for (int i = 0; i < number.length; i++) {
    if (i % 2 == 0) {
      product = 2 * int.parse(number[i]);
    } else {
      product = 1 * int.parse(number[i]);
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

bool _checkCreditCardNumberLength(String number) {
  if (number.length >= 2) {
    if (number.substring(0, 1) == '4') {
      return ((13 <= number.length) && (number.length <= 16));
    } else {
      if (CHECKDIGITS_CREDITCARD_LENGTH[number.substring(0, 2)] == null) {
        print(number);
        return (number.length == 16);
      } else {
        return (number.length == CHECKDIGITS_CREDITCARD_LENGTH[number.substring(0, 2)]);
      }
    }
  }
  return false;
}

bool _checkCreditCardNumberLengthWithoutCD(String number) {
  if (number.length >= 2) {
    if (number.substring(0, 1) == '4') {
      return ((13 <= number.length) && (number.length <= 15));
    } else {
      if (CHECKDIGITS_CREDITCARD_LENGTH[number.substring(0, 2)] == null) {
        return (number.length == 15);
      } else {
        return (number.length == CHECKDIGITS_CREDITCARD_LENGTH[number.substring(0, 2)]! - 1);
      }
    }
  }
  return false;
}
