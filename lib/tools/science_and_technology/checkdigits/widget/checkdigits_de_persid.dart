import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_checkdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_calculate_missingdigit.dart';
import 'package:gc_wizard/tools/science_and_technology/checkdigits/widget/base/checkdigits_check_number.dart';


class CheckDigitsDEPersIDCheckNumber extends CheckDigitsCheckNumber {
  CheckDigitsDEPersIDCheckNumber() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsDEPersIDCalculateCheckDigit extends CheckDigitsCalculateCheckDigit {
  CheckDigitsDEPersIDCalculateCheckDigit() : super(mode: CheckDigitsMode.DEPERSID);
}

class CheckDigitsDEPersIDCalculateMissingDigit extends CheckDigitsCalculateMissingDigits {
  CheckDigitsDEPersIDCalculateMissingDigit() : super(mode: CheckDigitsMode.DEPERSID);
}