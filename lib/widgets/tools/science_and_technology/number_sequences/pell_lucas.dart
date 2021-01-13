import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequencePellLucasCheckNumber extends NumberSequenceCheckNumber {
  NumberSequencePellLucasCheckNumber() : super(mode: NumberSequencesMode.PELL_LUCAS, maxIndex: 55555);
}

class NumberSequencePellLucasDigits extends NumberSequenceDigits {
  NumberSequencePellLucasDigits() : super(mode: NumberSequencesMode.PELL_LUCAS, maxDigits: 1111);
}

class NumberSequencePellLucasRange extends NumberSequenceRange {
  NumberSequencePellLucasRange() : super(mode: NumberSequencesMode.PELL_LUCAS, maxIndex: 55555);
}

class NumberSequencePellLucasNthNumber extends NumberSequenceNthNumber {
  NumberSequencePellLucasNthNumber() : super(mode: NumberSequencesMode.PELL_LUCAS, maxIndex: 55555);
}

class NumberSequencePellLucasContains extends NumberSequenceContains {
  NumberSequencePellLucasContains() : super(mode: NumberSequencesMode.PELL_LUCAS, maxIndex: 55555);
}
