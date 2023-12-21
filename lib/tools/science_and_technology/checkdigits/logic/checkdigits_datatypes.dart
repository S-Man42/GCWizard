part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

final Map<String, String> ID_LETTERCODE = {
  'A' : '10',
  'B' : '11',
  'C' : '12',
  'D' : '13',
  'E' : '14',
  'F' : '15',
  'G' : '16',
  'H' : '17',
  'I' : '18',
  'J' : '19',
  'K' : '20',
  'L' : '21',
  'M' : '22',
  'N' : '23',
  'O' : '24',
  'P' : '25',
  'Q' : '26',
  'R' : '27',
  'S' : '28',
  'T' : '29',
  'U' : '30',
  'V' : '31',
  'W' : '32',
  'X' : '33',
  'Y' : '34',
  'Z' : '35',
};

enum CheckDigitsMode {
  EAN,
  DEPERSID,
  DETAXID,
  EURO,
  IBAN,
  IMEI,
  ISBN,
  UIC,
  GTIN,
}

final MaskTextInputFormatter MASKINPUTFORMATTER_EURO = MaskTextInputFormatter(mask: "@§##########", filter: {"@": RegExp(r'[A-Za-z?]'), "§": RegExp(r'[A-Za-z0-9?]'),"#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_IBAN = MaskTextInputFormatter(mask: "@@################################", filter: {"@": RegExp(r'[A-Za-z?]'), "#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_ISBN = MaskTextInputFormatter(mask: "#########@###", filter: {"@": RegExp(r'[A-Za-z0-9?]'), "#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_DEPERSID = MaskTextInputFormatter(mask: "@#########@<<#######<#######<<<<<<<#", filter: {"@": RegExp(r'[A-Za-z?]'), "#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_DEPERSID_SERIAL = MaskTextInputFormatter(mask: "@@@@@@@@@@", filter: {"@": RegExp(r'[A-Za-z0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_DEPERSID_DATE = MaskTextInputFormatter(mask: "#######", filter: {"#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_DEPERSID_DIGIT = MaskTextInputFormatter(mask: "#", filter: {"#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_IMEI = MaskTextInputFormatter(mask: "###############", filter: {"#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_EAN = MaskTextInputFormatter(mask: "##################", filter: {"#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_GTIN = MaskTextInputFormatter(mask: "##################", filter: {"#": RegExp(r'[0-9?]')});
final MaskTextInputFormatter MASKINPUTFORMATTER_UIC = MaskTextInputFormatter(mask: "############", filter: {"#": RegExp(r'[0-9?]')});

Map <CheckDigitsMode, MaskTextInputFormatter> INPUTFORMATTERS = {
  CheckDigitsMode.ISBN : MASKINPUTFORMATTER_ISBN,
  CheckDigitsMode.IBAN : MASKINPUTFORMATTER_IBAN,
  CheckDigitsMode.EURO : MASKINPUTFORMATTER_EURO,
  CheckDigitsMode.DEPERSID : MASKINPUTFORMATTER_DEPERSID,
  CheckDigitsMode.UIC : MASKINPUTFORMATTER_UIC,
};

Map<CheckDigitsMode, String> INPUTFORMATTERS_HINT = {
  CheckDigitsMode.ISBN : "000000000@000",
  CheckDigitsMode.IBAN : "AA00000000000000000000000000000000",
  CheckDigitsMode.EURO : "A@0000000000",
  CheckDigitsMode.DEPERSID : "0000000000@<<0000000<0000000<<<<<<<0",
  CheckDigitsMode.UIC : "000000000000",
};

final Map<CheckDigitsMode, int> maxInt = {
  CheckDigitsMode.EAN     : 999999999999999999, // 18 digits
  CheckDigitsMode.UIC     : 999999999999,       // 12 digits
  CheckDigitsMode.GTIN    : 999999999999999999, // 18 digits
  CheckDigitsMode.IMEI    : 999999999999999,    // 15 digits
  CheckDigitsMode.DETAXID : 99999999999,        // 11 digits
};

class CheckDigitOutput{
  final bool correct;
  final String correctDigit;
  final List<String> correctNumbers;

  CheckDigitOutput(this.correct, this.correctDigit, this.correctNumbers);
}

