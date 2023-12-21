import 'dart:isolate';

import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/logic/crosstotals.dart';
import 'package:http/http.dart' as http;

part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_datatypes.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_de_banknumber_data.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_ean.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_de_persid.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_de_taxid.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_iban.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_imei.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_isbn.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_euro.dart';
part 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits_uic.dart';

final iterateAlpha = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];
final iterateAlphanumeric = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
];

CheckDigitOutput checkDigitsCheckNumber(CheckDigitsMode mode, String number) {
  if (number == '') {
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
  }

  number = number.toUpperCase();
  switch (mode) {
    case CheckDigitsMode.EAN:
      return _CheckEANNumber(number);
    case CheckDigitsMode.DEPERSID:
      return _CheckDEPersIDNumber(number);
    case CheckDigitsMode.DETAXID:
      return _CheckDETaxIDNumber(number);
    case CheckDigitsMode.EURO:
      return _CheckEURONumber(number);
    case CheckDigitsMode.IBAN:
      return _CheckIBANNumber(number);
    case CheckDigitsMode.IMEI:
      return _CheckIMEINumber(number);
    case CheckDigitsMode.ISBN:
      return _CheckISBNNumber(number);
    case CheckDigitsMode.UIC:
      return _CheckUICNumber(number);
    default:
      return CheckDigitOutput(false, '', ['']);
  }
}

String checkDigitsCalculateNumber(CheckDigitsMode mode, String number) {
  if (number == '') {
    return 'checkdigits_invalid_length';
  }

  number = number.toUpperCase();
  switch (mode) {
    case CheckDigitsMode.EAN:
      return _CalculateNumber(number, _CalculateEANNumber);
    case CheckDigitsMode.DEPERSID:
      return _CalculateNumber(number, _CalculateDEPersIDNumber);
    case CheckDigitsMode.DETAXID:
      return _CalculateNumber(number, _CalculateDETaxIDNumber);
    case CheckDigitsMode.EURO:
      return _CalculateNumber(number, _CalculateEURONumber);
    case CheckDigitsMode.IBAN:
      return _CalculateNumber(number, _CalculateIBANNumber);
    case CheckDigitsMode.IMEI:
      return _CalculateNumber(number, _CalculateIMEINumber);
    case CheckDigitsMode.ISBN:
      return _CalculateNumber(number, _CalculateISBNNumber);
    case CheckDigitsMode.UIC:
      return _CalculateNumber(number, _CalculateUICNumber);
    default:
      return '';
  }
}

List<String> checkDigitsCalculateDigits(CheckDigitsMode mode, String number) {
  if (number == '') {
    return ['checkdigits_invalid_length'];
  }

  number = number.toUpperCase();
  switch (mode) {
    case CheckDigitsMode.EAN:
      return _CalculateEANDigits(number);
    case CheckDigitsMode.DEPERSID:
      return _CalculateDEPersIDDigits(number);
    case CheckDigitsMode.DETAXID:
      return _CalculateDETaxIDDigits(number);
    case CheckDigitsMode.EURO:
      return _CalculateEURODigits(number);
    case CheckDigitsMode.IBAN:
      return _CalculateIBANDigits(number);
    case CheckDigitsMode.IMEI:
      return _CalculateIMEIDigits(number);
    case CheckDigitsMode.ISBN:
      return _CalculateISBNDigits(number);
    case CheckDigitsMode.UIC:
      return _CalculateUICDigits(number);
    default:
      return [''];
  }
}

bool _checkNumber(String number, Function f) {
  return f(number) as bool;
}

String _calculateCheckDigit(String number, Function f) {
  return f(number) as String;
}

String _CalculateNumber(String number, Function f) {
  return f(number) as String;
}

List<String> _CalculateGlitch(String number, Function f) {
  List<String> result = <String>[];
  String test = '';
  String testLeft = '';
  String testRight = '';
  int startIndex = 1;
  if (f == _checkIBAN) {
    startIndex = 4;
  }
  for (int index = startIndex; index < number.length; index++) {
    testLeft = number.substring(0, index - 1);
    testRight = number.substring(index);
    if ((f == _checkEURO) && (index == 1 || index == 2)) {
      for (int testDigit = 0; testDigit <= 25; testDigit++) {
        test = testLeft + String.fromCharCode(65 + testDigit) + testRight;
        if (_checkNumber(test, f)) {
          result.add(test);
        }
      }
    } else {
      for (int testDigit = 0; testDigit <= 9; testDigit++) {
        test = testLeft + testDigit.toString() + testRight;
        if (_checkNumber(test, f)) {
          result.add(test);
        }
      }
    } // for testDigit
  } // for index
  if (result.isEmpty) result.add('');
  return result;
}

List<String> _CalculateDigits(String number, Function f) {
  List<String> result = <String>[];
  List<String> iterate = iterateAlpha;
  String headToCheck = '';
  if (f == _checkIBAN || f == _checkEURO) {
    String head = number.substring(0, 2);
    String tail = number.substring(2);
    if (f == _checkEURO) {iterate = iterateAlphanumeric;}

    for (String headI in iterateAlpha) {
      for (String headJ in iterate) {
        if (head[0] == '?') {
          headToCheck = headI;
        } else {
          headToCheck = head[0];
        }
        if (head[1] == '?') {
          headToCheck = headToCheck + headJ;
        } else {
          headToCheck = headToCheck + head[1];
        }
        for (String number in _CalculateDigitsOnlyNumbers(tail, f, head: headToCheck)) {
          if (!result.contains(number)) {result.add(number);}
        }
      }
    }
  } else {
    result = _CalculateDigitsOnlyNumbers(number, f);
  }
  return result;
}

List<String> _CalculateDigitsOnlyNumbers(String number, Function f, {String head = ''}) {
  List<String> result = <String>[];
  int maxDigits = 0;
  int len = 0;
  String maxNumber = '';
  int index = 0;
  String numberToCheck = '';
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
      if (_checkNumber(head + numberToCheck, f)) {
        if (!result.contains(head + numberToCheck)) {result.add(head + numberToCheck);}
      }
    }
  } else {
    if (_checkNumber(head + number, f)) {
      if (!result.contains(head + number)) {result.add(head + number);}
    }
  }
  return result;
}
