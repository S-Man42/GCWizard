import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceSublimeNumbersCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceSublimeNumbersCheckNumber() : super(mode: NumberSequencesMode.SUBLIME_NUMBERS, maxIndex: 1);
}

class NumberSequenceSublimeNumbersDigits extends NumberSequenceDigits {
  NumberSequenceSublimeNumbersDigits() : super(mode: NumberSequencesMode.SUBLIME_NUMBERS, maxDigits: 80);
}

class NumberSequenceSublimeNumbersRange extends NumberSequenceRange {
  NumberSequenceSublimeNumbersRange() : super(mode: NumberSequencesMode.SUBLIME_NUMBERS, maxIndex: 1);
}

class NumberSequenceSublimeNumbersNthNumber extends NumberSequenceNthNumber {
  NumberSequenceSublimeNumbersNthNumber() : super(mode: NumberSequencesMode.SUBLIME_NUMBERS, maxIndex: 1);
}

class NumberSequenceSublimeNumbersContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceSublimeNumbersContainsDigits() : super(mode: NumberSequencesMode.SUBLIME_NUMBERS, maxIndex: 1);
}
