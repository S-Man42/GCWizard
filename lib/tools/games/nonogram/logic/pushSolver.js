let shouldSkip = (line, hint, i) => {
  let allZeros = line[i - 1] === 0;
  let collision = line[i + hint] === 1;
  for (let x = i; x < i + hint; x++) {
    if (line[x] === -1 || x >= line.length) {
      collision = true;
      break;
    }
    if (line[x]) {
      allZeros = false;
    }
  }
  return allZeros || collision;
};

let pushLeft = (line, hints) => {
  if (hints.length === 0) {
    return line.includes(1) ? null : line;
  }
  let hint = hints[0];
  let maxIndex = line.indexOf(1);
  if (maxIndex === -1) {
    maxIndex = line.length - hint;
  }
  for (let i = 0; i <= maxIndex; i++) {
    if (shouldSkip(line, hint, i)) {
      continue;
    }
    let rest = pushLeft(line.slice(i + hint + 1), hints.slice(1));
    if (rest) {
      line = line.slice();
      for (let x = i; x < i + hint; x++) {
        line[x] = 1;
      }
      for (let x = 0; x < rest.length; x++) {
        line[x + i + hint + 1] = rest[x];
      }
      return line;
    }
  }
  return null;
};


let enumerate = (array) => {
  for (let i = 0, j = array[0] % 2; i < array.length; i++) {
    if (array[i] === -1) { array[i] = 0}
    if (array[i] % 2 !== j % 2) {
      j++;
    }
    array[i] = j;
  }
};

let solve = (line, hints) => {
  let leftmost = pushLeft(line, hints);
  if (!leftmost) {
    return null;
  }

  let reverseLine = line.slice().reverse();
  let reverseHints = hints.slice().reverse();
  let rightmost = pushLeft(reverseLine, reverseHints).reverse();

  enumerate(leftmost);
  enumerate(rightmost);

  return leftmost.map((el, i) => {
    if (el === rightmost[i]) {
      return (el % 2) ? 1 : -1;
    }
    return line[i];
  });
};

solve.speed = 'fast';

module.exports = {solve, pushLeft};
