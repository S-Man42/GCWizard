import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

class NumberSequenceJacobsthalLucasCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceJacobsthalLucasCheckNumber() : super(mode: NumberSequencesMode.JACOBSTHAL_LUCAS, maxIndex: 111111);
}

class NumberSequenceJacobsthalLucasDigits extends NumberSequenceDigits {
  NumberSequenceJacobsthalLucasDigits() : super(mode: NumberSequencesMode.JACOBSTHAL_LUCAS, maxDigits: 1111);
}

class NumberSequenceJacobsthalLucasRange extends NumberSequenceRange {
  NumberSequenceJacobsthalLucasRange() : super(mode: NumberSequencesMode.JACOBSTHAL_LUCAS, maxIndex: 111111);
}

class NumberSequenceJacobsthalLucasNthNumber extends NumberSequenceNthNumber {
  NumberSequenceJacobsthalLucasNthNumber() : super(mode: NumberSequencesMode.JACOBSTHAL_LUCAS, maxIndex: 111111);
}

class NumberSequenceJacobsthalLucasContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceJacobsthalLucasContainsDigits() : super(mode: NumberSequencesMode.JACOBSTHAL_LUCAS, maxIndex: 11111);
}
