import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';


class CheckDigitsEANCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsEANCheckNumber() : super(mode: CheckDigitsMode.EAN);
}

class CheckDigitsEANCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsEANCalculateCheckDigit() : super(mode: CheckDigitsMode.EAN);
}

class CheckDigitsEANCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsEANCalculateMissingDigit() : super(mode: CheckDigitsMode.EAN);
}