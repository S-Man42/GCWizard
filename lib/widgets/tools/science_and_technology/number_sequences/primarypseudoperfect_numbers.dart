import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequencePrimaryPseudoPerfectNumbersCheckNumber extends NumberSequenceCheckNumber {
  NumberSequencePrimaryPseudoPerfectNumbersCheckNumber()
      : super(mode: NumberSequencesMode.PRIMARY_PSEUDOPERFECT_NUMBERS, maxIndex: 7);
}

class NumberSequencePrimaryPseudoPerfectNumbersDigits extends NumberSequenceDigits {
  NumberSequencePrimaryPseudoPerfectNumbersDigits()
      : super(mode: NumberSequencesMode.PRIMARY_PSEUDOPERFECT_NUMBERS, maxDigits: 35);
}

class NumberSequencePrimaryPseudoPerfectNumbersRange extends NumberSequenceRange {
  NumberSequencePrimaryPseudoPerfectNumbersRange()
      : super(mode: NumberSequencesMode.PRIMARY_PSEUDOPERFECT_NUMBERS, maxIndex: 7);
}

class NumberSequencePrimaryPseudoPerfectNumbersNthNumber extends NumberSequenceNthNumber {
  NumberSequencePrimaryPseudoPerfectNumbersNthNumber()
      : super(mode: NumberSequencesMode.PRIMARY_PSEUDOPERFECT_NUMBERS, maxIndex: 7);
}

class NumberSequencePrimaryPseudoPerfectNumbersContainsDigits extends NumberSequenceContainsDigits {
  NumberSequencePrimaryPseudoPerfectNumbersContainsDigits()
      : super(mode: NumberSequencesMode.PRIMARY_PSEUDOPERFECT_NUMBERS, maxIndex: 7);
}
