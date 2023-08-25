// const assert = require('assert');
// const clone = require('./util').clone;
// const ascii = require('./serializers/ascii');
// const svg = require('./serializers/svg');
import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';

enum PuzzleState {
  Ok, // no data errors
  Finished, // has errors
  Solved,
  InvalidContentData, // data errors (no row or column hints)
  InvalidHintData // hint data errors
}

class Puzzle {
  var rowHints = <List<int>>[];
  var columnHints = <List<int>>[];
  int height = 0;
  int width = 0;
  var rows = <List<int>>[];
  PuzzleState state = PuzzleState.Ok;

  Puzzle(this.rowHints, this.columnHints, {List<int>? content}) {
    if (content != null) {
      import(content);
    }
  }

  static Puzzle generate(int height, int width) {
   var puzzle = Puzzle(List<List<int>>.generate(height, (index) => []),
                 List<List<int>>.generate(width, (index) => []));
   mapData(puzzle);
   return puzzle;
  }

  static List<List<int>> generateRows(Puzzle data) {
    return List<List<int>>.generate(data.height, (index) => List<int>.filled(data.width, 0));
  }

  // constructor(data) {
  //   if (typeof data === 'string') {
  //     data = JSON.parse(data);
  //   }
  //   let initialState = this.mapData(data);
  //   this.initAccessors(initialState);
  // }
  static void mapData(Puzzle data) {
    data.rowHints = cleanClone(data.rowHints);
    data.columnHints = cleanClone(data.columnHints);
    data.height = data.rowHints.length;
    data.width = data.columnHints.length;
    data.rows = generateRows(data);

    _checkConsistency(data);
  }

  static List<List<int>> cleanClone(List<List<int>> hints) {
    return hints.map((h) {
      if (h.length == 1 && h[0] == 0) {
        return <int>[];
      }
      return h;
    }).toList();
  }

  static List<int> cleanHints(List<int> hints, int size) {
    for (var h in hints) {
      if (h <= 0) {
        hints.remove(h);
      } else if (h > size) {
        h = size;
      }
    }
    return hints;
  }

  List<List<int>> get columns {
    var _columns = List<List<int>>.generate(width, (index) => List<int>.filled(height, 0));
    for(var x = 0; x < width; x++) {
      for(var y = 0; y < height; y++) {
        _columns[x][y] = rows[y][x];
      }
    }
    return _columns;
  }

  set columns (List<List<int>> newColumns) {
    for(var x = 0; x < width; x++) {
      for(var y = 0; y < height; y++) {
        rows[y][x] = newColumns[x][y];
      }
    }
  }


  bool get isFinished {
    for (var row in rows) {
      if (row.any((item) => item == 0)) return false;
    }
    state = PuzzleState.Finished;
    return true;
  }

  bool get isSolved {
    if (!isFinished) return false;
    var ok = true;
    rows.forEachIndexed((i, column) => ok = _isOk(column, rowHints[i]));
    if (!ok) return false;
    columns.forEachIndexed((i, column) => ok = ok && _isOk(column, columnHints[i]));

    if (ok) PuzzleState.Solved;
    return ok;
  }

  bool _isOk(List<int> line, List<int> hints) {
    var actual = line.join('').split(RegExp(r'(?:-1)+')).map((x) => x.length).where((x) => x > 0);
    if (actual.length == hints.length) {
      var ok = true;
      actual.forEachIndexed((i, x) => ok = ok && x == hints[i]);
      return ok;
    }
    return false;
  }

  List<int> get snapshot {
    var state = <int>[];

    for (var row in rows) {
      state.addAll(row);
    }

    return state;
  }

  void import(List<int> state) {
    rows.clear();
    for (int i = 0; i < height; i++) {
      rows.add(state.sublist(i * width, (i + 1) * width));
    }
  }

  void importHints(Puzzle puzzle) {
    for (var y = 0; y < min(puzzle.height, height); y++) {
      rowHints[y] = puzzle.rowHints[y];
    }
    for (var x = 0; x < min(puzzle.width, width); x++) {
      columnHints[x] = puzzle.columnHints[x];
    }
  }

  void removeCalculated() {
    rows = generateRows(this);
  }

  /// nonogram.org format (with 'rows' for row hints and 'columns' for column hints)
  static Puzzle parseJson(String jsonString) {
    const String jsonRows = 'rows';
    const String jsonColumns = 'columns';

    var puzzle = Puzzle.generate(0, 0);
    var jsonMap = asJsonMap(json.decode(jsonString));

    var data = asJsonArrayOrNull(jsonMap[jsonRows]);
    if (data != null) {
      puzzle.rowHints = _jsonArrayToList(data);
    }

    data = asJsonArrayOrNull(jsonMap[jsonColumns]);
    if (data != null) {
      puzzle.columnHints = _jsonArrayToList(data);
    }
    Puzzle.mapData(puzzle);

    return puzzle;
  }

  static List<List<int>> _jsonArrayToList(List<Object?> jsonList) {
    var list = <List<int>>[];
    for (var entrys in jsonList) {
      var sl = asJsonArrayOrNull(entrys);
      if (sl != null) {
        var subList = <int>[];
        for (var element in sl) {
          var value = toIntOrNull(element);
          if (value != null) subList.add(value);
        }
        list.add(subList);
      }
    }
    return list;
  }

  // void initAccessors(state) {
  //
  //   var rows = Array(height);
  //   var makeRow = (rowIndex) => {
  //   var row = Array(width).fill(0);
  //     row.forEach((_, colIndex) => {
  //       Object.defineProperty(row, colIndex, {
  //         get() {
  //           return state[rowIndex * width + colIndex];
  //         },
  //         set(el) {
  //           state[rowIndex * width + colIndex] = el;
  //         }
  //       });
  //     });
  //     return row;
  //   };
  //   for (var rowIndex = 0; rowIndex < height; rowIndex++) {
  //     var row = makeRow(rowIndex);
  //     Object.defineProperty(rows, rowIndex, {
  //       get() {
  //         return row;
  //       },
  //       set(newRow) {
  //         newRow.forEach((el, x) => state[rowIndex * width + x] = el);
  //       }
  //     });
  //   }
  //
  //   var columns = Array(width);
  //   var makeColumn = (colIndex) => {
  //     var column = Array(height).fill(0);
  //     column.forEach((_, rowIndex) => {
  //       Object.defineProperty(column, rowIndex, {
  //         get() {
  //           return state[rowIndex * width + colIndex];
  //         },
  //         set(el) {
  //           state[rowIndex * width + colIndex] = el;
  //         }
  //       });
  //     });
  //     return column;
  //   };
  //   for (var colIndex = 0; colIndex < width; colIndex++) {
  //     var column = makeColumn(colIndex);
  //     Object.defineProperty(columns, colIndex, {
  //       get() {
  //         return column;
  //       },
  //       set(newCol) {
  //         newCol.forEach((el, y) => state[y * width + colIndex] = el);
  //       }
  //     });
  //   }
  //
  //   Object.defineProperties(this, {
  //     rows: {
  //       get() {
  //         return rows;
  //       },
  //       set(newRows) {
  //         newRows.forEach((el, i) => {
  //           rows[i] = el;
  //         });
  //       }
  //     },
  //     columns: {
  //       get() {
  //         return columns;
  //       },
  //       set(cols) {
  //         cols.forEach((el, i) => {
  //           columns[i] = el;
  //         });
  //       }
  //     },
  //     isFinished: {
  //       get() {
  //         return state.every(item => item !== 0);
  //       }
  //     },
  //     snapshot: {
  //       get() {
  //         return clone(state);
  //       }
  //     },
  //     isSolved: {
  //       get() {
  //         let isOk = (line, hints) => {
  //           let actual = line.join('').split(/(?:-1)+/g).map(x => x.length).filter(x => x);
  //           return actual.length === hints.length && actual.every((x, i) => x === hints[i]);
  //         };
  //         return (
  //           this.isFinished &&
  //           columns.every((col, i) => isOk(col, this.columnHints[i])) &&
  //           rows.every((row, i) => isOk(row, this.rowHints[i]))
  //         );
  //       }
  //     }
  //   });
  //
  //   this.import = function(puzzle) {
  //     state = clone(puzzle.snapshot);
  //   };
  //
  //   this.toJSON = function() {
  //     return {
  //       columns: this.columnHints,
  //       rows: this.rowHints,
  //       content: state
  //     }
  //   };
  //
  // }

  static void _checkConsistency(Puzzle data) {
    // if (content) {
    //   var invalid = !content || !Array.isArray(content);
    //   invalid = invalid || (content.length != this.height * this.width);
    //   invalid = invalid || !content.every(i => i === -1 || i === 0 || i === 1);
    //   assert(!invalid, 'Invalid content data');
    // }

    if (data.rowHints.isEmpty || data.columnHints.isEmpty ||
        data.height == 0 || data.width == 0) {
      data.state = PuzzleState.InvalidContentData;
      return;
    }

    var rowSum = _sum(data.rowHints.map((l) => _sum(l)));
    var columnSum = _sum(data.columnHints.map((l) => _sum(l)));
    data.state = (rowSum == columnSum) ? PuzzleState.Ok : PuzzleState.InvalidHintData;
    return;
  }

  static int _sum(Iterable<int> list) {
    if (list.isEmpty) return 0;
    return list.reduce((x, y) => x + y);
  }
}
