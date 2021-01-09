import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceFibonacciCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceFibonacciCheckNumber() : super(mode: NumberSequencesMode.FIBONACCI, maxIndex: 111111);
}

class NumberSequenceFibonacciDigits extends NumberSequenceDigits {
  NumberSequenceFibonacciDigits() : super(mode: NumberSequencesMode.FIBONACCI, maxDigits: 111);
}

class NumberSequenceFibonacciRange extends NumberSequenceRange {
  NumberSequenceFibonacciRange() : super(mode: NumberSequencesMode.FIBONACCI, maxIndex: 111111);
}

class NumberSequenceFibonacciNthNumber extends NumberSequenceNthNumber {
  NumberSequenceFibonacciNthNumber() : super(mode: NumberSequencesMode.FIBONACCI, maxIndex: 111111);
}

class NumberSequenceFibonacciContains extends NumberSequenceContains {
  NumberSequenceFibonacciContains() : super(mode: NumberSequencesMode.FIBONACCI, maxIndex: 111111);
}
