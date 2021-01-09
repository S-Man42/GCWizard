import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceFactorialCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceFactorialCheckNumber() : super(mode: NumberSequencesMode.FACTORIAL, maxIndex: 111111);
}

class NumberSequenceFactorialDigits extends NumberSequenceDigits {
  NumberSequenceFactorialDigits() : super(mode: NumberSequencesMode.FACTORIAL, maxDigits: 111);
}

class NumberSequenceFactorialRange extends NumberSequenceRange {
  NumberSequenceFactorialRange() : super(mode: NumberSequencesMode.FACTORIAL, maxIndex: 111111);
}

class NumberSequenceFactorialNthNumber extends NumberSequenceNthNumber {
  NumberSequenceFactorialNthNumber() : super(mode: NumberSequencesMode.FACTORIAL, maxIndex: 111111);
}

class NumberSequenceFactorialContains extends NumberSequenceContains {
  NumberSequenceFactorialContains() : super(mode: NumberSequencesMode.FACTORIAL, maxIndex: 111111);
}