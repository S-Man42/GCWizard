import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';


class CheckDigitsIMEICheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsIMEICheckNumber() : super(mode: CheckDigitsMode.IMEI);
}

class CheckDigitsIMEICalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsIMEICalculateCheckDigit() : super(mode: CheckDigitsMode.IMEI);
}

class CheckDigitsIMEICalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsIMEICalculateMissingDigit() : super(mode: CheckDigitsMode.IMEI);
}