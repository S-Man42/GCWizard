import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequencePellCheckNumber extends NumberSequenceCheckNumber {
  NumberSequencePellCheckNumber() : super(mode: NumberSequencesMode.PELL, maxIndex: 55555);
}

class NumberSequencePellDigits extends NumberSequenceDigits {
  NumberSequencePellDigits() : super(mode: NumberSequencesMode.PELL, maxDigits: 1111);
}

class NumberSequencePellRange extends NumberSequenceRange {
  NumberSequencePellRange() : super(mode: NumberSequencesMode.PELL, maxIndex: 55555);
}

class NumberSequencePellNthNumber extends NumberSequenceNthNumber {
  NumberSequencePellNthNumber() : super(mode: NumberSequencesMode.PELL, maxIndex: 55555);
}

class NumberSequencePellContainsDigits extends NumberSequenceContainsDigits {
  NumberSequencePellContainsDigits() : super(mode: NumberSequencesMode.PELL, maxIndex: 5555);
}
