import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceFactorialCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceFactorialCheckNumber() : super(mode: NumberSequencesMode.FACTORIAL, maxIndex: 11111);
}

class NumberSequenceFactorialDigits extends NumberSequenceDigits {
  NumberSequenceFactorialDigits() : super(mode: NumberSequencesMode.FACTORIAL, maxDigits: 1111);
}

class NumberSequenceFactorialRange extends NumberSequenceRange {
  NumberSequenceFactorialRange() : super(mode: NumberSequencesMode.FACTORIAL, maxIndex: 11111);
}

class NumberSequenceFactorialNthNumber extends NumberSequenceNthNumber {
  NumberSequenceFactorialNthNumber() : super(mode: NumberSequencesMode.FACTORIAL, maxIndex: 11111);
}

class NumberSequenceFactorialContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceFactorialContainsDigits() : super(mode: NumberSequencesMode.FACTORIAL, maxIndex: 1111);
}
