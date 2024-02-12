// import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
// import 'package:gc_wizard/utils/data_type_utils/integer_type_utils.dart';

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:collection/collection.dart';

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

List<Uint8List> searchWordList(String text, String wordList) {

  if (text.isEmpty) return [];

  wordList = wordList.toUpperCase();
//print(text);
  text = _normalizeInput(text.toUpperCase());
  //print(text);

  var result = text.split('').map((char) => char == '\r' || char == '\n' ? char : char + ' ').join();
  return _searchHorizontal(text, const LineSplitter().convert(wordList));
}

List<Uint8List> _searchHorizontal(String text, List<String> wordList) {
  var matrix = _buildResultMatrix(text);
  var regex = RegExp('[' + wordList.join('|') + ']');

  const LineSplitter().convert(text).forEachIndexed((index, line) {
    var matches = regex.allMatches(text);
    for (var match in matches) {
      matrix[index] = _setResults(matrix[index], match.group(0)., match.end ,1);
    }
    matrix.add(Uint8List(line.length));
  });
  return matrix;
}

List<Uint8List> _searchHorizontalReverse(String text, List<String> wordList) {
  var reverseWordList = wordList.map((word) => word.split('').reversed.join()).toList();

  return _searchHorizontal(text, reverseWordList);
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

  const LineSplitter().convert(text).forEach((line) {
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