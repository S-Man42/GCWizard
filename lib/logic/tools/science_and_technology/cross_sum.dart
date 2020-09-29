import 'package:gc_wizard/utils/crosstotals.dart';

enum CrossSumType {NORMAL, ITERATED}

List<int> crossSumRange(int rangeStart, int rangeEnd, int crossSumToFind, {CrossSumType type: CrossSumType.NORMAL}) {
  if (rangeStart == null || rangeEnd == null || crossSumToFind == null)
    return [];

  if (rangeStart > rangeEnd) {
    var help = rangeEnd;
    rangeEnd = rangeStart;
    rangeStart = help;
  }

  var out = <int>[];
  for (int i = rangeStart; i <= rangeEnd; i++) {
    var crossSumResult;
    switch (type) {
      case CrossSumType.NORMAL: crossSumResult = crossSum([i]); break;
      case CrossSumType.ITERATED: crossSumResult = crossSumIterated([i]); break;
    }

    if (crossSumResult.toInt() == crossSumToFind)
      out.add(i);
  }

  return out;
}