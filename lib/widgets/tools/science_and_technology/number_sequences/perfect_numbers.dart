import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequencePerfectNumbersCheckNumber extends NumberSequenceCheckNumber {
  NumberSequencePerfectNumbersCheckNumber() : super(mode: NumberSequencesMode.PERFECT_NUMBERS, maxIndex: 11);
}

class NumberSequencePerfectNumbersDigits extends NumberSequenceDigits {
  NumberSequencePerfectNumbersDigits() : super(mode: NumberSequencesMode.PERFECT_NUMBERS, maxDigits: 80);
}

class NumberSequencePerfectNumbersRange extends NumberSequenceRange {
  NumberSequencePerfectNumbersRange() : super(mode: NumberSequencesMode.PERFECT_NUMBERS, maxIndex: 11);
}

class NumberSequencePerfectNumbersNthNumber extends NumberSequenceNthNumber {
  NumberSequencePerfectNumbersNthNumber() : super(mode: NumberSequencesMode.PERFECT_NUMBERS, maxIndex: 11);
}

class NumberSequencePerfectNumbersContainsDigits extends NumberSequenceContainsDigits {
  NumberSequencePerfectNumbersContainsDigits() : super(mode: NumberSequencesMode.PERFECT_NUMBERS, maxIndex: 11);
}
