import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

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
