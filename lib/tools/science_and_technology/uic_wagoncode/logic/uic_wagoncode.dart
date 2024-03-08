import 'package:gc_wizard/utils/list_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';

part 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode_freight.dart';
part 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode_freight_classification_codes.dart';
part 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode_freight_classification_descriptions.dart';


enum UICWagonTypes {INVALID, OUT_OF_ORDER, ENGINE, FREIGHT_WAGON, PASSENGER_WAGON}

class UICWagonCode {
  late final UICWagonType wagonType;
  late final String countryCode;
  late final String country;
  late final String runningNumber;
  late final String checkDigit;
  late final bool isValidCheckDigit;

  UICWagonCode(String number) {
    countryCode = _getCountryCode(number);
    country = _getCountry(countryCode);
    runningNumber = number.substring(8, 11);
    checkDigit = number[11];
    isValidCheckDigit = isValidUICWagonCodeCheckDigit(number);
  }
}

const Map<String, String> UICCountryCode = {
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

String _getCountryCode(String number) {
  return number.substring(2, 4);
}

String _getCountry(String? code) {
  return UICCountryCode[code] ?? 'uic_countrycode_invalid';
}

const UIC_InteroperabilityCode_Freight = {
  '00': 'ausgemustert',
  '01': 'TEN, COTIF',
  '2': 'TEN, COTIF, PPV/PPW, RIV',
  '3': 'TEN, COTIF, PPV/PPW, RIV',
  '4': 'Sonstige Güterwagen',
  '8': 'Sonstige Güterwagen',
};

String _sanitizeNumber(String number) {
  return number.replaceAll(RegExp(r'[^0-9]'), '');
}

class UICWagonType {
  late final String code;
  late final UICWagonTypes name;

  UICWagonType(this.code, this.name);
}

UICWagonType _checkMainType(String number) {
  if (number.startsWith('00')) {
    return UICWagonType('00', UICWagonTypes.OUT_OF_ORDER);
  }

  var code = number[0];
  late UICWagonTypes type;

  switch (code) {
    case '0':
    case '1':
    case '2':
    case '3':
    case '4': type = UICWagonTypes.FREIGHT_WAGON; break;
    case '5':
    case '6':
    case '7': type = UICWagonTypes.PASSENGER_WAGON; break;
    case '8': type = UICWagonTypes.FREIGHT_WAGON; break;
    case '9': type = UICWagonTypes.ENGINE; break;
    default: type = UICWagonTypes.INVALID; break;
  }

  return UICWagonType(code, type);
}

class UICWagonCodeReturn {
  final UICWagonType type;
  final UICWagonCode? details;

  UICWagonCodeReturn(this.type, [this.details]);
}

UICWagonCodeReturn uicWagonCode(String number) {
  number = _sanitizeNumber(number);
  if (number.length != 12) {
    throw const FormatException('uic_wagoncode_invalid_number');
  }

  UICWagonCode? details;

  var mainType = _checkMainType(number);
  switch(mainType.name) {
    case UICWagonTypes.OUT_OF_ORDER:
      break;
    case UICWagonTypes.ENGINE:
      break;
    case UICWagonTypes.PASSENGER_WAGON:
      break;
    case UICWagonTypes.FREIGHT_WAGON:
      details = UICWagonCodeFreightWagon(number);
      break;
    default:
      break;
  }

  return UICWagonCodeReturn(mainType, details);
}

bool isValidUICWagonCodeCheckDigit(String number) {
  number = _sanitizeNumber(number);
  if (number.length != 12) {
    return false;
  }

  return (number[11] == calculateUICWagonCodeCheckDigit(number.substring(0, number.length - 1)));
}

String calculateUICWagonCodeCheckDigit(String number) {
  number = _sanitizeNumber(number);

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



