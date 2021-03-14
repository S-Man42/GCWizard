import 'package:gc_wizard/logic/tools/science_and_technology/irrational_numbers/pi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/irrationalnumbers_decimalrange.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/irrationalnumbers_nthdecimal.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/irrationalnumbers_search.dart';

class PiNthDecimal extends IrrationalNumbersNthDecimal {
  PiNthDecimal() : super(irrationalNumber: PI);
}

class PiDecimalRange extends IrrationalNumbersDecimalRange {
  PiDecimalRange() : super(irrationalNumber: PI);
}

class PiSearch extends IrrationalNumbersSearch {
  PiSearch() : super(irrationalNumber: PI);
}