const assert = require("assert");

const util = require('../util');
const findGapDistributions = require('../gapDistributor');
const pushSolver = require('./pushSolver');

const debugMode = require('commander').debug;
const cacheLimits = [2, 20];

/**
 * @returns {{zeros: Uint8Array, ones: Uint8Array}}
 */
let solveGap = (gap, hints) => {
  let zeros = new Uint8Array(gap.length);
  let ones = new Uint8Array(gap.length);
  if (hints.length === 0) {
    if (gap.includes(1)) {
      return null;
    }
    return {
      zeros: zeros.fill(1),
      ones
    };
  }
  if (!solveGap.cache) {
    solveGap.cache = {};
  }
  if (cacheLimits[0] <= hints.length && hints.length <= cacheLimits[1]) {
    let candidate = solveGap.cache[JSON.stringify([gap, hints])];
    if (candidate) {
      return candidate;
    }
  }
  let hint = hints[0];
  let maxIndex = gap.indexOf(1);
  if (maxIndex === -1) {
    maxIndex = gap.length;
  }
  let hintSum = util.hintSum(hints);
  maxIndex = Math.min(maxIndex, gap.length - hintSum);
  if (maxIndex > hintSum && !gap.includes(1)) {
    return {
      zeros: zeros.fill(1),
      ones: ones.fill(1)
    };
  }
  for (let hintStart = 0; hintStart <= maxIndex; hintStart++) {
    if (gap[hintStart + hint] === 1) {
      continue;
    }
    let rest = solveGap(gap.slice(hintStart + hint + 1), hints.slice(1));
    if (!rest) {
      continue;
    }
    for (let k = 0; k < gap.length; k++) {
      if (k < hintStart || k === hintStart + hint) {
        zeros[k] = 1;
      } else if (k < hintStart + hint) {
        ones[k] = 1;
      } else {
        zeros[k] = zeros[k] || rest.zeros[k - (hintStart + hint + 1)];
        ones[k] = ones[k] || rest.ones[k - (hintStart + hint + 1)];
      }
    }
  }
  let result = {zeros, ones};
  solveGap.cache[JSON.stringify([gap, hints])] = result;
  return result;
};

let solveGapWithHintList = (gap, hintList) => {
  assert(!gap.includes(-1), 'solveGapWithHintList called with a non-gap');
  let zeros = new Uint8Array(gap.length);
  let ones = new Uint8Array(gap.length);
  hintList.forEach(hints => {
    let item = solveGap(gap, hints);
    zeros.forEach((zero, i) => zeros[i] = zero || item.zeros[i]);
    ones.forEach((one, i) => ones[i] = one || item.ones[i]);
  });
  let result = Array.from(zeros).map((zero, i) => {
    let one = ones[i];
    if (zero) {
      return one ? 0 : -1;
    }
    if (one) {
      return 1;
    }
    throw new Error('Cannot fill gap', gap, hintList);
  });
  if (debugMode) {
    if (gap.some((x, i) => x !== result[i])) {
      console.log(`Gap solved: [${gap}], ${JSON.stringify(hintList)} -> ${result}`);
    } else {
      console.log(`No progress on gap: [${gap}], ${JSON.stringify(hintList)}`);
    }
  }
  return result;
};

let solve = (line, hints) => {
  if (line.every(el => el === 0)) {
    return pushSolver.solve(line, hints);
  }
  let {gaps, distributions} = findGapDistributions(line, hints);
  if (debugMode) {
    console.log(`Gap distributions: ${distributions.length}`);
  }
  assert.ok(distributions.length > 0, `Contradiction in line ${line} | ${hints}`);
  let distributionsPerGap = gaps.map((gap, i) => {
    let set = new Set();
    distributions.forEach(dist => {
      set.add(JSON.stringify(dist[i]));
    });
    return Array.from(set).map(x => JSON.parse(x));
  });
  let result = line.slice();
  let changed = new Set();
  gaps.forEach((gap, i) => {
    let gapResult = solveGapWithHintList(line.slice(gap[0], gap[1]), distributionsPerGap[i]);
    gapResult.forEach((item, i) => {
      let before = result[gap[0] + i];
      if (before !== item) {
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
};

solve.speed = 'slow';

module.exports = {solveGap, solveGapWithHintList, solve};
