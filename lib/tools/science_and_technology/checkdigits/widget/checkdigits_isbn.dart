import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';


class CheckDigitsISBNCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsISBNCheckNumber() : super(mode: CheckDigitsMode.ISBN);
}

class CheckDigitsISBNCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsISBNCalculateCheckDigit() : super(mode: CheckDigitsMode.ISBN);
}

class CheckDigitsISBNCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsISBNCalculateMissingDigit() : super(mode: CheckDigitsMode.ISBN);
}