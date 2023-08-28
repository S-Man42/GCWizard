//const pushLeft = require('./solvers/pushSolver').pushLeft;

import 'package:collection/collection.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/push_solver.dart';

List<List<int>> findGaps(List<int> line) {
  var result = <List<int>>[];
  line.forEachIndexed((i, el) {
    if (el > -1) {
      if (i > 0 && line[i - 1] > -1) {
        result[result.length - 1][1]++;
      } else {
        result.add([i, i + 1]);
      }
    }
  });
  return result;
}

GapInfo? allWithOneGap(List<int> line, List<List<int>> gaps, List<int> hints) {
  var left = gaps[0][0];
  var right = gaps[0][1];
  if (pushSolver.pushLeft(line.sublist(left, right), hints) != null) {
    return GapInfo(gaps, [hints]);
  }
  return null;
}

GapInfo? gapDistributor(List<int> line, List<int> hints) {
  var gaps = findGaps(line);
  if (gaps.length == 1) {
    return allWithOneGap(line, gaps, hints);
  }
  var distributions = <List<int>>[];
  var gap = gaps[0];
  for (var hintCount = 0; hintCount <= hints.length; hintCount++) {
    var first = allWithOneGap(line, [gap], hints.sublist(0, hintCount));
    if (first == null) {
      continue;
    }
    var second = gapDistributor(line.sublist(gap[1]), hints.sublist(hintCount));
    if (second == null) {
      continue;
    }
    for (var x in first.distributions) {
      for (var e in x) {
        for (var y in second.distributions) {
          var item = y.sublist(0);
          item.insert(0, e);
          distributions.add(item);
        }
      }
    }
  }
  return GapInfo(gaps, distributions);
}

class GapInfo {
  List<List<int>> gaps;
  List<List<int>> distributions;

  GapInfo(this.gaps, this.distributions);
}
