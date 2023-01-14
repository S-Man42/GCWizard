import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

class NumberSequenceLuckyNumbersCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceLuckyNumbersCheckNumber() : super(mode: NumberSequencesMode.LUCKY_NUMBERS, maxIndex: 71917);
}

class NumberSequenceLuckyNumbersDigits extends NumberSequenceDigits {
  NumberSequenceLuckyNumbersDigits() : super(mode: NumberSequencesMode.LUCKY_NUMBERS, maxDigits: 6);
}

class NumberSequenceLuckyNumbersRange extends NumberSequenceRange {
  NumberSequenceLuckyNumbersRange() : super(mode: NumberSequencesMode.LUCKY_NUMBERS, maxIndex: 71917);
}

class NumberSequenceLuckyNumbersNthNumber extends NumberSequenceNthNumber {
  NumberSequenceLuckyNumbersNthNumber() : super(mode: NumberSequencesMode.LUCKY_NUMBERS, maxIndex: 71917);
}

class NumberSequenceLuckyNumbersContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceLuckyNumbersContainsDigits() : super(mode: NumberSequencesMode.LUCKY_NUMBERS, maxIndex: 71917);
}
