import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';

const _emptyChar = '\t';

enum SearchDirectionFlags { //} implements Comparable<SearchDirection> {
  HORIZONTAL,
  VERTICAL,
  DIAGONAL,
  REVERSE;

  static bool hasFlag(int value, SearchDirectionFlags flag) {
    return value & (1 << flag.index) != 0;
  }

  static int setFlag(int value, SearchDirectionFlags flag) {
    return value | (1 << flag.index);
  }
  static int resetFlag(int value, SearchDirectionFlags flag) {
    return value & ~(1 << flag.index);
  }
}

String _normalizeInput(String text){
  return text.replaceAll(RegExp(r'[\f\t ]'), '');
}

List<String> normalizeAndSplitInput(String text) {
  return const LineSplitter().convert(_normalizeInput(text));
}

List<String> _splitLines(String text){
  return const LineSplitter().convert(text);
}

List<Uint8List> searchWordList(String text, String wordList, int searchDirection) {
  if (text.isEmpty) return [];

  text = _normalizeInput(text.toUpperCase());
  wordList = wordList.replaceAll(RegExp(r'\s'), '\n');
  var wordLines = _splitLines(wordList.toUpperCase());
  wordLines.removeWhere((line) => line.isEmpty);

  var result = _buildResultMatrix(text);
  if ((SearchDirectionFlags.hasFlag(searchDirection, SearchDirectionFlags.HORIZONTAL)) ) {
    result = _combineResultMatrix(result, _searchHorizontal(text, wordLines) );
    if ((SearchDirectionFlags.hasFlag(searchDirection,SearchDirectionFlags.REVERSE)) ) {
      result = _combineResultMatrix(result, _searchHorizontalReverse(text, wordLines) );
    }
  }
  if ((SearchDirectionFlags.hasFlag(searchDirection,SearchDirectionFlags.VERTICAL)) ) {
    result = _combineResultMatrix(result, _searchVertical(text, wordLines) );
    if ((SearchDirectionFlags.hasFlag(searchDirection,SearchDirectionFlags.REVERSE)) ) {
      result = _combineResultMatrix(result, _searchVerticalReverse(text, wordLines) );
    }
  }
  if ((SearchDirectionFlags.hasFlag(searchDirection,SearchDirectionFlags.DIAGONAL)) ) {
    result = _combineResultMatrix(result, _searchDiagonal(text, wordLines) );
    if ((SearchDirectionFlags.hasFlag(searchDirection,SearchDirectionFlags.REVERSE)) ) {
      result = _combineResultMatrix(result, _searchDiagonalReverse(text, wordLines) );
    }
  }
  return result;
}

List<Uint8List> _searchWords(String text, List<String> wordList, int id) {
  var matrix = _buildResultMatrix(text);
  var regex = RegExp('(' + wordList.join('|') + ')');

  _splitLines(text).forEachIndexed((index, line) {
    var matches = regex.allMatches(line);
    for (var match in matches) {
      matrix[index] = _setResults(matrix[index], match.start, match.end , id);
    }
    //matrix.add(Uint8List(line.length));
  });
  return matrix;
}

List<Uint8List> _searchHorizontal(String text, List<String> wordList) {
  return _searchWords(text, wordList, SearchDirectionFlags.setFlag(0, SearchDirectionFlags.HORIZONTAL));
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

  var result = _searchWords(verticalText.join('\n'), wordList, SearchDirectionFlags.setFlag(0, SearchDirectionFlags.VERTICAL));
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
  var diagonalText = List<String>.generate(_getDiagonalRowIndex(lines.length, 0, maxRowLength), (index) => '');

  lines.forEachIndexed((rowIndex, line) {
    if (line.length < maxRowLength) {
      for (var columnIndex = line.length; columnIndex < maxRowLength; columnIndex ++) {
        line += _emptyChar;
      }
    }
    line.split('').forEachIndexed((columnIndex, char) {
      diagonalText[_getDiagonalRowIndex(rowIndex, columnIndex, maxRowLength)] += char;
    });
  });

  var result = _searchWords(diagonalText.join('\n'), wordList, SearchDirectionFlags.setFlag(0, SearchDirectionFlags.DIAGONAL));
  var matrix = _buildResultMatrix(text);

  // lines.forEachIndexed((rowIndex, line) {
  //   line.split('').forEachIndexed((columnIndex, char) {
  //     matrix[rowIndex][columnIndex] = result[_getVerticalRowIndex(rowIndex, columnIndex, maxRowLength)][rowIndex];
  //   });
  // });

  return matrix;
}

List<Uint8List> _searchDiagonalReverse(String text, List<String> wordList) {
  return _searchDiagonal(text, _reversedWordList(wordList));
}

int _getDiagonalRowIndex(int rowIndex, int columnIndex, int columnCount) {
  return columnIndex - rowIndex >= 0 ? columnIndex - rowIndex : columnCount - (columnIndex - rowIndex);
}

int _getDiagonalColumnIndex(int rowIndex, int columnIndex, int columnCount) {
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
    for (var column=0; column< min(baseMatrix[row].length, newMatrix[row].length); column++) {
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