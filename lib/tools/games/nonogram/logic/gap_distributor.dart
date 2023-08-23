//const pushLeft = require('./solvers/pushSolver').pushLeft;

List<int> findGaps(List<int> line) {
  return line.reduce((result, el, i, line) {
    if (el > -1) {
      if (line[i - 1] > -1) {
        result[result.length - 1][1]++;
      }
    } else {
      result.push([i, i + 1]);
    }
  }
  return result;
    }, []);
}
let allWithOneGap = (List<int> line, List<int> gaps, List<int> hints) => {
  var left = gaps[0][0];
  var right = gaps[0][1];
  if (pushLeft(line.slice(left, right), hints)) {
    return {gaps, distributions: [[hints]]};
  }
  return null;
}

let gapDistributor = (List<int> line, List<int> hints) {
  var gaps = findGaps(line);
  if (gaps.length == 1) {
    return allWithOneGap(line, gaps, hints);
  }
  var distributions = [];
  var gap = gaps[0];
  for (var hintCount = 0; hintCount <= hints.length; hintCount++) {
    var first = allWithOneGap(line, [gap], hints.substring(0, hintCount));
    if (!first) {
      continue;
    }
    var second = gapDistributor(line.substring(gap[1]), hints.substring(hintCount));
    if (!second) {
      continue;
    }
    first.distributions.forEach((x) {
      x.forEach((e) {
        second.distributions.forEach((y) {
          let item = y.slice();
          item.unshift(e);
          distributions.push(item);
        });
      });
    });
  }
  return {gaps, distributions};
}

module.exports = gapDistributor;
