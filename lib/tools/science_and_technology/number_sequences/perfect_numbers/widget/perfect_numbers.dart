import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

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
