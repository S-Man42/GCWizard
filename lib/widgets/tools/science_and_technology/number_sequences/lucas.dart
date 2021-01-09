import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceLucasCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceLucasCheckNumber() : super(mode: NumberSequencesMode.LUCAS);
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

class NumberSequenceLucasContains extends NumberSequenceContains {
  NumberSequenceLucasContains() : super(mode: NumberSequencesMode.LUCAS);
}
