//const clone = x => JSON.parse(JSON.stringify(x));

import 'package:collection/collection.dart';

int hintSum (List<int> hints) {
  return hints.reduceIndexed((i, x, y) => x + y + (i != 0 ? 1 : 0));
}

// const trimLine = (line, hints) => {
//   let minIndex = line.indexOf(0);
//   if (minIndex === -1) {
//     throw new Error('Cannot trim solved line');
//   }
//   if (line[minIndex - 1] === 1) {
//     minIndex--;
//   }
//   let clonedHints = hints.slice();
//   for (let i = 0; i < minIndex; i++) {
//     if (line[i] === 1) {
//       let start = i;
//       while (i < minIndex && line[i] === 1) {
//         i++;
//       }
//       if (i === minIndex) { // on the rim
//         clonedHints[0] -= i - start;
//         if (clonedHints[0] === 0) {
//           clonedHints[0] = 1;
//           minIndex -= 1;
//           break;
//         }
//       } else {
//         clonedHints.shift();
//       }
//     }
//   }
//   let maxIndex = line.lastIndexOf(0);
//   if (line[maxIndex + 1] === 1) {
//     maxIndex++;
//   }
//   for (let i = line.length; i > maxIndex; i--) {
//     if (line[i] === 1) {
//       let start = i;
//       while (i > maxIndex && line[i] === 1) {
//         i--;
//       }
//       if (i === maxIndex) { // on the rim
//         clonedHints[clonedHints.length - 1] -= start - i;
//         if (clonedHints[clonedHints.length - 1] === 0) {
//           clonedHints[clonedHints.length - 1] = 1;
//           maxIndex += 1;
//           break;
//         }
//       } else {
//         clonedHints.pop();
//       }
//     }
//   }
//   if (clonedHints.some(x => x < 0)) {
//     throw new Error(`Impossible line ${line}, ${hints}`);
//   }
//   return [line.slice(minIndex, maxIndex + 1), clonedHints, {left: line.slice(0, minIndex), right: line.slice(maxIndex + 1)}];
// };
//
// const restoreLine = (line, trimInfo) => trimInfo.left.concat(line).concat(trimInfo.right);
//
// const spinner = {
//   steps: ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'],
//   index: 0,
//   lastExecution: 0,
//   spin: function (stream = process.stderr) {
//     if (!stream) {
//       return;
//     }
//     let now = Date.now();
//     if (now - this.lastExecution < 42) {
//       return;
//     }
//     this.lastExecution = now;
//     stream.write('\x1b[1G');
//     stream.write(this.steps[this.index] + ' ');
//     this.index++;
//     if (this.index >= this.steps.length) {
//       this.index = 0;
//     }
//   }
// };
//
// module.exports = {
//   clone,
//   trimLine,
//   restoreLine,
//   spinner,
//   hintSum
// };
