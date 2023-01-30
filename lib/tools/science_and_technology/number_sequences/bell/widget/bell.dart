import 'package:gc_wizard/tools/science_and_technology/number_sequences/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

class NumberSequenceBellCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceBellCheckNumber() : super(mode: NumberSequencesMode.BELL, maxIndex: 555);
}

class NumberSequenceBellDigits extends NumberSequenceDigits {
  NumberSequenceBellDigits() : super(mode: NumberSequencesMode.BELL, maxDigits: 1111);
}

class NumberSequenceBellRange extends NumberSequenceRange {
  NumberSequenceBellRange() : super(mode: NumberSequencesMode.BELL, maxIndex: 555);
}

class NumberSequenceBellNthNumber extends NumberSequenceNthNumber {
  NumberSequenceBellNthNumber() : super(mode: NumberSequencesMode.BELL, maxIndex: 555);
}

class NumberSequenceBellContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceBellContainsDigits() : super(mode: NumberSequencesMode.BELL, maxIndex: 555);
}
