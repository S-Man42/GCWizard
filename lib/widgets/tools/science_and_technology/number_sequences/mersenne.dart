import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceMersenneCheck extends NumberSequenceCheckNumber {
  NumberSequenceMersenneCheck() : super(mode: NumberSequencesMode.MERSENNE);
}

class NumberSequenceMersenneDigits extends NumberSequenceDigits {
  NumberSequenceMersenneDigits() : super(mode: NumberSequencesMode.MERSENNE);
}

class NumberSequenceMersenneRange extends NumberSequenceRange {
  NumberSequenceMersenneRange() : super(mode: NumberSequencesMode.MERSENNE);
}

class NumberSequenceMersenneNthNumber extends NumberSequenceNthNumber {
  NumberSequenceMersenneNthNumber() : super(mode: NumberSequencesMode.MERSENNE);
}