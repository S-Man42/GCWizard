import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceLychrelCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceLychrelCheckNumber() : super(mode: NumberSequencesMode.LYCHREL, maxIndex: 246);
}

class NumberSequenceLychrelDigits extends NumberSequenceDigits {
  NumberSequenceLychrelDigits() : super(mode: NumberSequencesMode.LYCHREL, maxDigits: 4);
}

class NumberSequenceLychrelRange extends NumberSequenceRange {
  NumberSequenceLychrelRange() : super(mode: NumberSequencesMode.LYCHREL, maxIndex: 246);
}

class NumberSequenceLychrelNthNumber extends NumberSequenceNthNumber {
  NumberSequenceLychrelNthNumber() : super(mode: NumberSequencesMode.LYCHREL, maxIndex: 246);
}

class NumberSequenceLychrelContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceLychrelContainsDigits() : super(mode: NumberSequencesMode.LYCHREL, maxIndex: 246);
}
