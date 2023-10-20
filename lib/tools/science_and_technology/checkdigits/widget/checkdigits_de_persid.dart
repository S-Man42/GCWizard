import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';


class CheckDigitsDEPersIDCheckNumber extends CheckDigitsCheckNumber {
  const CheckDigitsDEPersIDCheckNumber({Key? key}) : super( key: key, mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsDEPersIDCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  const CheckDigitsDEPersIDCalculateCheckDigit({Key? key}) : super(key: key, mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsDEPersIDCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  const CheckDigitsDEPersIDCalculateMissingDigit({Key? key}) : super(key: key, mode: CheckDigitsMode.DEPERSID);
}