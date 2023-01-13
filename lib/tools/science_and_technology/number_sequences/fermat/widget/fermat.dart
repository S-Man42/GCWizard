import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

class NumberSequenceFermatCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceFermatCheckNumber() : super(mode: NumberSequencesMode.FERMAT, maxIndex: 18);
}

class NumberSequenceFermatDigits extends NumberSequenceDigits {
  NumberSequenceFermatDigits() : super(mode: NumberSequencesMode.FERMAT, maxDigits: 1111);
}

class NumberSequenceFermatRange extends NumberSequenceRange {
  NumberSequenceFermatRange() : super(mode: NumberSequencesMode.FERMAT, maxIndex: 18);
}

class NumberSequenceFermatNthNumber extends NumberSequenceNthNumber {
  NumberSequenceFermatNthNumber() : super(mode: NumberSequencesMode.FERMAT, maxIndex: 18);
}

class NumberSequenceFermatContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceFermatContainsDigits() : super(mode: NumberSequencesMode.FERMAT, maxIndex: 10);
}
