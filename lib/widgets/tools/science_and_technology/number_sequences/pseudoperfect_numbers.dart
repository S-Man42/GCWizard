import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequencePseudoPerfectNumbersCheckNumber extends NumberSequenceCheckNumber {
  NumberSequencePseudoPerfectNumbersCheckNumber() : super(mode: NumberSequencesMode.PSEUDOPERFECT_NUMBERS, maxIndex: 7);
}

class NumberSequencePseudoPerfectNumbersDigits extends NumberSequenceDigits {
  NumberSequencePseudoPerfectNumbersDigits() : super(mode: NumberSequencesMode.PSEUDOPERFECT_NUMBERS, maxDigits: 35);
}

class NumberSequencePseudoPerfectNumbersRange extends NumberSequenceRange {
  NumberSequencePseudoPerfectNumbersRange() : super(mode: NumberSequencesMode.PSEUDOPERFECT_NUMBERS, maxIndex: 7);
}

class NumberSequencePseudoPerfectNumbersNthNumber extends NumberSequenceNthNumber {
  NumberSequencePseudoPerfectNumbersNthNumber() : super(mode: NumberSequencesMode.PSEUDOPERFECT_NUMBERS, maxIndex: 7);
}

class NumberSequencePseudoPerfectNumbersContainsDigits extends NumberSequenceContainsDigits {
  NumberSequencePseudoPerfectNumbersContainsDigits() : super(mode: NumberSequencesMode.PSEUDOPERFECT_NUMBERS, maxIndex: 7);
}