import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceRecamanCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceRecamanCheckNumber() : super(mode: NumberSequencesMode.RECAMAN, maxIndex: 111111);
}

class NumberSequenceRecamanDigits extends NumberSequenceDigits {
  NumberSequenceRecamanDigits() : super(mode: NumberSequencesMode.RECAMAN, maxDigits: 111);
}

class NumberSequenceRecamanRange extends NumberSequenceRange {
  NumberSequenceRecamanRange() : super(mode: NumberSequencesMode.RECAMAN, maxIndex: 111111);
}

class NumberSequenceRecamanNthNumber extends NumberSequenceNthNumber {
  NumberSequenceRecamanNthNumber() : super(mode: NumberSequencesMode.RECAMAN, maxIndex: 111111);
}

class NumberSequenceRecamanContains extends NumberSequenceContains {
  NumberSequenceRecamanContains() : super(mode: NumberSequencesMode.RECAMAN, maxIndex: 111111);
}