part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// http://www.pruefziffernberechnung.de/I/IBAN.shtml
// https://de.wikipedia.org/wiki/Internationale_Bankkontonummer
// https://en.wikipedia.org/wiki/International_Bank_Account_Number
// https://web.archive.org/web/20171220203336/http://www.europebanks.info/ibanguide.php#5

// https://www.bundesbank.de/de/aufgaben/unbarer-zahlungsverkehr/serviceangebot/pruefzifferberechnung/pruefzifferberechnung-fuer-kontonummern-603282
// https://www.bundesbank.de/resource/blob/603320/16a80c739bbbae592ca575905975c2d0/mL/pruefzifferberechnungsmethoden-data.pdf
// https://www.bundesbank.de/de/aufgaben/unbarer-zahlungsverkehr/serviceangebot/bankleitzahlen/download-bankleitzahlen-602592

// GC7DCXZ => calculate checkDigit
//         => calculate Number
// GC4TKB5 => calculate checkDigit

CheckDigitOutput _CheckIBANNumber(String number) {
  number = number.toUpperCase();
  if (number == '' || number.length < 5) {
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
  }
  if (_checkNumber(number, _checkIBAN)) {
    return CheckDigitOutput(true, '', ['']);
  } else {
    return CheckDigitOutput(
        false, _CalculateNumber(number, _CalculateIBANNumber), _CalculateGlitch(number, _checkIBAN));
  }
}

final IBAN_DATA_MEANING = {
  'b': 'checkdigits_iban_data_b_bank_number',
  's': 'checkdigits_iban_data_s_branch_code',
  'k': 'checkdigits_iban_data_k_account_number',
  'K': 'checkdigits_iban_data_K_control_digit',
  'd': 'checkdigits_iban_data_d_type_of_account',
  'r': 'checkdigits_iban_data_r_regional_code',
};

final IBAN_DATA = {
  'EG': [
      {'country': 'common_country_Egypt'},
      {'b': 4},
      {'s': 4},
      {'k': 17},
  ],
  'AL': [
      {'country': 'common_country_Albania'},
      {'b': 3},
      {'s': 4},
      {'K': 1},
      {'k': 16},
  ],
  'DZ': [
      {'country': 'common_country_Algeria'},
      {'b': 4},
      {'s': 5},
      {'k': 10},
      {'k': 2},
  ],
  'AD': [
      {'country': 'common_country_Andorra'},
      {'b': 4},
      {'s': 4},
      {'k': 12},
  ],
  'AO': [
      {'country': 'common_country_Angola'},
      {'b': 4},
      {'s': 5},
      {'k': 11},
      {'k': 2},
  ],
  'AZ': [
      {'country': 'common_country_Azerbaijan'},
      {'b': 4},
      {'k': 20},
  ],
  'BH': [
    {'country': 'common_country_Bahrain'},
    {'b': 4},
    {'k': 14},
  ],
  'BE': [
    {'country': 'common_country_Belgium'},
    {'b': 3},
    {'k': 7},
    {'K': 2},
  ],
  'BY': [
    {'country': 'common_country_Belarus'},
    {'s': 4},
    {'b': 4},
    {'k': 16},
  ],
  'BJ': [
    {'country': 'common_country_Benin'},
    {'b': 5},
    {'s': 5},
    {'k': 12},
    {'K': 2},
  ],
  'BA': [
    {'country': 'common_country_BosniaandHerzegovina'},
    {'b': 3},
    {'s': 3},
    {'k': 8},
    {'K': 2},
  ],
  'BR': [
    {'country': 'common_country_Brasil'},
    {'b': 7},
    {'s': 5},
    {'k': 12},
  ],
  'BG': [
    {'country': 'common_country_Bulgaria'},
    {'b': 4},
    {'s': 4},
    {'d': 2},
    {'k': 8},
  ],
  'BF': [
    {'country': 'common_country_BurkinaFaso'},
    {'b': 5},
    {'s': 5},
    {'k': 11},
    {'K': 2},
  ],
  'BI': [
    {'country': 'common_country_Burundi'},
    {'b': 5},
    {'s': 5},
    {'k': 13},
  ],
  'VG': [
    {'country': 'common_country_BritishVirginIslands'},
    {'b': 3},
    {'k': 16},
  ],
  'CI': [
    {'country': 'common_country_CotedIvoire'},
    {'b': 5},
    {'s': 5},
    {'k': 12},
    {'K': 2},
  ],
  'CF': [
    {'country': 'common_country_CentralAfricanRepublic'},
    {'b': 5},
    {'s': 5},
    {'k': 11},
    {'K': 2},
  ],
  'CG': [
    {'country': 'common_country_RepublicoftheCongo'},
    {'b': 5},
    {'s': 5},
    {'k': 11},
    {'K': 2},
  ],
  'CH': [
    {'country': 'common_country_Switzerland'},
    {'b': 5},
    {'k': 12},
  ],
  'CM': [
    {'country': 'common_country_Cameroon'},
    {'b': 5},
    {'s': 5},
    {'k': 11},
    {'K': 2},
  ],
  'CR': [
    {'country': 'common_country_CostaRica'},
    {'k': 18},
  ],
  'CV': [
    {'country': 'common_country_CapeVerde'},
    {'b': 5},
    {'s': 4},
    {'k': 11},
    {'K': 2},
  ],
  'CY': [
    {'country': 'common_country_Cyprus'},
    {'b': 3},
    {'s': 5},
    {'k': 16},
  ],
  'CZ': [
    {'country': 'common_country_CzechRepublic'},
    {'b': 4},
    {'k': 16},
  ],


  'DE': [
      {'country': 'common_country_Germany'},
      {'b': 8},
      {'k': 10},
  ],
  'FR': [
      {'country': 'common_country_France'},
      {'b': 5},
      {'s': 5},
      {'k': 11},
      {'K': 2},
  ],
  'AT': [
      {'country': 'common_country_Austria'},
      {'b': 5},
      {'k': 11},
  ],
  'GB': [
      {'country': 'common_country_UnitedKingdom'},
      {'b': 4},
      {'s': 6},
      {'k': 8},
  ],
};

String _CalculateIBANNumber(String number) {
  if (number.length < 5) {
    return ('checkdigits_invalid_length');
  } else {
    return number.substring(0, 2) + _calculateIBANCheckDigit(number) + number.substring(4);
  }
}

List<String> _CalculateIBANDigits(String number) {
  return _CalculateDigits(number, _checkIBAN);
}

bool _checkIBAN(String number) {
  number = number.substring(4) +
      ID_LETTERCODE[number[0]].toString() +
      ID_LETTERCODE[number[1]].toString() +
      number[2] +
      number[3];
  return (BigInt.parse(number) % BigInt.from(97) == BigInt.one);
}

String _calculateIBANCheckDigit(String number) {
  number = number.substring(4) + ID_LETTERCODE[number[0]].toString() + ID_LETTERCODE[number[1]].toString() + '00';
  BigInt checkDigit = BigInt.from(98) - BigInt.parse(number) % BigInt.from(97);
  if (checkDigit < BigInt.from(10)) {
    number = '0' + checkDigit.toString();
  } else {
    number = checkDigit.toString();
  }
  return number;
}
