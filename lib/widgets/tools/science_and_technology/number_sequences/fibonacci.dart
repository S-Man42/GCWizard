import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_contain.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceFibonacciCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceFibonacciCheckNumber() : super(mode: NumberSequencesMode.FIBONACCI);
}

class NumberSequenceFibonacciDigits extends NumberSequenceDigits {
  NumberSequenceFibonacciDigits() : super(mode: NumberSequencesMode.FIBONACCI);
}

class NumberSequenceFibonacciRange extends NumberSequenceRange {
  NumberSequenceFibonacciRange() : super(mode: NumberSequencesMode.FIBONACCI);
}

class NumberSequenceFibonacciNthNumber extends NumberSequenceNthNumber {
  NumberSequenceFibonacciNthNumber() : super(mode: NumberSequencesMode.FIBONACCI);
}

class NumberSequenceFibonacciContains extends NumberSequenceContains {
  NumberSequenceFibonacciContains() : super(mode: NumberSequencesMode.FIBONACCI);
}
