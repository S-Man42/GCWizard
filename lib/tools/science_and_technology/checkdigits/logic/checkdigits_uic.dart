part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// https://de.wikipedia.org/wiki/UIC-Wagennummer
// https://de.wikipedia.org/wiki/Eindeutige_Fahrzeugnummer
// https://de.wikipedia.org/wiki/Code_f%C3%BCr_das_Austauschverfahren
// https://de.wikipedia.org/wiki/UIC-Kennzeichnung_der_Triebfahrzeuge
// https://de.wikipedia.org/wiki/UIC-L%C3%A4ndercode

final UIC_COUNTRY_CODE = {
  '10':	'common_country_Finland',
  '20':	'common_country_Russia',
  '21':	'common_country_Belarus',
  '22':	'common_country_Ukraine',
  '23':	'common_country_Moldova',
  '24':	'common_country_Lithuania',
  '25':	'common_country_Latvia',
  '26':	'common_country_Estonia',
  '27':	'common_country_Kazakhstan',
  '28':	'common_country_Georgia',
  '29':	'common_country_Uzbekistan',
  '30':	'common_country_NorthKorea',
  '31':	'common_country_Mongolia',
  '32':	'common_country_Vietnam',
  '33':	'common_country_PeoplesRepublicofChina',
  '40':	'common_country_Cuba',
  '41':	'common_country_Albania',
  '42':	'common_country_Japan',
  '44':	'common_country_BosniaandHerzegovina',
  '49':	'common_country_BosniaandHerzegovina',
  '50':	'common_country_BosniaandHerzegovina',
  '51':	'common_country_Poland',
  '52':	'common_country_Bulgaria',
  '53':	'common_country_Romania',
  '54':	'common_country_CzechRepublic',
  '55':	'common_country_Hungary',
  '56':	'common_country_Slovakia',
  '57':	'common_country_Azerbaijan',
  '58':	'common_country_Armenia',
  '59':	'common_country_Kyrgyzstan',
  '60':	'common_country_Ireland',
  '61':	'common_country_SouthKorea',
  '62':	'common_country_Montenegro',
  '65':	'common_country_NorthMacedonia',
  '66':	'common_country_Tajikistan',
  '67':	'common_country_Turkmenistan',
  '68':	'common_country_Afghanistan',
  '70':	'common_country_UnitedKingdom',
  '71':	'common_country_Spain',
  '72':	'common_country_Serbia',
  '73':	'common_country_Greece',
  '74':	'common_country_Sweden',
  '75':	'common_country_Turkey',
  '76':	'common_country_Norway',
  '78':	'common_country_Croatia',
  '79':	'common_country_Slovenia',
  '80':	'common_country_Germany',
  '81':	'common_country_Austria',
  '82':	'common_country_Luxembourg',
  '83':	'common_country_Italy',
  '84':	'common_country_Netherlands',
  '85':	'common_country_Switzerland',
  '86':	'common_country_Denmark',
  '87':	'common_country_France',
  '88':	'common_country_Belgium',
  '90':	'common_country_Egypt',
  '91':	'common_country_Tunisia',
  '92':	'common_country_Algeria',
  '93':	'common_country_Morocco',
  '94':	'common_country_Portugal',
  '95':	'common_country_Israel',
  '96':	'common_country_Iran',
  '97':	'common_country_Syria',
  '98':	'common_country_Lebanon',
  '99':	'common_country_Iraq',
};

CheckDigitOutput _CheckUICNumber(String number){
  if (number.length == 12) {
    if (_checkNumber(number, _checkUIC)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(false, _CalculateCheckDigitAndNumber(number.substring(0, number.length - 1), _CalculateUICNumber), _CalculateGlitch(number, _checkUIC));
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
  if (number.length == 12) {
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
  if (sum % 10 == 0) {
    return '0';
  } else {
    return (10 * (sum ~/ 10 + 1) - sum).toString();
  }
}