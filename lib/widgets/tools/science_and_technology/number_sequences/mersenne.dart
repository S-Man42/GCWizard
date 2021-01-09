import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceMersenneCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceMersenneCheckNumber() : super(mode: NumberSequencesMode.MERSENNE);
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

class NumberSequenceMersenneContains extends NumberSequenceContains {
  NumberSequenceMersenneContains() : super(mode: NumberSequencesMode.MERSENNE);
}
