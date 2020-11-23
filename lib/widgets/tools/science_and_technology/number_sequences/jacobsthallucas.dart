import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceJacobsthalLucasCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceJacobsthalLucasCheckNumber() : super(mode: NumberSequencesMode.JACOBSTHALLUCAS);
}

class NumberSequenceJacobsthalLucasDigits extends NumberSequenceDigits {
  NumberSequenceJacobsthalLucasDigits() : super(mode: NumberSequencesMode.JACOBSTHALLUCAS);
}

class NumberSequenceJacobsthalLucasRange extends NumberSequenceRange {
  NumberSequenceJacobsthalLucasRange() : super(mode: NumberSequencesMode.JACOBSTHALLUCAS);
}

class NumberSequenceJacobsthalLucasNthNumber extends NumberSequenceNthNumber {
  NumberSequenceJacobsthalLucasNthNumber() : super(mode: NumberSequencesMode.JACOBSTHALLUCAS);
}