import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceLucasCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceLucasCheckNumber() : super(mode: NumberSequencesMode.LUCAS, maxIndex: 111111);
}

class NumberSequenceLucasDigits extends NumberSequenceDigits {
  NumberSequenceLucasDigits() : super(mode: NumberSequencesMode.LUCAS, maxDigits: 1111);
}

class NumberSequenceLucasRange extends NumberSequenceRange {
  NumberSequenceLucasRange() : super(mode: NumberSequencesMode.LUCAS, maxIndex: 111111);
}

class NumberSequenceLucasNthNumber extends NumberSequenceNthNumber {
  NumberSequenceLucasNthNumber() : super(mode: NumberSequencesMode.LUCAS, maxIndex: 111111);
}

class NumberSequenceLucasContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceLucasContainsDigits() : super(mode: NumberSequencesMode.LUCAS, maxIndex: 11111);
}
