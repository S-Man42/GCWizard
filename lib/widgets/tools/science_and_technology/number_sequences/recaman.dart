import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceRecamanCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceRecamanCheckNumber() : super(mode: NumberSequencesMode.RECAMAN, maxIndex: 11111);
}

class NumberSequenceRecamanDigits extends NumberSequenceDigits {
  NumberSequenceRecamanDigits() : super(mode: NumberSequencesMode.RECAMAN, maxDigits: 5);
}

class NumberSequenceRecamanRange extends NumberSequenceRange {
  NumberSequenceRecamanRange() : super(mode: NumberSequencesMode.RECAMAN, maxIndex: 11111);
}

class NumberSequenceRecamanNthNumber extends NumberSequenceNthNumber {
  NumberSequenceRecamanNthNumber() : super(mode: NumberSequencesMode.RECAMAN, maxIndex: 11111);
}

class NumberSequenceRecamanContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceRecamanContainsDigits() : super(mode: NumberSequencesMode.RECAMAN, maxIndex: 1111);
}
