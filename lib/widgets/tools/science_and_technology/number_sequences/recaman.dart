import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_contain.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceRecamanCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceRecamanCheckNumber() : super(mode: NumberSequencesMode.RECAMAN);
}

class NumberSequenceRecamanDigits extends NumberSequenceDigits {
  NumberSequenceRecamanDigits() : super(mode: NumberSequencesMode.RECAMAN);
}

class NumberSequenceRecamanRange extends NumberSequenceRange {
  NumberSequenceRecamanRange() : super(mode: NumberSequencesMode.RECAMAN);
}

class NumberSequenceRecamanNthNumber extends NumberSequenceNthNumber {
  NumberSequenceRecamanNthNumber() : super(mode: NumberSequencesMode.RECAMAN);
}

class NumberSequenceRecamanContains extends NumberSequenceContains {
  NumberSequenceRecamanContains() : super(mode: NumberSequencesMode.RECAMAN);
}