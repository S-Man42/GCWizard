import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceBellCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceBellCheckNumber() : super(mode: NumberSequencesMode.BELL, maxIndex: 555);
}

class NumberSequenceBellDigits extends NumberSequenceDigits {
  NumberSequenceBellDigits() : super(mode: NumberSequencesMode.BELL, maxDigits: 1111);
}

class NumberSequenceBellRange extends NumberSequenceRange {
  NumberSequenceBellRange() : super(mode: NumberSequencesMode.BELL, maxIndex: 555);
}

class NumberSequenceBellNthNumber extends NumberSequenceNthNumber {
  NumberSequenceBellNthNumber() : super(mode: NumberSequencesMode.BELL, maxIndex: 555);
}

class NumberSequenceBellContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceBellContainsDigits() : super(mode: NumberSequencesMode.BELL, maxIndex: 555);
}
