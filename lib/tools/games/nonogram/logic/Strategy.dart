// const util = require("./util");
// const guessAndConquer = require('./guessAndConquer');
//
// const debugMode = require('commander').debug;

import 'package:collection/collection.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/puzzle.dart';

/**
 * Strategy for solving a puzzle by applying line solvers repeatedly
 */
class Strategy {
  /**
   * @param {Array} solvers List of line solvers sorted by speed
   * @param {boolean} randomize `false` to run trial and error in order. Defaults to `true`.
   *     In practice, using random guessing mostly yields faster results.
   */
  // constructor(solvers, randomize = true) {
  //   this.solvers = solvers;
  //   this.randomize = randomize;
  // }

  /**
   * Solve the puzzle.
   * @param {Puzzle} puzzle The puzzle to solve
   * @param {boolean} withTrialAndError `false` to stop without trial and error. Defaults to `true`.
   */
  void solve(puzzle, withTrialAndError = true) {
    // if (debugMode) {
    //   var start = Date.now();
    //   var statistics = Array(this.solvers.length).fill(0);
    //   var solutionSequence = [];
    // }

    // keep tracks of visited lines
    this.visited = {
      rows: Array(puzzle.height).fill(0).map(() =>  Uint8Array(this.solvers.length)),
      columns: Array(puzzle.width).fill(0).map(() =>  Uint8Array(this.solvers.length))
    };

    // repeatedly run all solvers on puzzle
    double progress = 0;
    do {
      var snapshot = puzzle.snapshot;
      progress = false;
      this.solvers.forEach((solver, i) => {
        if (progress) {
          return;
        }
        // run one line solver on the whole puzzle
        this.solveOnce(puzzle, solver, i, solutionSequence);
        progress = puzzle.snapshot.toString() !== snapshot.toString();
        // if (debugMode) {
        //   statistics[i]++;
        // }
      });
    } while(progress);

    // no solution found… trial and error now
    if (withTrialAndError && !puzzle.isFinished) {
      if (debugMode) {
        console.log('must start guessing');
      }
      let deepResult = guessAndConquer(this, puzzle);
      if (deepResult) {
        puzzle.import(deepResult);
      }
    }

    if (debugMode) {
      console.log(`Solution sequence: [${solutionSequence.join(',')}]`);
      console.log(`Time elapsed: ${Date.now() - start}ms`);
      console.log(`Runs (on puzzle) per solver: ${JSON.stringify(statistics)}`);
    }
  }

  /**
   * @private
   * Run one solver on the puzzle
   * @param {Puzzle} puzzle The puzzle to solve
   * @param {Solver} solver The solver to use
   * @param {number} solverIndex The solver's index in `this.solvers`
   * @param {Array} solutionSequence Array of strings for statistics in debug mode
   */
  void solveOnce(Puzzle puzzle) { //, solver, solverIndex, solutionSequence
    // If we're dealing with a slow solver, we want to skip as soon as one line is partially solved
    var skipEarly = false; //solver.speed == 'slow';
    var skip = false;

    // Optimize iteration order
    // var optimizeOrder = (lines, hints) => {
    //   // remove already solved lines
    //   let unsolvedLines = lines.reduce((result, line, index) => {
    //     let zeros = line.reduce((count, x) => count + (x === 0 ? 1 : 0), 0);
    //     if (!zeros) {
    //       return result;
    //     }
    //     result.push({line, index, zeros});
    //     return result;
    //   }, []);
    //
    //   // sort by estimated computation effort
    //   if (skipEarly) {
    //     unsolvedLines.forEach(lineMeta => {
    //       let {index, zeros} = lineMeta;
    //       let hintSum = util.hintSum(hints[index]);
    //       let estimate = zeros < hintSum ? 0 : Math.pow(zeros - hintSum, hints[index].length);
    //       lineMeta.estimate = estimate;
    //     });
    //     unsolvedLines.sort(({estimate: left}, {estimate: right}) => left - right);
    //   }
    //   return unsolvedLines;
    // };
    // Optimize iteration order
     var optimizeOrder = _optimizeOrder(puzzle.lines, puzzle.rowHints);

    // the actual execution
    let run = (lines, hints, onRow) => {
      let visited = onRow ?
        {current: this.visited.rows, other: this.visited.columns} :
        {current: this.visited.columns, other: this.visited.rows};
      let rearrangedLines = optimizeOrder(lines, hints);
      rearrangedLines.forEach(({line, index: i, estimate}) => {
        if (skip || visited.current[i][solverIndex]) {
          return;
        }
        if (debugMode) {
          console.log(`Running solver ${solverIndex} on ${onRow ? 'row' : 'column'} ${i}`, JSON.stringify(line.slice()), hints[i]);
          if (estimate) {
            console.log(`Estimated effort: ${estimate}`);
          }
        }
        visited.current[i][solverIndex] = 1;
        // First, trim unnecessary information from the line
        let [trimmedLine, trimmedHints, trimInfo] = util.trimLine(line, hints[i]);
        if (debugMode) {
          var start = Date.now();
        }
        // solver run
        let newLine = solver(trimmedLine, trimmedHints);

        if (debugMode) {
          let end = Date.now();
          if (end - start > 100) {
            console.log(`Long run: ${end - start}ms`);
          }
        }

        // now, restore the trimmed line and analyze the result
        let hasChanged = false;
        let changedLines = [];
        if (newLine) { // the solver may return null to indicate no progress
          newLine = util.restoreLine(newLine, trimInfo);
          line.forEach((el, i) => {
            // What has changed?
            if (el !== newLine[i]) {
              line[i] = newLine[i];
              // These perpendicular lines must be revisited
              visited.other[i].fill(0);
              if (debugMode) {
                changedLines.push(i);
              }
            }
          });
          hasChanged = changedLines.length > 0;
          skip = hasChanged && skipEarly;
        }

        if (!debugMode) {
          util.spinner.spin();
        } else if (hasChanged) {
          console.log(`found ${newLine}`);
          console.log(puzzle);
          console.log(`Must revisit ${onRow ? 'column' : 'row'}${changedLines.length > 1 ? 's' : ''} ${changedLines.join(',')}`);
          solutionSequence.push(`(${solverIndex})${onRow ? 'r' : 'c'}${i}[${changedLines.join(',')}]`);
        }
      });
    };

    // run on rows
    run(puzzle.rows, puzzle.rowHints, true);
    if (skip) {
      return;
    }
    // …and then on columns
    run(puzzle.columns, puzzle.columnHints);
  }

  // the actual execution
  void run (lines, hints, onRow) => {
  let visited = onRow ?
  {current: this.visited.rows, other: this.visited.columns} :
  {current: this.visited.columns, other: this.visited.rows};
  let rearrangedLines = optimizeOrder(lines, hints);
  rearrangedLines.forEach(({line, index: i, estimate}) => {
  if (skip || visited.current[i][solverIndex]) {
  return;
  }
  if (debugMode) {
  console.log(`Running solver ${solverIndex} on ${onRow ? 'row' : 'column'} ${i}`, JSON.stringify(line.slice()), hints[i]);
  if (estimate) {
  console.log(`Estimated effort: ${estimate}`);
  }
  }
  visited.current[i][solverIndex] = 1;
  // First, trim unnecessary information from the line
  let [trimmedLine, trimmedHints, trimInfo] = util.trimLine(line, hints[i]);
  if (debugMode) {
  var start = Date.now();
  }
  // solver run
  let newLine = solver(trimmedLine, trimmedHints);

  if (debugMode) {
  let end = Date.now();
  if (end - start > 100) {
  console.log(`Long run: ${end - start}ms`);
  }
  }

  // now, restore the trimmed line and analyze the result
  let hasChanged = false;
  let changedLines = [];
  if (newLine) { // the solver may return null to indicate no progress
  newLine = util.restoreLine(newLine, trimInfo);
  line.forEach((el, i) => {
  // What has changed?
  if (el !== newLine[i]) {
  line[i] = newLine[i];
  // These perpendicular lines must be revisited
  visited.other[i].fill(0);
  if (debugMode) {
  changedLines.push(i);
  }
  }
  });
  hasChanged = changedLines.length > 0;
  skip = hasChanged && skipEarly;
  }

  if (!debugMode) {
  util.spinner.spin();
  } else if (hasChanged) {
  console.log(`found ${newLine}`);
  console.log(puzzle);
  console.log(`Must revisit ${onRow ? 'column' : 'row'}${changedLines.length > 1 ? 's' : ''} ${changedLines.join(',')}`);
  solutionSequence.push(`(${solverIndex})${onRow ? 'r' : 'c'}${i}[${changedLines.join(',')}]`);
  }
  });
};

  // Optimize iteration order
  List<List<int>> _optimizeOrder(List<List<int>> lines, List<int> hints, bool skipEarly) {

    //List<LineMetaData> result = [];
    // remove already solved lines
    var unsolvedLines = lines.mapIndexed((index, line) {
      var zeros = line.reduce((count, x) => count + (x == 0 ? 1 : 0));
      if (zeros != 0) {
        return null;
      }
      //result.add(LineMetaData(line, index, zeros));
      return LineMetaData(line, index, zeros);
    });

    // sort by estimated computation effort
    if (skipEarly) {
      unsolvedLines.forEachIndexed((index, lineMeta) {
        'var {index, zeros} = lineMeta;
          var hintSum = hintSum(hints[index]);
          var estimate = (lineMeta.zeros < hintSum) ? 0 : pow(zeros - hintSum, hints[index].length);
        lineMeta.estimate = estimate;
        });
        unsolvedLines.sort(({estimate: left}, {estimate: right}) => left - right);
        }
        return unsolvedLines;
    };

  return unsolvedLines;
}

// module.exports = Strategy;

class LineMetaData {
  var index = 0;
  var zeros = 0;
  List<int> line = [];

  LineMetaData(this.line, this.index, this.zeros);
}
