import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';

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
