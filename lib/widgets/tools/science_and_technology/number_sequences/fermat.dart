import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

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
