import 'package:gc_wizard//tools/science_and_technology/check_digits/logic/base/check_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';


class CheckDigitsDETaxIDCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsDETaxIDCheckNumber() : super(mode: CheckDigitsMode.DETAXID);
}

class CheckDigitsDETaxIDCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsDETaxIDCalculateCheckDigit() : super(mode: CheckDigitsMode.DETAXID);
}

class CheckDigitsDETaxIDCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsDETaxIDCalculateMissingDigit() : super(mode: CheckDigitsMode.DETAXID);
}