import 'package:gc_wizard/logic/tools/math_and_physics/irrational_numbers/phi.dart';
import 'package:gc_wizard/widgets/tools/math_and_physics/irrational_numbers/irrationalnumbers_decimalrange.dart';
import 'package:gc_wizard/widgets/tools/math_and_physics/irrational_numbers/irrationalnumbers_nthdecimal.dart';
import 'package:gc_wizard/widgets/tools/math_and_physics/irrational_numbers/irrationalnumbers_search.dart';

class PhiNthDecimal extends IrrationalNumbersNthDecimal {
  PhiNthDecimal() : super(irrationalNumber: PHI);
}

class PhiDecimalRange extends IrrationalNumbersDecimalRange {
  PhiDecimalRange() : super(irrationalNumber: PHI);
}

class PhiSearch extends IrrationalNumbersSearch {
  PhiSearch() : super(irrationalNumber: PHI);
}