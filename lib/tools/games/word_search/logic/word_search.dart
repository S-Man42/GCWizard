import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';

const _emptyChar = '\t';

enum SearchDirection implements Comparable<SearchDirection> {
  HORIZONTAL(0),
  VERTICAL(1),
  DIAGONAL(2),
  REVERSE(4);

  const SearchDirection(this.value);

  final int value;

  bool hasFlag(SearchDirection flag) => value & flag.value != 0;
  int setFlag(SearchDirection flag) => value | flag.value;

  @override
  int compareTo(SearchDirection other) => value & other.value;
}

String _normalizeInput(String text){
  return text.replaceAll(RegExp(r'[\f\t ]'), '');
}

List<String> normalizeAndSplitInput(String text) {
  return const LineSplitter().convert(_normalizeInput(text));
}


List<String> _splitPair(String pair){
  List<String> result = [];
  String part = '';
  for (int i = 0; i < pair.length; i++) {
    if (int.tryParse(pair[i]) == null) {
      part = part + pair[i];
    }
  }
  result.add(part);
  result.add(pair.substring(part.length));
  return result;
}

List<String> _splitLines(String text){
  return const LineSplitter().convert(text);
}

List<Uint8List> searchWordList(String text, String wordList, SearchDirection searchDirection) {
  if (text.isEmpty) return [];

//print(text);
  text = _normalizeInput(text.toUpperCase());
  var wordLines = _splitLines(wordList.toUpperCase());
  //print(text);

  var result = _buildResultMatrix(text);
  if ((searchDirection.hasFlag(SearchDirection.HORIZONTAL)) ) {
    result = _combineResultMatrix(result, _searchHorizontal(text, wordLines) );
    if ((searchDirection.hasFlag(SearchDirection.REVERSE)) ) {
      result = _combineResultMatrix(result, _searchHorizontalReverse(text, wordLines) );
    }
  }
  if ((searchDirection.hasFlag(SearchDirection.VERTICAL)) ) {
    result = _combineResultMatrix(result, _searchVertical(text, wordLines) );
    if ((searchDirection.hasFlag(SearchDirection.REVERSE)) ) {
      result = _combineResultMatrix(result, _searchVerticalReverse(text, wordLines) );
    }
  }
  if ((searchDirection.hasFlag(SearchDirection.DIAGONAL)) ) {
    result = _combineResultMatrix(result, _searchDiagonal(text, wordLines) );
    if ((searchDirection.hasFlag(SearchDirection.REVERSE)) ) {
      result = _combineResultMatrix(result, _searchDiagonalReverse(text, wordLines) );
    }
  }
  return result;
}

List<Uint8List> _searchHorizontal(String text, List<String> wordList) {
  var matrix = _buildResultMatrix(text);
  var regex = RegExp('(' + wordList.join('|') + ')');

  _splitLines(text).forEachIndexed((index, line) {
    var matches = regex.allMatches(text);
    for (var match in matches) {
      matrix[index] = _setResults(matrix[index], match.start, match.end ,1);
    }
    matrix.add(Uint8List(line.length));
  });
  return matrix;
}

List<Uint8List> _searchHorizontalReverse(String text, List<String> wordList) {
  return _searchHorizontal(text, _reversedWordList(wordList));
}

List<Uint8List> _searchVertical(String text, List<String> wordList) {
  var lines = _splitLines(text);
  var maxRowLength = _maxRowLength(lines);
  var verticalText = List<String>.generate(maxRowLength, (index) => '');

  for (var line in lines) {
    if (line.length < maxRowLength) {
      for (var columnIndex = line.length; columnIndex < maxRowLength; columnIndex ++) {
        line += _emptyChar;
      }
    }
    line.split('').forEachIndexed((columnIndex, char) {
      verticalText[columnIndex] += char;
    });
  }

  var result = _searchHorizontal(verticalText.join('\n'), wordList);
  var matrix = _buildResultMatrix(text);

  lines.forEachIndexed((rowIndex, line) {
    line.split('').forEachIndexed((columnIndex, char) {
      matrix[rowIndex][columnIndex] = result[columnIndex][rowIndex];
    });
  });

  return matrix;
}

List<Uint8List> _searchVerticalReverse(String text, List<String> wordList) {
  return _searchVertical(text, _reversedWordList(wordList));
}

List<Uint8List> _searchDiagonal(String text, List<String> wordList) {
  var lines = _splitLines(text);
  int maxRowLength = _maxRowLength(lines);
  var diagonalText = List<String>.generate(_getVerticalRowIndex(lines.length, 0, maxRowLength), (index) => '');

  lines.forEachIndexed((rowIndex, line) {
    if (line.length < maxRowLength) {
      for (var columnIndex = line.length; columnIndex < maxRowLength; columnIndex ++) {
        line += _emptyChar;
      }
    }
    line.split('').forEachIndexed((columnIndex, char) {
      diagonalText[_getVerticalRowIndex(rowIndex, columnIndex, maxRowLength)] += char;
    });
  });

  var result = _searchHorizontal(diagonalText.join('\n'), wordList);
  var matrix = _buildResultMatrix(text);

  lines.forEachIndexed((rowIndex, line) {
    line.split('').forEachIndexed((columnIndex, char) {
      matrix[rowIndex][columnIndex] = result[_getVerticalRowIndex(rowIndex, columnIndex, maxRowLength)][rowIndex];
    });
  });

  return matrix;
}

List<Uint8List> _searchDiagonalReverse(String text, List<String> wordList) {
  return _searchDiagonal(text, _reversedWordList(wordList));
}

int _getVerticalRowIndex(int rowIndex, int columnIndex, int columnCount) {
  return columnIndex - rowIndex >= 0 ? columnIndex - rowIndex : columnCount - (columnIndex - rowIndex);
}

int _maxRowLength(List<String> lines) {
  int maxRowLength = 0;
  for (var line in lines) {
    maxRowLength = max(maxRowLength, line.length);
  }
  return maxRowLength;
}

List<String> _reversedWordList(List<String> wordList) {
  return wordList.map((word) => word.split('').reversed.join()).toList();
}

Uint8List _setResults(Uint8List line, int start, int end, int value ) {
  line.setRange(start, end, List<int>.generate(end-start, (index) => value));
  return line;
}

List<Uint8List> _combineResultMatrix(List<Uint8List> baseMatrix, List<Uint8List> newMatrix) {

  for (var row=0; row< min(baseMatrix.length, newMatrix.length); row++) {
    for (var column=0; row< min(baseMatrix[row].length, newMatrix[row].length); column++) {
      baseMatrix[row][column] = baseMatrix[row][column] | newMatrix[row][column];
    }
  }
  return baseMatrix;
}

List<Uint8List> _buildResultMatrix(String text) {
  var matrix = <Uint8List>[];

  _splitLines(text).forEach((line) {
    matrix.add(Uint8List(line.length));
  });
  return matrix;
}

// String encodeBattleship(String text, bool textmode, bool numberMode) {
//
//   if (text.isEmpty) return '';
//
//   List<String> result = [];
//
//   if (textmode) {
//     text = _convertTextToGraphic(text);
//   }
//
//   List<String> lines = text.split('\n');
//   for (int row = 0; row < lines.length; row++) {
//     for (int column = 0; column < lines[row].length; column++) {
//       if (lines[row][column] != ' ') {
//         if (numberMode) {
//           result.add((column + 1).toString() + ',' + (row + 1).toString());
//         } else {
//           result.add(_intToExcelMode(column + 1) + (row + 1).toString());
//         }
//       }
//     }
//   }
//
//   return result.join(' ');
// }
//
// String _convertTextToGraphic(String text){
//   List<String> result = [];
//
//   while (text.length > 10) {
//     result.add(_convertLineToGraphic(text.substring(0,10)));
//     result.add(_BATTLESHIP_EMPTY_LINE);
//     text = text.substring(10);
//   }
//   result.add(_convertLineToGraphic(text));
//   return result.join('\n');
// }
//
// String _convertLineToGraphic(String textLine){
//   List<String> result = [];
//   List<String> lines = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];
//
//   for (int i = 0; i < textLine.length; i++){
//     for (int j = 0; j < 9; j++){
//       lines[j] = lines[j] + _BATTLESHIP_ALPHABET[textLine[i]]![j] + ' ';
//     }
//   }
//   for (int j = 0; j < 9; j++){
//     result.add(lines[j]);
//   }
//
//   return result.join('\n');
// }