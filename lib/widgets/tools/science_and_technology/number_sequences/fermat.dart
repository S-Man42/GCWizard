import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceFermatCheck extends NumberSequenceCheckNumber {
  NumberSequenceFermatCheck() : super(mode: NumberSequencesMode.FERMAT);
}

class NumberSequenceFermatDigits extends NumberSequenceDigits {
  NumberSequenceFermatDigits() : super(mode: NumberSequencesMode.FERMAT);
}

class NumberSequenceFermatRange extends NumberSequenceRange {
  NumberSequenceFermatRange() : super(mode: NumberSequencesMode.FERMAT);
}

class NumberSequenceFermatNthNumber extends NumberSequenceNthNumber {
  NumberSequenceFermatNthNumber() : super(mode: NumberSequencesMode.FERMAT);
}