part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// https://de.wikipedia.org/wiki/UIC-Wagennummer
// https://de.wikipedia.org/wiki/Eindeutige_Fahrzeugnummer
// https://de.wikipedia.org/wiki/Code_f%C3%BCr_das_Austauschverfahren
// https://de.wikipedia.org/wiki/UIC-Kennzeichnung_der_Triebfahrzeuge
// https://de.wikipedia.org/wiki/UIC-L%C3%A4ndercode

enum UIC_TYPE { NONE, LOCOMOTIVE, FREIGHTWAGON, PASSENGERCOACH }

const UIC_COUNTRY_CODE = {
  '10': 'common_country_Finland',
  '20': 'common_country_Russia',
  '21': 'common_country_Belarus',
  '22': 'common_country_Ukraine',
  '23': 'common_country_Moldova',
  '24': 'common_country_Lithuania',
  '25': 'common_country_Latvia',
  '26': 'common_country_Estonia',
  '27': 'common_country_Kazakhstan',
  '28': 'common_country_Georgia',
  '29': 'common_country_Uzbekistan',
  '30': 'common_country_NorthKorea',
  '31': 'common_country_Mongolia',
  '32': 'common_country_Vietnam',
  '33': 'common_country_PeoplesRepublicofChina',
  '40': 'common_country_Cuba',
  '41': 'common_country_Albania',
  '42': 'common_country_Japan',
  '44': 'common_country_BosniaandHerzegovina',
  '49': 'common_country_BosniaandHerzegovina',
  '50': 'common_country_BosniaandHerzegovina',
  '51': 'common_country_Poland',
  '52': 'common_country_Bulgaria',
  '53': 'common_country_Romania',
  '54': 'common_country_CzechRepublic',
  '55': 'common_country_Hungary',
  '56': 'common_country_Slovakia',
  '57': 'common_country_Azerbaijan',
  '58': 'common_country_Armenia',
  '59': 'common_country_Kyrgyzstan',
  '60': 'common_country_Ireland',
  '61': 'common_country_SouthKorea',
  '62': 'common_country_Montenegro',
  '65': 'common_country_NorthMacedonia',
  '66': 'common_country_Tajikistan',
  '67': 'common_country_Turkmenistan',
  '68': 'common_country_Afghanistan',
  '70': 'common_country_UnitedKingdom',
  '71': 'common_country_Spain',
  '72': 'common_country_Serbia',
  '73': 'common_country_Greece',
  '74': 'common_country_Sweden',
  '75': 'common_country_Turkey',
  '76': 'common_country_Norway',
  '78': 'common_country_Croatia',
  '79': 'common_country_Slovenia',
  '80': 'common_country_Germany',
  '81': 'common_country_Austria',
  '82': 'common_country_Luxembourg',
  '83': 'common_country_Italy',
  '84': 'common_country_Netherlands',
  '85': 'common_country_Switzerland',
  '86': 'common_country_Denmark',
  '87': 'common_country_France',
  '88': 'common_country_Belgium',
  '90': 'common_country_Egypt',
  '91': 'common_country_Tunisia',
  '92': 'common_country_Algeria',
  '93': 'common_country_Morocco',
  '94': 'common_country_Portugal',
  '95': 'common_country_Israel',
  '96': 'common_country_Iran',
  '97': 'common_country_Syria',
  '98': 'common_country_Lebanon',
  '99': 'common_country_Iraq',
};

const UIC_LOCOMOTIVE_CODE = {
  // https://de.wikipedia.org/wiki/UIC-Kennzeichnung_der_Triebfahrzeuge
  // https://en.wikipedia.org/wiki/UIC_identification_marking_for_tractive_stock
  '90': 'checkdigits_uic_typecode_locomotive_90',
  '91': 'checkdigits_uic_typecode_locomotive_91',
  '92': 'checkdigits_uic_typecode_locomotive_92',
  '93': 'checkdigits_uic_typecode_locomotive_93',
  '94': 'checkdigits_uic_typecode_locomotive_94',
  '95': 'checkdigits_uic_typecode_locomotive_95',
  '96': 'checkdigits_uic_typecode_locomotive_96',
  '97': 'checkdigits_uic_typecode_locomotive_97',
  '98': 'checkdigits_uic_typecode_locomotive_98',
  '99': 'checkdigits_uic_typecode_locomotive_99',
};

const UIC_PASSENGERCOACH_CODE = {
  // https://de.wikipedia.org/wiki/Code_f%C3%BCr_das_Austauschverfahren
  // https://www.dansk-jernbanearkiv.dk/uic438/u438.htm
  '50': "checkdigits_uic_typecode_passengercoach_50",
  '51': "checkdigits_uic_typecode_passengercoach_51",
  '52': "checkdigits_uic_typecode_passengercoach_52",
  '54': "checkdigits_uic_typecode_passengercoach_53",
  '56': "checkdigits_uic_typecode_passengercoach_56",
  '57': "checkdigits_uic_typecode_passengercoach_57",
  '60': "checkdigits_uic_typecode_passengercoach_60",
  '61': "checkdigits_uic_typecode_passengercoach_61",
  '62': "checkdigits_uic_typecode_passengercoach_62",
  '63': "checkdigits_uic_typecode_passengercoach_63",
  '64': "checkdigits_uic_typecode_passengercoach_64",
  '65': "checkdigits_uic_typecode_passengercoach_65",
  '66': "checkdigits_uic_typecode_passengercoach_66",
  '67': "checkdigits_uic_typecode_passengercoach_66",
  '68': "checkdigits_uic_typecode_passengercoach_66",
  '69': "checkdigits_uic_typecode_passengercoach_66",
  '70': "checkdigits_uic_typecode_passengercoach_70",
  '71': "checkdigits_uic_typecode_passengercoach_71",
  '73': "checkdigits_uic_typecode_passengercoach_73",
};

const UIC_FREIGHTWAGON_CODE = {
  // https://de.wikipedia.org/wiki/Code_f%C3%BCr_das_Austauschverfahren
  // https://www.dansk-jernbanearkiv.dk/uic438/u438.htm
  '': '',
};

const Map<UIC_TYPE, Map<String, String>> UIC_CODE_CATEGORY = {
  // https://en.wikipedia.org/wiki/UIC_classification_of_goods_wagons
  // https://de.wikipedia.org/wiki/UIC-Bauart-Bezeichnungssystem_f%C3%BCr_G%C3%BCterwagen#Gattungsbuchstaben
  UIC_TYPE.LOCOMOTIVE: {
    // checkdigits_uic_typecode_locomotive_category_
    '0': '',
    '1': '',
    '2': '',
    '3': '',
    '4': '',
    '5': '',
    '6': '',
    '7': '',
    '8': '',
    '9': '',
  },
  UIC_TYPE.FREIGHTWAGON: {
    // https://de.wikipedia.org/wiki/UIC-Bauart-Bezeichnungssystem_f%C3%BCr_G%C3%BCterwagen
    // https://en.wikipedia.org/wiki/UIC_classification_of_goods_wagons
    '0': 'checkdigits_uic_freight_category_0',
    '1': 'checkdigits_uic_freight_category_1',
    '2': 'checkdigits_uic_freight_category_2',
    '3': 'checkdigits_uic_freight_category_3',
    '4': 'checkdigits_uic_freight_category_4',
    '5': 'checkdigits_uic_freight_category_5',
    '6': 'checkdigits_uic_freight_category_6',
    '7': 'checkdigits_uic_freight_category_7',
    '8': 'checkdigits_uic_freight_category_8',
    '9': 'checkdigits_uic_freight_category_9',
  },
  UIC_TYPE.PASSENGERCOACH: {
    // checkdigits_uic_typecode_passengercoach_category_
    // https://en.wikipedia.org/wiki/UIC_classification_of_railway_coaches
    // https://de.wikipedia.org/wiki/UIC-Bauart-Bezeichnungssystem_f%C3%BCr_Reisezugwagen
    '0': 'checkdigits_uic_typecode_passengercoach_category_0',
    '1': 'checkdigits_uic_typecode_passengercoach_category_1',
    '2': 'checkdigits_uic_typecode_passengercoach_category_2',
    '3': 'checkdigits_uic_typecode_passengercoach_category_3',
    '4': 'checkdigits_uic_typecode_passengercoach_category_4',
    '5': 'checkdigits_uic_typecode_passengercoach_category_5',
    '6': 'checkdigits_uic_typecode_passengercoach_category_6',
    '7': 'checkdigits_uic_typecode_passengercoach_category_7',
    '8': 'checkdigits_uic_typecode_passengercoach_category_8',
    '9': 'checkdigits_uic_typecode_passengercoach_category_9',
  },
};

CheckDigitOutput _CheckUICNumber(String number) {
  if (number.length == 12) {
    if (_checkNumber(number, isValidUICWagonCodeCheckDigit)) {
      return CheckDigitOutput(true, '', ['']);
    } else {
      return CheckDigitOutput(
          false,
          _CalculateCheckDigitAndNumber(number.substring(0, number.length - 1), _CalculateUICNumber),
          _CalculateGlitch(number, isValidUICWagonCodeCheckDigit));
    }
  }
  return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
}

String _CalculateUICNumber(String number) {
  if (number.length == 11) {
    return number + calculateUICWagonCodeCheckDigit(number);
  }
  return 'checkdigits_invalid_length';
}

List<String> _CalculateUICDigits(String number) {
  if (number.length == 12) {
    return _CalculateDigits(number, isValidUICWagonCodeCheckDigit);
  } else {
    return ['checkdigits_invalid_length'];
  }
}
