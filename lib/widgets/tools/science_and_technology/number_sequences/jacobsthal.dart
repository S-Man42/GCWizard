import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceJacobsthalCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceJacobsthalCheckNumber() : super(mode: NumberSequencesMode.JACOBSTAHL);
}

class NumberSequenceJacobsthalDigits extends NumberSequenceDigits {
  NumberSequenceJacobsthalDigits() : super(mode: NumberSequencesMode.JACOBSTAHL);
}

class NumberSequenceJacobsthalRange extends NumberSequenceRange {
  NumberSequenceJacobsthalRange() : super(mode: NumberSequencesMode.JACOBSTAHL);
}

class NumberSequenceJacobsthalNthNumber extends NumberSequenceNthNumber {
  NumberSequenceJacobsthalNthNumber() : super(mode: NumberSequencesMode.JACOBSTAHL);
}