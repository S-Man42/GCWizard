import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';

class CheckDigitsIBANCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsIBANCheckNumber() : super(mode: CheckDigitsMode.IBAN);
}

class CheckDigitsIBANCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsIBANCalculateCheckDigit() : super(mode: CheckDigitsMode.IBAN);
}

class CheckDigitsIBANCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsIBANCalculateMissingDigit() : super(mode: CheckDigitsMode.IBAN);
}