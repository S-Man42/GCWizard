// const assert = require("assert");
//
// const Puzzle = require('./Puzzle');

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/Strategy.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/puzzle.dart';
import 'package:utility/utility.dart';


// const { recursionDepth: maxRecursionLevel, debugMode } = require('commander');

int getNextIndex(List<int> zeroIndexes, bool randomize) {
  if (zeroIndexes.isEmpty) return 0;
  if (randomize) {
    var random = (Random().nextDouble() * zeroIndexes.length).floor();
     zeroIndexes.removeAt(random);
    return zeroIndexes.first;
  }
  return zeroIndexes.removeFirst()!;
}
//
// void recurse(Strategy strategy, int currentRecursionLevel, snapshot, int index, trial) {
//   if (currentRecursionLevel >= maxRecursionLevel) {
//     // reset and just try the next index
//     snapshot[index] = 0;
//     return;
//   }
//   // try recursion
//   var anotherTry = Puzzle({
//     rows: trial.rowHints,
//     columns: trial.columnHints,
//     content: snapshot
//   });
//   // if (debugMode) {
//   //   console.log('>>> Recursing to level ${currentRecursionLevel + 1}');
//   // }
//   var result = guessAndConquer(strategy, anotherTry, currentRecursionLevel + 1);
//   // if (debugMode) {
//   //   console.log('<<< Done recursing level ${currentRecursionLevel + 1}');
//   // }
//   return result;
// }

/**
 * Run trial and error iteration
 * @param {Strategy} strategy The strategy to use
 * @param {Puzzle} puzzle The puzzle to solve
 * @param {number} currentRecursionLevel (internal) keep track of recursion depth
 */
Puzzle? guessAndConquer(Strategy strategy, Puzzle puzzle, {int currentRecursionLevel = 0}) {
  const int maxGuessCount = 100;
  if (puzzle.isFinished) {
    return puzzle.isSolved ? puzzle : null;
  }
  var snapshot = puzzle.snapshot();
  var zeroIndexes = <int>[];
  // find unsolved cells
  snapshot.forEachIndexed((i, x) {
    if (x == 0) {
      zeroIndexes.add(i);
    }
  });

  if (zeroIndexes.isEmpty) {
    throw const FormatException('Contradiction in trial and error');
  }

  for (var i = 0;  i < min(maxGuessCount, zeroIndexes.length); i++) {
    var index = getNextIndex(zeroIndexes, strategy.randomize);
    // try and set the 'index'th cell to 1, and create a new Puzzle from that
    snapshot[index] = 1;
    var trial = Puzzle(
      puzzle.rowHints.sublist(0),
      puzzle.columnHints.sublist(0),
      content: snapshot
    });
    // if (debugMode) {
    //   console.log('*********************************************************');
    //   console.log('Using trialAndError method on ${i}. zero (index ${index})');
    //   console.log('*********************************************************');
    // }
    // solve the trial puzzle
    try {
      strategy.solve(trial, false); // may throw an exception on contradiction
      if (trial.isFinished) {
        if (!trial.isSolved) {
          // This is a contradiction
          throw Exception('Not a solution');
        }
        if (debugMode) {
          console.log('Successfully guessed square ${index}=1');
        }
        // We found a solution by guessing.
        return trial;
      }
      // No progress
      var result = recurse(strategy, currentRecursionLevel, snapshot, index, trial);
      if (result) {
        if (debugMode) {
          console.log('[${currentRecursionLevel}] Successfully guessed square ${index}=1');
        }
        return result;
      }
      // reset and just try the next index
      snapshot[index] = 0;
    } catch (e) {
      // A contradiction has occurred, which means we can be sure that 'index'th cell is empty
      if (debugMode) {
        console.log('[${currentRecursionLevel}] Successfully guessed square ${index}=-1 by contradiction');
      }
      snapshot[index] = -1;
    }
  }
  return null;
}

// module.exports = guessAndConquer;
