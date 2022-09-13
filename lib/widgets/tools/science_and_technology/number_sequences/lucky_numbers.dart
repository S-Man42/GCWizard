import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

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
