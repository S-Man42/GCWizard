// const util = require("./util");
// const guessAndConquer = require('./guessAndConquer');
//
// const debugMode = require('commander').debug;

import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/pushSolver.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/puzzle.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/util.dart';

//import 'guessAndConquer.dart';

/**
 * Strategy for solving a puzzle by applying line solvers repeatedly
 */
class Strategy {
  late VisitedG _visited;
  // List<int> _solvers = List<int>.filled(2, 0);
  // /**
  //  * @param {Array} solvers List of line solvers sorted by speed
  //  * @param {boolean} randomize 'false' to run trial and error in order. Defaults to 'true'.
  //  *     In practice, using random guessing mostly yields faster results.
  //  */
  // constructor(solvers, randomize = true) {
  //   this.solvers = solvers;
  //   this.randomize = randomize;
  // }

  // /**
  //  * Solve the puzzle.
  //  * @param {Puzzle} puzzle The puzzle to solve
  //  * @param {boolean} withTrialAndError 'false' to stop without trial and error. Defaults to 'true'.
  //  */
  Puzzle solveQ(Puzzle puzzle, {bool withTrialAndError = true}) {
    var solvers = [pushSolver()];
    // keep tracks of visited lines
    _visited = VisitedG(
      rows: List<Uint8List>.generate(puzzle.height, (index) => Uint8List(solvers.length)),
      columns: List<Uint8List>.generate(puzzle.width, (index) => Uint8List(solvers.length))
    );

    // repeatedly run all solvers on puzzle
    bool progress = false;
    //solveOnce(puzzle, solvers[0], 0);
    do {
      var snapshotRows = createHash(puzzle.rows);
      var snapshotColumns = createHash(puzzle.columns);
      progress = false;
      var i  = 0;
      solvers.forEachIndexed((i, solver) { //.forEachIndexed((i, solver)
        if (progress) {
          return;
        }

        // run one line solver on the whole puzzle
        _solveOnce(puzzle, solver, i); //, solutionSequence
        //print(puzzle.state);
        progress = snapshotRows != createHash(puzzle.rows) || snapshotColumns != createHash(puzzle.columns);
        // if (debugMode) {
        //   statistics[i]++;
        // }
      });

    } while(progress);

    // // no solution found… trial and error now
    // if (withTrialAndError && !puzzle.isFinished) {
    //   // if (debugMode) {
    //   // console.log('must start guessing');
    //   // }
    //   var deepResult = guessAndConquer(this, puzzle);
    //   if (deepResult) {
    //     //puzzle.import(deepResult);
    //   }
    // }

    // if (debugMode) {
    // console.log('Solution sequence: [${solutionSequence.join(',')}]');
    // console.log('Time elapsed: ${Date.now() - start}ms');
    // console.log('Runs (on puzzle) per solver: ${JSON.stringify(statistics)}');
    // }
    return puzzle;
  }

  /**
   * @private
   * Run one solver on the puzzle
   * @param {Puzzle} puzzle The puzzle to solve
   * @param {Solver} solver The solver to use
   * @param {number} solverIndex The solver's index in 'this.solvers'
   * @param {Array} solutionSequence Array of strings for statistics in debug mode
   */
  void _solveOnce(Puzzle puzzle, Solver solver, int solverIndex) { //, solver, solutionSequence
    // If we're dealing with a slow solver, we want to skip as soon as one line is partially solved
    var skipEarly = true; //solver.speed == 'slow';
    var skip = false;

    // run on rows
    puzzle.rows = run(puzzle.rows, puzzle.rowHints, true, solver, solverIndex, skip, skipEarly);
    if (skip) {
      return;
    }
    // …and then on columns
    puzzle.columns = run(puzzle.columns, puzzle.columnHints, false, solver, solverIndex, skip, skipEarly);
  }

  // the actual execution
  List<List<int>> run(List<List<int>> lines, List<List<int>> hints, bool onRow, Solver solver, int solverIndex, bool skip, bool skipEarly) {
    var visited = onRow ?
      VisitedL(current: _visited.rows, other: _visited.columns) :
      VisitedL(current: _visited.columns, other: _visited.rows);
    var rearrangedLines = _optimizeOrder(lines, hints, skipEarly);
    for (var line in rearrangedLines) { //estimate
      if (skip || visited.current[line.index][solverIndex] != 0) {
        continue;
      }
      // if (debugMode) {
      //   console.log('Running solver ${solverIndex} on ${onRow ? 'row' : 'column'} ${i}', JSON.stringify(line.slice()), hints[i]);
      //   if (estimate) {
      //     console.log('Estimated effort: ${estimate}');
      //   }
      // }
      visited.current[line.index][solverIndex] = 1;
      // First, trim unnecessary information from the line
      var trimresult = trimLine(line.line, hints[line.index]); //[trimmedLine, trimmedHints, trimInfo]
      if (trimresult.error.isNotEmpty) {
        continue;
      }
  // if (debugMode) {
      // var start = Date.now();
      // }
      // solver run
      print('index ' + line.index.toString() + ' trimmedLine ' + trimresult.trimmedLine.toString() + ' trimmedHints ' + trimresult.trimmedHints.toString());
      var newLine = solver.solve(trimresult.trimmedLine!, trimresult.trimmedHints!);

      // if (debugMode) {
      //   var end = Date.now();
      //   if (end - start > 100) {
      //     console.log('Long run: ${end - start}ms');
      //   }
      // }

      // now, restore the trimmed line and analyze the result
      var hasChanged = false;
      var changedLines = <int>[];
      if (newLine != null) { // the solver may return null to indicate no progress
        print('newLine ' + newLine.toString());
        newLine = restoreLine(newLine, trimresult.trimInfo!);
        line.line.forEachIndexed((i, el) {
          // What has changed?
          if (el != newLine![i]) {
            line.line[i] = newLine[i];
            // These perpendicular lines must be revisited
            visited.other[i].setAll(0, List<int>.filled(visited.other[i].length, 0));
            // if (debugMode) {
            //   changedLines.push(i);
            // }
          }
        });
        hasChanged = changedLines.isNotEmpty;
        skip = hasChanged && skipEarly;
      }

      // if (!debugMode) {
      //   util.spinner.spin();
      // } else if (hasChanged) {
      //   console.log('found ${newLine}');
      //   console.log(puzzle);
      //   console.log('Must revisit ${onRow ? 'column' : 'row'}${changedLines.length > 1 ? 's' : ''} ${changedLines.join(',')}');
      //   solutionSequence.push('(${solverIndex})${onRow ? 'r' : 'c'}${i}[${changedLines.join(',')}]');
      // }

    }
    return lines;
  }

  // Optimize iteration order
  List<LineMetaData> _optimizeOrder(List<List<int>> lines, List<List<int>> hints, bool skipEarly) {

    //List<LineMetaData> result = [];
    // remove already solved lines
    var unsolvedLines = lines.mapIndexed((index, line) {
      var zeros = line.where((element) => element == 0).length; //.reduce((count, x) => count + (x == 0 ? 1 : 0));
      if (zeros == 0) {
        return null;
      }
      //result.add(LineMetaData(line, index, zeros));
      return LineMetaData(line, index, zeros);
    }).whereNotNull();

    // sort by estimated computation effort
    if (skipEarly) {
      unsolvedLines = unsolvedLines.map((lineMeta) {
        //var {index, zeros} = lineMeta;
        var _hintSum = hintSum(hints[lineMeta.index]);
        var estimate = (lineMeta.zeros < _hintSum) ? 0 : pow(lineMeta.zeros - _hintSum, hints[lineMeta.index].length).toInt();
        lineMeta.estimate = estimate;
        return lineMeta;
      });
      unsolvedLines = unsolvedLines.sorted((left, right) => left.estimate - right.estimate);
    }
  return unsolvedLines.toList();
  }
}
// module.exports = Strategy;



class VisitedG {
  List<Uint8List> rows = [];
  List<Uint8List> columns = [];

  VisitedG({required this.rows, required this.columns});
}

class VisitedL {
  List<Uint8List> current = [];
  List<Uint8List> other = [];

  VisitedL({required this.current, required this.other});
}


