import 'package:gc_wizard//tools/science_and_technology/check_digits/logic/base/check_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';


class CheckDigitsUICCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsUICCheckNumber() : super(mode: CheckDigitsMode.UIC);
}

class CheckDigitsUICCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsUICCalculateCheckDigit() : super(mode: CheckDigitsMode.UIC);
}

class CheckDigitsUICCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsUICCalculateMissingDigit() : super(mode: CheckDigitsMode.UIC);
}