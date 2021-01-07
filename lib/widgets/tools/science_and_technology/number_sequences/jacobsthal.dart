import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

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

class NumberSequenceJacobsthalContains extends NumberSequenceContains {
  NumberSequenceJacobsthalContains() : super(mode: NumberSequencesMode.JACOBSTAHL);
}
