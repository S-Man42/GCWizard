import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_datatypes.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_ean.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_de_persid.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_de_taxid.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_iban.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_imei.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_isbn.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_euro.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_uic.dart';

CheckDigitOutput checkDigitsCheckNumber(CheckDigitsMode mode, String number){
  if (number == '') {
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
  }

  number = number.toUpperCase();
  switch(mode) {
    case CheckDigitsMode.EAN:
      return CheckEANNumber(number);
    case CheckDigitsMode.DEPERSID:
      return CheckDEPersIDNumber(number);
    case CheckDigitsMode.DETAXID:
      return CheckDETaxIDNumber(number);
    case CheckDigitsMode.EURO:
      return CheckEURONumber(number);
    case CheckDigitsMode.IBAN:
      return CheckIBANNumber(number);
    case CheckDigitsMode.IMEI:
      return CheckIMEINumber(number);
    case CheckDigitsMode.ISBN:
      return CheckISBNNumber(number);
    case CheckDigitsMode.UIC:
      return CheckUICNumber(number);
    default:
      return CheckDigitOutput(false, '', ['']);
  }
}

String checkDigitsCalculateNumber(CheckDigitsMode mode, String number){
  if (number == '') {
    return 'checkdigits_invalid_length';
  }

  number = number.toUpperCase();
  switch(mode) {
    case CheckDigitsMode.EAN:
      return CalculateNumber(number, CalculateEANNumber);
    case CheckDigitsMode.DEPERSID:
      return CalculateNumber(number, CalculateDEPersIDNumber);
    case CheckDigitsMode.DETAXID:
      return CalculateNumber(number, CalculateDETaxIDNumber);
    case CheckDigitsMode.EURO:
      return CalculateNumber(number, CalculateEURONumber);
    case CheckDigitsMode.IBAN:
      return CalculateNumber(number, CalculateIBANNumber);
    case CheckDigitsMode.IMEI:
      return CalculateNumber(number, CalculateIMEINumber);
    case CheckDigitsMode.ISBN:
      return CalculateNumber(number, CalculateISBNNumber);
    case CheckDigitsMode.UIC:
      return CalculateNumber(number, CalculateUICNumber);
    default:
      return '';
  }
}

List<String> checkDigitsCalculateDigits(CheckDigitsMode mode, String number){
  if (number == '') {
    return ['checkdigits_invalid_length'];
  }

  number = number.toUpperCase();
  switch(mode) {
    case CheckDigitsMode.EAN:
      return CalculateEANDigits(number);
    case CheckDigitsMode.DEPERSID:
      return CalculateDEPersIDDigits(number);
    case CheckDigitsMode.DETAXID:
      return CalculateDETaxIDDigits(number);
    case CheckDigitsMode.EURO:
      return CalculateIBANDigits(number);
    case CheckDigitsMode.IBAN:
      return CalculateIBANDigits(number);
    case CheckDigitsMode.IMEI:
      return CalculateIMEIDigits(number);
    case CheckDigitsMode.ISBN:
      return CalculateISBNDigits(number);
    case CheckDigitsMode.UIC:
      return CalculateUICDigits(number);
    default:
      return [''];
  }
}

bool checkNumber(String number, Function f){
  return f(number) as bool;
}

String  calculateCheckDigit(String number, Function f) {
  return f(number) as String;
}

String CalculateNumber(String number, Function f){
  return f(number) as String;
}

List<String> CalculateGlitch(String number, Function f) {
  List<String> result = <String>[];
  String test = '';
  String testLeft = '';
  String testRight = '';
  int startIndex = 1;
  if (f == checkIBAN) {
    startIndex = 4;
  }
  for (int index = startIndex; index < number.length; index ++) {
    testLeft = number.substring(0, index - 1);
    testRight = number.substring(index);
    for (int testDigit = 0; testDigit <= 9; testDigit++) {
      test = testLeft + testDigit.toString() + testRight;
      if (checkNumber(test, f)) {
        result.add(test);
      }
    } // for testDigit
  } // for index
  if (result.isEmpty) result.add('');
  return result;
}

List<String> CalculateDigits(String number, Function f){
  List<String> result = <String>[];
  int maxDigits = 0;
  int len = 0;
  int letters = 0;
  String maxNumber = '';
  int index = 0;
  String numberToCheck = '';
  if (f == checkIBAN) {
    for (int i = 0 ; i < number.length; i++){
      if (number[i] == '?') {
        if (i < 2) {
          maxNumber = maxNumber + 'Z';
        } else {
          maxNumber = maxNumber + '9';
        }
      }
    }
    if (maxNumber.startsWith('ZZ')){
      letters = 2;
      maxNumber = maxNumber.substring(2);
    }
    else
    if (maxNumber.startsWith('Z')){
      letters = 1;
      maxNumber = maxNumber.substring(1);
    }
    else {
      letters = 0;
    }
    len = maxNumber.length;
    maxDigits = int.parse(maxNumber);

    if (letters == 0) {
      for (int i = 0; i < maxDigits; i++) {
        maxNumber = i.toString();
        maxNumber = maxNumber.padLeft(len, '0');
        index = 0;
        numberToCheck = number.substring(0,2);
        for (int i = 2; i < number.length; i++) {
          if (int.tryParse(number[i]) == null) {
            numberToCheck = numberToCheck + maxNumber[index];
            index++;
          } else {
            numberToCheck = numberToCheck + number[i];
          }
        }
        if (checkNumber(numberToCheck, f)) {
          result.add(numberToCheck);
        }
      }
    }else {
      for (int l1 = 65; l1 < 92; l1++) {
        numberToCheck = String.fromCharCode(l1);
        if (letters == 2) {
          for (int l2 = 65; l2 < 92; l2++) {
            numberToCheck = numberToCheck + String.fromCharCode(l2);
            for (int i = 0; i < maxDigits; i++) {
              maxNumber = i.toString();
              maxNumber = maxNumber.padLeft(len, '0');
              index = 0;
              numberToCheck = '';
              for (int i = 0; i < number.length; i++) {
                if (int.tryParse(number[i]) == null) {
                  numberToCheck = numberToCheck + maxNumber[index];
                  index++;
                } else {
                  numberToCheck = numberToCheck + number[i];
                }
              }
              if (checkNumber(numberToCheck, f)) result.add(numberToCheck);
            }
          }
        } else {
          for (int i = 0; i < maxDigits; i++) {
            maxNumber = i.toString();
            maxNumber = maxNumber.padLeft(len, '0');
            index = 0;
            numberToCheck = '';
            for (int i = 0; i < number.length; i++) {
              if (int.tryParse(number[i]) == null) {
                numberToCheck = numberToCheck + maxNumber[index];
                index++;
              } else {
                numberToCheck = numberToCheck + number[i];
              }
            }
            if (checkNumber(numberToCheck, f)) result.add(numberToCheck);
          }
        }
      }
    }
  } else {
    for (int i = 0; i < number.length; i++) {
      if (int.tryParse(number[i]) == null) {
        maxNumber = maxNumber + '9';
      }
    }
    len = maxNumber.length;
    if (len > 0) {
      maxDigits = int.parse(maxNumber);
      for (int i = 0; i < maxDigits; i++) {
        maxNumber = i.toString();
        maxNumber = maxNumber.padLeft(len, '0');
        index = 0;
        numberToCheck = '';
        for (int i = 0; i < number.length; i++) {
          if (int.tryParse(number[i]) == null) {
            numberToCheck = numberToCheck + maxNumber[index];
            index++;
          } else {
            numberToCheck = numberToCheck + number[i];
          }
        }
        if (checkNumber(numberToCheck, f)) {
          result.add(numberToCheck);
        }
      }
    }
  }
  return result;
}