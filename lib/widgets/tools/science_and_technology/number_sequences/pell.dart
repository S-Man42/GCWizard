import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequencePellCheckNumber extends NumberSequenceCheckNumber {
  NumberSequencePellCheckNumber() : super(mode: NumberSequencesMode.PELL, maxIndex: 111111);
}

class NumberSequencePellDigits extends NumberSequenceDigits {
  NumberSequencePellDigits() : super(mode: NumberSequencesMode.PELL, maxDigits: 111);
}

class NumberSequencePellRange extends NumberSequenceRange {
  NumberSequencePellRange() : super(mode: NumberSequencesMode.PELL, maxIndex: 111111);
}

class NumberSequencePellNthNumber extends NumberSequenceNthNumber {
  NumberSequencePellNthNumber() : super(mode: NumberSequencesMode.PELL, maxIndex: 111111);
}

class NumberSequencePellContains extends NumberSequenceContains {
  NumberSequencePellContains() : super(mode: NumberSequencesMode.PELL, maxIndex: 111111);
}
