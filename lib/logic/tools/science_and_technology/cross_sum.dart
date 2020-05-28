import 'package:gc_wizard/utils/crosstotals.dart';

List<int> crossSumRange(int rangeStart, int rangeEnd, int crossSumToFind) {
  if (rangeStart == null || rangeEnd == null || crossSumToFind == null)
    return [];

  if (rangeStart > rangeEnd) {
    var help = rangeEnd;
    rangeEnd = rangeStart;
    rangeStart = help;
  }

  var out = <int>[];
  for (int i = rangeStart; i <= rangeEnd; i++) {
    if (crossSum([i]).toInt() == crossSumToFind)
      out.add(i);
  }

  return out;
}