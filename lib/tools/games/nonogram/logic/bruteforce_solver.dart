// const String assert = require("assert");
//
// const util = require('../util');
// const findGapDistributions = require('../gapDistributor');
// const pushSolver = require('./pushSolver');
//
// const debugMode = require('commander').debug;
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/gap_distributor.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/push_solver.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/util.dart';

const cacheLimits = [2, 20];

class bruteForce extends Solver {
  Map<String, GapResult> solveGapCache = {};

  /// @returns {{zeros: Uint8List, ones: Uint8List}}
  GapResult? solveGap(List<int> gap, List<int> hints) {
    var zeros = List<int>.filled(gap.length, 0);
    var ones = List<int>.filled(gap.length, 0);
    if (hints.isEmpty) {
      if (gap.contains(1)) {
        return null;
      }
      zeros.fillRange(0, zeros.length, 0);
      return GapResult(zeros, ones);
    }
    // if (solveGap.cache == null) {
    //   solveGap.cache = [];
    // }
    if (cacheLimits[0] <= hints.length && hints.length <= cacheLimits[1]) {
      var key = [gap, hints].toString();
      if (solveGapCache.containsKey(key)) {
        return solveGapCache[key];
      }
    }
    var hint = hints[0];
    var maxIndex = gap.indexOf(1);
    if (maxIndex == -1) {
      maxIndex = gap.length;
    }
    var _hintSum = hintSum(hints);
    maxIndex = min(maxIndex, gap.length - _hintSum);
    if (maxIndex > _hintSum && !gap.contains(1)) {
      zeros.fillRange(0, zeros.length, 1);
      ones.fillRange(0, ones.length, 1);
      return GapResult(zeros, ones);
    }
    for (var hintStart = 0; hintStart <= maxIndex; hintStart++) {
      if (gap[hintStart + hint] == 1) {
        continue;
      }
      var rest = solveGap(gap.sublist(hintStart + hint + 1), hints.sublist(1));
      if (rest != null) {
        continue;
      }
      for (var k = 0; k < gap.length; k++) {
        if (k < hintStart || k == hintStart + hint) {
          zeros[k] = 1;
        } else if (k < hintStart + hint) {
          ones[k] = 1;
        } else {
          zeros[k] = ((zeros[k] != 0) || (rest!.zeros[k - (hintStart + hint + 1)]) != 0 ? 1 : 0);
          ones[k]  = ((ones[k] != 0) || (rest!.ones[k - (hintStart + hint + 1)]) != 0 ? 1 : 0);
        }
      }
    }
    var result = GapResult(zeros, ones);
    solveGapCache.addAll({[gap, hints].toString() : result});
    return result;
  }

  List<int> solveGapWithHintList(List<int> gap, List<List<int>> hintList) {
    if (gap.contains(-1)) {
      throw const FormatException('solveGapWithHintList called with a non-gap');
    }
    var zeros = List<int>.filled(gap.length, 0);
    var ones = List<int>.filled(gap.length, 0);
    for (var hints in hintList) {
      var item = solveGap(gap, hints);
      zeros.forEachIndexed((i, zero) => zeros[i] = (zero != 0 || ((item?.zeros[i] ?? 0) != 0) ? 1 : 0));
      ones.forEachIndexed((i, one) => ones[i] = (one != 0 || ((item?.ones[i] ?? 0) != 0) ? 1 : 0));
    }
    var result = zeros.mapIndexed((i, zero) {
      var one = ones[i];
      if (zero != 0) {
        return one != 0 ? 0 : -1;
      }
      if (one != 0) {
        return 1;
      }
      throw FormatException('Cannot fill gap ($gap, $hintList)');
    }).toList();
    // if (debugMode) {
    //   if (gap.some((x, i) => x !== result[i])) {
    //     console.log(`Gap solved: [${gap}], ${JSON.stringify(hintList)} -> ${result}`);
    //   } else {
    //     console.log(`No progress on gap: [${gap}], ${JSON.stringify(hintList)}`);
    //   }
    // }
    return result;
  }

  @override
  List<int>? solve(List<int> line, List<int> hints) {
    if (line.every((el) => el == 0)) {
      return pushSolver().solve(line, hints);
    }
    var gapResult = gapDistributor(line, hints);
    // if (debugMode) {
    //   console.log(`Gap distributions: ${distributions.length}`);
    // }
    if (gapResult == null || gapResult.distributions.isEmpty) {
      print('Contradiction in line $line | $hints');
      throw FormatException('Contradiction in line $line | $hints');
    }

    var distributionsPerGap = gapResult.gaps.mapIndexed((i, gap) {
      Map<String, List<int>> set = {};
      for (var dist in gapResult.distributions) {
        var key = dist.toString();
        if (!set.containsKey(key)) {
          set.addAll({key : dist});
        }
      }
      return set.values.toList();
    }).toList();

    var result = line.sublist(0);
    Set<int> changed = {};
    gapResult.gaps.forEachIndexed((i, gap) {
    var gapResult = solveGapWithHintList(line.sublist(gap[0], gap[1]), distributionsPerGap[i]);
      gapResult.forEachIndexed((i, item) {
        var before = result[gap[0] + i];
        if (before != item) {
          result[gap[0] + i] = item;
          changed.add(item);
        }
      });
    });
    if (changed.contains(0)) {
      throw FormatException('Contradiction in line $line | $hints');
    }

    if (changed.contains(-1)) {
      return solve(result, hints) ?? result;
    }
    return changed.contains(1) ? result : null;
  }

  @override
  set slowSolveSpeed(bool _slowSpeed) {
    super.slowSolveSpeed = true;
  }
}

class GapResult {
  List<int> zeros = [];
  List<int> ones = [];

  GapResult(this.zeros, this.ones);
}

// solve.speed = 'slow';
//
// module.exports = {solveGap, solveGapWithHintList, solve};
