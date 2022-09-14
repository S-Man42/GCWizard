import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequencePermutablePrimesCheckNumber extends NumberSequenceCheckNumber {
  NumberSequencePermutablePrimesCheckNumber() : super(mode: NumberSequencesMode.PERMUTABLE_PRIMES, maxIndex: 23);
}

class NumberSequencePermutablePrimesDigits extends NumberSequenceDigits {
  NumberSequencePermutablePrimesDigits() : super(mode: NumberSequencesMode.PERMUTABLE_PRIMES, maxDigits: 317);
}

class NumberSequencePermutablePrimesRange extends NumberSequenceRange {
  NumberSequencePermutablePrimesRange() : super(mode: NumberSequencesMode.PERMUTABLE_PRIMES, maxIndex: 23);
}

class NumberSequencePermutablePrimesNthNumber extends NumberSequenceNthNumber {
  NumberSequencePermutablePrimesNthNumber() : super(mode: NumberSequencesMode.PERMUTABLE_PRIMES, maxIndex: 23);
}

class NumberSequencePermutablePrimesContainsDigits extends NumberSequenceContainsDigits {
  NumberSequencePermutablePrimesContainsDigits() : super(mode: NumberSequencesMode.PERMUTABLE_PRIMES, maxIndex: 23);
}
