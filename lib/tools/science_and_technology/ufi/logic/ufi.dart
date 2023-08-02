// Source: https://poisoncentres.echa.europa.eu/documents/1789887/1803644/ufi_developers_manual_en.pdf/9d47a5c9-ba58-4b5c-8101-7d5610928035

import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';

class UFI {
  final String countryCode;
  final String countryName;
  final String ufiRegExp;
  final int countryGroupCodeG;
  final int? numberOfBitsForCountryCodeB;
  final int? countryCodeC;
  final BigInt Function(String)? specialConversion;

  const UFI({
    required this.countryCode,
    required this.countryName,
    required this.ufiRegExp,
    required this.countryGroupCodeG,
    required this.numberOfBitsForCountryCodeB,
    required this.countryCodeC,
    this.specialConversion
  });
}

const int UFI_MAX_FORMULATIONNUMBER = 268435455;

final List<UFI> UFI_CODES = [
  const UFI(countryCode: 'FR', countryName: 'common_country_France', ufiRegExp: r'[0-9A-Z]{2}[0-9]{9}', countryGroupCodeG: 1, numberOfBitsForCountryCodeB: null, countryCodeC: null),
  const UFI(countryCode: 'GB', countryName: 'common_country_UnitedKingdom', ufiRegExp: r'([0-9]{9}([0-9]{3})?|[A- Z]{2}[0-9]{3})', countryGroupCodeG: 2, numberOfBitsForCountryCodeB: null, countryCodeC: null),
  const UFI(countryCode: 'XN', countryName: 'common_country_NorthernIreland', ufiRegExp: r'([0-9]{9}([0-9]{3})?|[A- Z]{2}[0-9]{3})', countryGroupCodeG: 2, numberOfBitsForCountryCodeB: null, countryCodeC: null),
  const UFI(countryCode: 'LT', countryName: 'common_country_Lithuania', ufiRegExp: r'([0-9]{9}|[0-9]{12})', countryGroupCodeG: 3, numberOfBitsForCountryCodeB: 1, countryCodeC: 0),
  const UFI(countryCode: 'SE', countryName: 'common_country_Sweden', ufiRegExp: r'[0-9]{12}', countryGroupCodeG: 3, numberOfBitsForCountryCodeB: 1, countryCodeC: 1),
  const UFI(countryCode: 'HR', countryName: 'common_country_Croatia', ufiRegExp: r'[0-9]{11}', countryGroupCodeG: 4, numberOfBitsForCountryCodeB: 4, countryCodeC: 0),
  const UFI(countryCode: 'IT', countryName: 'common_country_Italy', ufiRegExp: r'[0-9]{11}', countryGroupCodeG: 4, numberOfBitsForCountryCodeB: 4, countryCodeC: 1),
  const UFI(countryCode: 'LV', countryName: 'common_country_Latvia', ufiRegExp: r'[0-9]{11}', countryGroupCodeG: 4, numberOfBitsForCountryCodeB: 4, countryCodeC: 2),
  const UFI(countryCode: 'NL', countryName: 'common_country_Netherlands', ufiRegExp: r'[0-9]{9}B[0-9]{2}', countryGroupCodeG: 4, numberOfBitsForCountryCodeB: 4, countryCodeC: 3),
  const UFI(countryCode: 'BG', countryName: 'common_country_Bulgaria', ufiRegExp: r'[0-9]{9,10}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 0),
  const UFI(countryCode: 'CZ', countryName: 'common_country_CzechRepublic', ufiRegExp: r'[0-9]{8,10}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 1),
  const UFI(countryCode: 'IE', countryName: 'common_country_Ireland', ufiRegExp: r'([0-9][A-Z*+][0-9]{5}[A-Z]|[0-9]{7}([A-Z]W?|[A-Z]{2}))', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 2, specialConversion: _vConversionIE),
  const UFI(countryCode: 'ES', countryName: 'common_country_Spain', ufiRegExp: r'[0-9A-Z][0-9]{7}[0-9A-Z]', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 3, specialConversion: _vConversionES),
  const UFI(countryCode: 'PL', countryName: 'common_country_Poland', ufiRegExp: r'[0-9]{10}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 4),
  const UFI(countryCode: 'RO', countryName: 'common_country_Romania', ufiRegExp: r'[0-9]{2,10}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 5),
  const UFI(countryCode: 'SK', countryName: 'common_country_Slovakia', ufiRegExp: r'[0-9]{10}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 6),
  const UFI(countryCode: 'CY', countryName: 'common_country_Cyprus', ufiRegExp: r'[0-9]{8}[A-Z]', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 7, specialConversion: _vConversionCY),
  const UFI(countryCode: 'IS', countryName: 'common_country_Iceland', ufiRegExp: r'[A-Z0-9]{6}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 8),
  const UFI(countryCode: 'BE', countryName: 'common_country_Belgium', ufiRegExp: r'0[0-9]{9}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 9),
  const UFI(countryCode: 'DE', countryName: 'common_country_Germany', ufiRegExp: r'[0-9]{9}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 10),
  const UFI(countryCode: 'EE', countryName: 'common_country_Estonia', ufiRegExp: r'[0-9]{9}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 11),
  const UFI(countryCode: 'GR', countryName: 'common_country_Greece', ufiRegExp: r'[0-9]{9}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 12),
  const UFI(countryCode: 'EL', countryName: 'common_country_Greece', ufiRegExp: r'[0-9]{9}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 12),
  const UFI(countryCode: 'NO', countryName: 'common_country_Norway', ufiRegExp: r'[0-9]{9}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 13),
  const UFI(countryCode: 'PT', countryName: 'common_country_Portugal', ufiRegExp: r'[0-9]{9}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 14),
  const UFI(countryCode: 'AT', countryName: 'common_country_Austria', ufiRegExp: r'U[0-9]{8}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 15),
  const UFI(countryCode: 'DK', countryName: 'common_country_Denmark', ufiRegExp: r'[0-9]{8}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 16),
  const UFI(countryCode: 'FI', countryName: 'common_country_Finland', ufiRegExp: r'[0-9]{8}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 17),
  const UFI(countryCode: 'HU', countryName: 'common_country_Hungary', ufiRegExp: r'[0-9]{8}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 18),
  const UFI(countryCode: 'LU', countryName: 'common_country_Luxembourg', ufiRegExp: r'[0-9]{8}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 19),
  const UFI(countryCode: 'MT', countryName: 'common_country_Malta', ufiRegExp: r'[0-9]{8}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 20),
  const UFI(countryCode: 'SI', countryName: 'common_country_Slovenia', ufiRegExp: r'[0-9]{8}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 21),
  const UFI(countryCode: 'LI', countryName: 'common_country_Liechtenstein', ufiRegExp: r'[0-9]{5}', countryGroupCodeG: 5, numberOfBitsForCountryCodeB: 7, countryCodeC: 22),
];

String _UFI_BASE31 = '0123456789ACDEFGHJKMNPQRSTUVWXY';

int _alphabetValue(String char) {
  return 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.indexOf(char);
}

int _alphaNumValue(String char) {
  return '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.indexOf(char);
}

BigInt _vConversionRegular(String vatNumber) {
  return BigInt.parse(vatNumber.replaceAll(RegExp(r'[^\d]'), ''));
}

BigInt _vConversionIE(String vatNumber) {
  RegExp regExp1 = RegExp(r'[0-9][A-Z*+][0-9]{5}[A-Z]');
  RegExp regExp2 = RegExp(r'[0-9]{7}([A-Z]W?|[A-Z]{2})');

  if (regExp1.hasMatch(vatNumber)) {
    var d = BigInt.parse(vatNumber.replaceAll(RegExp(r'[^\d]'), ''));
    var c = vatNumber.replaceAll(RegExp(r'[\d]'), '');

    int c1;
    switch (c[0]) {
      case '+': c1 = 26; break;
      case '*': c1 = 27; break;
      default: c1 = _alphabetValue(c[0]);
    }

    int c2 = _alphabetValue(c[1]);

    return BigInt.from(26 * c1 + c2) * BigInt.from(10).pow(6) + d;
  } else if (regExp2.hasMatch(vatNumber)) {
    var d = BigInt.parse(vatNumber.replaceAll(RegExp(r'[^\d]'), ''));
    var c = vatNumber.replaceAll(RegExp(r'[\d]'), '');

    var c1 = _alphabetValue(c[0]);
    var c2 = c.length == 1 ? 0 : _alphabetValue(c[1]);

    return BigInt.two.pow(33) + (BigInt.from(26 * c2 + c1) * BigInt.from(10).pow(7) + d);
  }

  throw Exception('Invalid VAT Number for IE');
}

BigInt _vConversionCY(String vatNumber) {
  var d = BigInt.parse(vatNumber.replaceAll(RegExp(r'[^\d]'), ''));
  var l = _alphabetValue(vatNumber[vatNumber.length - 1]);

  return BigInt.from(l) * BigInt.from(10).pow(8) + d;
}

BigInt _vConversionES(String vatNumber) {
  var d = BigInt.parse(vatNumber.substring(1, vatNumber.length - 1));
  var c1 = _alphaNumValue(vatNumber[0]);
  var c2 = _alphaNumValue(vatNumber[vatNumber.length - 1]);

  return BigInt.from(36 * c1 + c2) * BigInt.from(10).pow(7) + d;
}

UFI _ufiByCountryCode(String countryCode) {
  return UFI_CODES.firstWhere((UFI ufi) => ufi.countryCode == countryCode);
}

String encodeUFI(String countryCode, String vatNumber, int formulationNumber) {
  UFI ufi = _ufiByCountryCode(countryCode);
  var _vatNumber = vatNumber.toUpperCase();

  ////// Step 1 ///////////////////////////////////////////////////////////////

  var g = convertBase(ufi.countryGroupCodeG.toString(), 10, 2);
  g = g.padLeft(4, '0');

  var b = ufi.numberOfBitsForCountryCodeB!;  // TODO: FR?
  var c = convertBase(ufi.countryCodeC.toString(), 10, 2);
  c = c.padLeft(b, '0');

  var n = convertBase(
      ufi.specialConversion == null
          ? _vConversionRegular(_vatNumber).toString()
          : ufi.specialConversion!(_vatNumber).toString(),
      10, 2
  );
  n = n.padLeft(41 - b, '0');

  var f = convertBase(formulationNumber.toString(), 10, 2);
  f = f.padLeft(28, '0');

  var ufiPayloadBinary = f + g + c + n + '0';
  var ufiPayload = convertBase(ufiPayloadBinary, 2, 10);

  ////// Step 2 ///////////////////////////////////////////////////////////////

  var base31 = convertBase(ufiPayload, 10, 31, alphabet: _UFI_BASE31);
  base31 = base31.padLeft(15, '0');

  ////// Step 3 ///////////////////////////////////////////////////////////////

  var reOrganised = base31[5] + base31[4] + base31[3] + base31[7] + base31[2] + base31[8] +
      base31[9] + base31[10] + base31[1] + base31[0] + base31[11] + base31[6] + base31[12] +
      base31[13] + base31[14];

  ////// Step 4 ///////////////////////////////////////////////////////////////

  int x = 0;
  for (int i = 0; i < reOrganised.length; i++) {
    var u = _UFI_BASE31.indexOf(reOrganised[i]);
    x += (i + 2) * u;
  }

  int u0 = modulo(31 - modulo(x, 31), 31) as int;
  var checkSum = _UFI_BASE31[u0];

  return insertEveryNthCharacter(checkSum + reOrganised, 4, '-');
}

String decodeUFI(String ufi) {
  return '';
}

void main() {
  print(encodeUFI('IE', '9Z54321Y', 134217728));
}