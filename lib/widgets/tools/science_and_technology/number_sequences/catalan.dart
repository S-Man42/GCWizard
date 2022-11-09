import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceCatalanCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceCatalanCheckNumber() : super(mode: NumberSequencesMode.CATALAN, maxIndex: 11111);
}

class NumberSequenceCatalanDigits extends NumberSequenceDigits {
  NumberSequenceCatalanDigits() : super(mode: NumberSequencesMode.CATALAN, maxDigits: 1111);
}

class NumberSequenceCatalanRange extends NumberSequenceRange {
  NumberSequenceCatalanRange() : super(mode: NumberSequencesMode.CATALAN, maxIndex: 11111);
}

class NumberSequenceCatalanNthNumber extends NumberSequenceNthNumber {
  NumberSequenceCatalanNthNumber() : super(mode: NumberSequencesMode.CATALAN, maxIndex: 11111);
}

class NumberSequenceCatalanContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceCatalanContainsDigits() : super(mode: NumberSequencesMode.CATALAN, maxIndex: 1111);
}
