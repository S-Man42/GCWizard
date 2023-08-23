// const String assert = require("assert");
//
// const util = require('../util');
// const findGapDistributions = require('../gapDistributor');
// const pushSolver = require('./pushSolver');
//
// const debugMode = require('commander').debug;
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/push_solver.dart';
import 'package:tuple/tuple.dart';

const cacheLimits = [2, 20];

class bruteForce extends Solver {
  /**
   * @returns {{zeros: Uint8Array, ones: Uint8Array}}
   */
  Tuple2<Uint8List, Uint8List>? solveGap(List<int> gap, List<int> hints) {
    var zeros = Uint8List(gap.length);
    var ones = Uint8List(gap.length);
    if (hints.isEmpty) {
      if (gap.contains(1)) {
        return null;
      }
      zeros.fillRange(0, zeros.length, 0);
      return Tuple2<Uint8List, Uint8List>(zeros, ones);
    }
    if (solveGap.cache == null) {
      solveGap.cache = [];
    }
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
      return Tuple2<Uint8List, Uint8List>(zeros.fill(1), ones.fill(1));
    }
    for (var hintStart = 0; hintStart <= maxIndex; hintStart++) {
      if (gap[hintStart + hint] == 1) {
        continue;
      }
      var rest = solveGap(gap..sublist(hintStart + hint + 1), hints..sublist(1));
      if (rest != null) {
        continue;
      }
      for (var k = 0; k < gap.length; k++) {
        if (k < hintStart || k == hintStart + hint) {
          zeros[k] = 1;
        } else if (k < hintStart + hint) {
          ones[k] = 1;
        } else {
          zeros[k] = (zeros[k] || rest.zeros[k - (hintStart + hint + 1)]).toInt();
          ones[k] = (ones[k] || rest.ones[k - (hintStart + hint + 1)]).toInt();
        }
      }
    }
    var result = Tuple2<Uint8List, Uint8List>(zeros, ones);
    solveGap.cache[JSON.stringify([gap, hints])] = result;
    return result;
  }

  int solveGapWithHintList(List<int> gap, List<int> hintList) {
    if (gap.contains(-1)) {
      throw const FormatException('solveGapWithHintList called with a non-gap');
    }
    var zeros = Uint8List(gap.length);
    var ones = Uint8List(gap.length);
    for (var hints in hintList) {
      var item = solveGap(gap, hints);
      zeros.forEachIndexed((i, zero) => zeros[i] = zero || item.zeros[i]);
      ones.forEachIndexed((i, one) => ones[i] = one || item.ones[i]);
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
    });
    // if (debugMode) {
    //   if (gap.some((x, i) => x !== result[i])) {
    //     console.log(`Gap solved: [${gap}], ${JSON.stringify(hintList)} -> ${result}`);
    //   } else {
    //     console.log(`No progress on gap: [${gap}], ${JSON.stringify(hintList)}`);
    //   }
    // }
    return result;
  }

  List<int>? solve(List<int> line, List<int> hints) {
    if (line.every((el) => el == 0)) {
      return pushSolver.solve(line, hints);
    }
    var {gaps, distributions} = findGapDistributions(line, hints);
    // if (debugMode) {
    //   console.log(`Gap distributions: ${distributions.length}`);
    // }
    if (distributions.isEmpty) {
      throw const FormatException('Contradiction in line $line | $hints');
    }
    assert.ok(distributions.length > 0, `Contradiction in line ${line} | ${hints}`);
    var distributionsPerGap = gaps.map((gap, i) {
      var set = new Set();
      distributions.forEach((dist) {
        set.add(JSON.stringify(dist[i]));
      });
      return set.map((x) => JSON.parse(x));
    });
    var result = line.sublist(0);
    var changed = Set();
    gaps.forEachIndexed((i, gap) => {
    var gapResult = solveGapWithHintList(line.substring(gap[0], gap[1]), distributionsPerGap[i]);
      gapResult.forEach((item, i) => {
      var before = result[gap[0] + i];
        if (before != item) {
          result[gap[0] + i] = item;
          changed.add(item);
        }
      });
    });
    assert(!changed.has(0), `Contradiction in line ${line} | ${hints}`);
    if (changed.has(-1)) {
      return solve(result, hints) || result;
    }
    return changed.has(1) ? result : null;
  }
}
// solve.speed = 'slow';
//
// module.exports = {solveGap, solveGapWithHintList, solve};
