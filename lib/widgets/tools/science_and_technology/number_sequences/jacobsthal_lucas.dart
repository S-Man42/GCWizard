import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

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
