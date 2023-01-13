import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

class NumberSequenceJacobsthalOblongCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceJacobsthalOblongCheckNumber() : super(mode: NumberSequencesMode.JACOBSTHAL_OBLONG, maxIndex: 111111);
}

class NumberSequenceJacobsthalOblongDigits extends NumberSequenceDigits {
  NumberSequenceJacobsthalOblongDigits() : super(mode: NumberSequencesMode.JACOBSTHAL_OBLONG, maxDigits: 1111);
}

class NumberSequenceJacobsthalOblongRange extends NumberSequenceRange {
  NumberSequenceJacobsthalOblongRange() : super(mode: NumberSequencesMode.JACOBSTHAL_OBLONG, maxIndex: 111111);
}

class NumberSequenceJacobsthalOblongNthNumber extends NumberSequenceNthNumber {
  NumberSequenceJacobsthalOblongNthNumber() : super(mode: NumberSequencesMode.JACOBSTHAL_OBLONG, maxIndex: 111111);
}

class NumberSequenceJacobsthalOblongContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceJacobsthalOblongContainsDigits() : super(mode: NumberSequencesMode.JACOBSTHAL_OBLONG, maxIndex: 11111);
}
