import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:gc_wizard/tools/games/nonogram/logic/strategy.dart';
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
    height = rowHints.length;
    width = columnHints.length;
    if (content != null) {
      _import(content);
    }
  }

  void solve() {
    var maxRecursionLevel = 0;
    Strategy().solve(this, maxRecursionLevel);
    if (!isSolved) {
      // Increasing the recursion depth value may dramatically slow down or speed up the solution process, depending on the puzzle.
      // It has no effect on puzzles that don't require trial and error
      maxRecursionLevel = 3;
      Strategy().solve(this, maxRecursionLevel);
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

  static void mapData(Puzzle data) {
    data.rowHints = _cleanClone(data.rowHints);
    data.columnHints = _cleanClone(data.columnHints);
    data.height = data.rowHints.length;
    data.width = data.columnHints.length;
    data.rows = generateRows(data);

    _checkConsistency(data);
  }

  static List<List<int>> _cleanClone(List<List<int>> hints) {
    return hints.map((h) {
      if (h.length == 1 && h[0] == 0) {
        return <int>[];
      }
      return h;
    }).toList();
  }

  static List<int> cleanHints(List<int> hints, int size) {
    for (var i = hints.length -1; i >= 0; i--) {
      if (hints[i] <= 0) {
        hints.removeAt(i);
      } else if (hints[i] > size) {
        hints[i] = size;
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
    return true;
  }

  bool get isSolved {
    if (!isFinished) return false;
    var ok = true;
    rows.forEachIndexed((i, column) => ok = _isOk(column, rowHints[i]));
    if (!ok) return false;
    columns.forEachIndexed((i, column) => ok = ok && _isOk(column, columnHints[i]));

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

  bool _import(List<int> snapshot) {
    if (snapshot.length != width * height) return false;
    rows.clear();
    for (int i = 0; i < height; i++) {
      rows.add(snapshot.sublist(i * width, (i + 1) * width));
    }
    return true;
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
    state = PuzzleState.Ok;
  }

  /// nonogram.org format (with 'rows' for row hints and 'columns' for column hints)
  static Puzzle parseJson(String jsonString) {
    const String jsonRows = 'rows';
    const String jsonColumns = 'columns';
    const String jsonContent = 'content'; //optional

    var puzzle = Puzzle.generate(0, 0);
    var jsonMap = asJsonMap(json.decode(jsonString));

    var data = asJsonArrayOrNull(jsonMap[jsonRows]);
    if (data != null) {
      puzzle.rowHints = _jsonArrayToArrayList(data);
    }

    data = asJsonArrayOrNull(jsonMap[jsonColumns]);
    if (data != null) {
      puzzle.columnHints = _jsonArrayToArrayList(data);
    }
    Puzzle.mapData(puzzle);

    data = asJsonArrayOrNull(jsonMap[jsonContent]);
    if (data != null) {
      puzzle._import(_jsonArrayToList(data));
    }

    return puzzle;
  }

  static List<List<int>> _jsonArrayToArrayList(List<Object?> jsonList) {
    var list = <List<int>>[];
    for (var entrys in jsonList) {
      var subList = asJsonArrayOrNull(entrys);
      if (subList != null) {
        list.add(_jsonArrayToList(subList));
      }
    }
    return list;
  }

  static List<int> _jsonArrayToList(List<Object?> jsonList) {
    var list = <int>[];
    for (var entry in jsonList) {
       var value = toIntOrNull(entry);
      if (value != null) list.add(value);
    }
    return list;
  }

  static void _checkConsistency(Puzzle data) {
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
