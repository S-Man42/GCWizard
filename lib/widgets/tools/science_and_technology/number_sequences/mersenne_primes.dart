import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceMersennePrimesCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceMersennePrimesCheckNumber() : super(mode: NumberSequencesMode.MERSENNE_PRIMES, maxIndex: 18);
}

class NumberSequenceMersennePrimesDigits extends NumberSequenceDigits {
  NumberSequenceMersennePrimesDigits() : super(mode: NumberSequencesMode.MERSENNE_PRIMES, maxDigits: 39);
}

class NumberSequenceMersennePrimesRange extends NumberSequenceRange {
  NumberSequenceMersennePrimesRange() : super(mode: NumberSequencesMode.MERSENNE_PRIMES, maxIndex: 18);
}

class NumberSequenceMersennePrimesNthNumber extends NumberSequenceNthNumber {
  NumberSequenceMersennePrimesNthNumber() : super(mode: NumberSequencesMode.MERSENNE_PRIMES, maxIndex: 18);
}

class NumberSequenceMersennePrimesContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceMersennePrimesContainsDigits() : super(mode: NumberSequencesMode.MERSENNE_PRIMES, maxIndex: 18);
}
