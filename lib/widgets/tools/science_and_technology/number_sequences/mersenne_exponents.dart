import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceMersenneExponentsCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceMersenneExponentsCheckNumber() : super(mode: NumberSequencesMode.MERSENNE_EXPONENTS, maxIndex: 50);
}

class NumberSequenceMersenneExponentsDigits extends NumberSequenceDigits {
  NumberSequenceMersenneExponentsDigits() : super(mode: NumberSequencesMode.MERSENNE_EXPONENTS, maxDigits: 8);
}

class NumberSequenceMersenneExponentsRange extends NumberSequenceRange {
  NumberSequenceMersenneExponentsRange() : super(mode: NumberSequencesMode.MERSENNE_EXPONENTS, maxIndex: 50);
}

class NumberSequenceMersenneExponentsNthNumber extends NumberSequenceNthNumber {
  NumberSequenceMersenneExponentsNthNumber() : super(mode: NumberSequencesMode.MERSENNE_EXPONENTS, maxIndex: 50);
}

class NumberSequenceMersenneExponentsContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceMersenneExponentsContainsDigits() : super(mode: NumberSequencesMode.MERSENNE_EXPONENTS, maxIndex: 50);
}
