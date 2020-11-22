import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequencePellCheck extends NumberSequenceCheckNumber {
  NumberSequencePellCheck() : super(mode: NumberSequencesMode.PELL);
}

class NumberSequencePellDigits extends NumberSequenceDigits {
  NumberSequencePellDigits() : super(mode: NumberSequencesMode.PELL);
}

class NumberSequencePellRange extends NumberSequenceRange {
  NumberSequencePellRange() : super(mode: NumberSequencesMode.PELL);
}

class NumberSequencePellNthNumber extends NumberSequenceNthNumber {
  NumberSequencePellNthNumber() : super(mode: NumberSequencesMode.PELL);
}