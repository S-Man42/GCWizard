import 'dart:core';
import 'dart:math';
import 'package:stack/stack.dart';

const MAXDISCCOUNT = 10;

int moveCount(int discCount) {
  if (discCount <= 0) return 0;
  return (2^discCount) - 1;
}

List<(String, int, int, int)> moves(int discCount) {
  var t = _towerOfHanoi(discCount);
  return t.towersOutput;
}

class _towerOfHanoi {
  final towersOutput = <(String, int, int, int)>[];
  final _towers = <Stack<int>> [ Stack<int>(), Stack<int>(), Stack<int>() ];
  final int _numdiscs;

  _towerOfHanoi(this._numdiscs) {
    if (moveCount(_numdiscs) <= 0) return;

    for (int i = _numdiscs; i > 0; i--) {
      _towers[0].push(i);
    }
    _movetower(_numdiscs, 1, 3, 2);
  }

  void _movetower(int n, int from, int to, int other) {
    if (n > 0) {
      _movetower(n - 1, from, other, to);
      _towers[to - 1].push(_towers[from - 1].pop());
      _addTowersOutput(n, from, to);
      // Console.WriteLine("Move disk {0} from tower {1} to tower {2}",
      //     n, from, to, _towers[to - 1].Peek().ToString());

      _movetower(n - 1, other, to, from);
    }
  }

  void _addTowersOutput(int n, int from, int to) {
    var output = '';
    int offset;
    var rowCount = max(_towers[0].length, max(_towers[1].length, _towers[2].length));

    for (int row = 0; row < rowCount; row++) {
      for (var tower = 0; tower < _towers.length; tower++) {
        offset = rowCount - _towers[tower].length;
        output += (row >= offset ? _towers[tower].toList()[_towers[tower].length - 1 - (row - offset)].toString() : "|").padLeft(tower == 0 ? 3 : 6);
      }
      output += "\n";
    }
    towersOutput.add((output.trimRight(), n, from, to));
  }
}