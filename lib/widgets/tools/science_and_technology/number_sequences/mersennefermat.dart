import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceMersenneFermatCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceMersenneFermatCheckNumber() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatDigits extends NumberSequenceDigits {
  NumberSequenceMersenneFermatDigits() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxDigits: 1111);
}

class NumberSequenceMersenneFermatRange extends NumberSequenceRange {
  NumberSequenceMersenneFermatRange() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatNthNumber extends NumberSequenceNthNumber {
  NumberSequenceMersenneFermatNthNumber() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceMersenneFermatContainsDigits() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 11111);
}
