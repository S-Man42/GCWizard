import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';


class CheckDigitsGTINCheckNumber extends CheckDigitsCheckNumber {
  const CheckDigitsGTINCheckNumber({Key? key}) : super(key: key, mode: CheckDigitsMode.GTIN);
}

class CheckDigitsGTINCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  const CheckDigitsGTINCalculateCheckDigit({Key? key}) : super(key: key, mode: CheckDigitsMode.GTIN);
}

class CheckDigitsGTINCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  const CheckDigitsGTINCalculateMissingDigit({Key? key}) : super(key: key, mode: CheckDigitsMode.GTIN);
}