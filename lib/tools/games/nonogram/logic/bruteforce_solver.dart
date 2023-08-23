// const String assert = require("assert");
//
// const util = require('../util');
// const findGapDistributions = require('../gapDistributor');
// const pushSolver = require('./pushSolver');
//
// const debugMode = require('commander').debug;
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/gap_distributor.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/push_solver.dart';
import 'package:tuple/tuple.dart';

const cacheLimits = [2, 20];

class bruteForce extends Solver {
  var solveGapCache = <List<int>>[];

  /// @returns {{zeros: Uint8List, ones: Uint8List}}
  GapResult? solveGap(List<int> gap, List<int> hints) {
    var zeros = List<bool>.filled(gap.length, false);
    var ones = List<bool>.filled(gap.length, false);
    if (hints.isEmpty) {
      if (gap.contains(1)) {
        return null;
      }
      zeros.fillRange(0, zeros.length, false);
      return GapResult(zeros, ones);
    }
    // if (solveGap.cache == null) {
    //   solveGap.cache = [];
    // }
    if (cacheLimits[0] <= hints.length && hints.length <= cacheLimits[1]) {
      var candidate = solveGap.cache[JSON.stringify([gap, hints])];
      if (candidate) {
        return candidate;
      }
    }
    var hint = hints[0];
    var maxIndex = gap.indexOf(1);
    if (maxIndex == -1) {
      maxIndex = gap.length;
    }
    var hintSum = hintSum(hints);
    maxIndex = min(maxIndex, gap.length - hintSum);
    if (maxIndex > hintSum && !gap.contains(1)) {
      zeros.fillRange(0, zeros.length, true);
      ones.fillRange(0, ones.length, true);
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
          zeros[k] = true;
        } else if (k < hintStart + hint) {
          ones[k] = true;
        } else {
          zeros[k] = (zeros[k] || rest!.zeros[k - (hintStart + hint + 1)]);
          ones[k]  = (ones[k] || rest!.ones[k - (hintStart + hint + 1)]);
        }
      }
    }
    var result = GapResult(zeros, ones);
    solveGap.cache[JSON.stringify([gap, hints])] = result;
    return result;
  }

  List<bool> solveGapWithHintList(List<int> gap, List<List<int>> hintList) {
    if (gap.contains(-1)) {
      throw const FormatException('solveGapWithHintList called with a non-gap');
    }
    var zeros = List<bool>.filled(gap.length, false);
    var ones = List<bool>.filled(gap.length, false);
    for (var hints in hintList) {
      var item = solveGap(gap, hints);
      zeros.forEachIndexed((i, zero) => zeros[i] = (zero || (item?.zeros[i] ?? false));
      ones.forEachIndexed((i, one) => ones[i] = (one || item?.ones[i]));
    }
    var result = zeros.mapIndexed((i, zero) {
      var one = ones[i];
      if (zero) {
        return one;
      }
      if (one) {
        return true;
      }
      throw FormatException('Cannot fill gap ($gap, $hintList)');
    });
    // if (debugMode) {
    //   if (gap.some((x, i) => x !== result[i])) {
    //     console.log(`Gap solved: [${gap}], ${JSON.stringify(hintList)} -> ${result}`);
    //   } else {
    //     console.log(`No progress on gap: [${gap}], ${JSON.stringify(hintList)}`);
    //   }
    // }
    return result.toList();
  }

  List<int>? solve(List<int> line, List<int> hints) {
    if (line.every((el) => el == 0)) {
      return pushSolver().solve(line, hints);
    }
    var gapResult = gapDistributor(line, hints);
    // if (debugMode) {
    //   console.log(`Gap distributions: ${distributions.length}`);
    // }
    if (gapResult == null || gapResult.distributions.isEmpty) {
      throw FormatException('Contradiction in line $line | $hints');
    }

    var distributionsPerGap = gapResult.gaps.mapIndexed((i, gap) {
      Set<int> set = {};
      gapResult.distributions.forEach((dist) {
        set.add(JSON.stringify(dist[i]));
      });
      return set.map((x) => JSON.parse(x));
    });
    var result = line.sublist(0);
    Set<bool> changed = {};
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
    if (changed.contains(false)) {
      throw FormatException('Contradiction in line $line | $hints');
    }

    if (changed.contains(-1)) {
      return solve(result, hints) || result;
    }
    return changed.contains(1) ? result : null;
  }
}

class GapResult {
  List<bool> zeros = [];
  List<bool> ones = [];

  GapResult(this.zeros, this.ones);
}

// solve.speed = 'slow';
//
// module.exports = {solveGap, solveGapWithHintList, solve};
