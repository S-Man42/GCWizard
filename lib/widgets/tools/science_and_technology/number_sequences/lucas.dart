import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceLucasCheck extends NumberSequenceCheckNumber {
  NumberSequenceLucasCheck() : super(mode: NumberSequencesMode.LUCAS);
}

class NumberSequenceLucasDigits extends NumberSequenceDigits {
  NumberSequenceLucasDigits() : super(mode: NumberSequencesMode.LUCAS);
}

class NumberSequenceLucasRange extends NumberSequenceRange {
  NumberSequenceLucasRange() : super(mode: NumberSequencesMode.LUCAS);
}

class NumberSequenceLucasNthNumber extends NumberSequenceNthNumber {
  NumberSequenceLucasNthNumber() : super(mode: NumberSequencesMode.LUCAS);
}