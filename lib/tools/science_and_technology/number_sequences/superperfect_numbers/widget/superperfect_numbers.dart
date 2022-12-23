import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';

class NumberSequenceSuperPerfectNumbersCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceSuperPerfectNumbersCheckNumber() : super(mode: NumberSequencesMode.SUPERPERFECT_NUMBERS, maxIndex: 8);
}

class NumberSequenceSuperPerfectNumbersDigits extends NumberSequenceDigits {
  NumberSequenceSuperPerfectNumbersDigits() : super(mode: NumberSequencesMode.SUPERPERFECT_NUMBERS, maxDigits: 8);
}

class NumberSequenceSuperPerfectNumbersRange extends NumberSequenceRange {
  NumberSequenceSuperPerfectNumbersRange() : super(mode: NumberSequencesMode.SUPERPERFECT_NUMBERS, maxIndex: 8);
}

class NumberSequenceSuperPerfectNumbersNthNumber extends NumberSequenceNthNumber {
  NumberSequenceSuperPerfectNumbersNthNumber() : super(mode: NumberSequencesMode.SUPERPERFECT_NUMBERS, maxIndex: 8);
}

class NumberSequenceSuperPerfectNumbersContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceSuperPerfectNumbersContainsDigits()
      : super(mode: NumberSequencesMode.SUPERPERFECT_NUMBERS, maxIndex: 8);
}
