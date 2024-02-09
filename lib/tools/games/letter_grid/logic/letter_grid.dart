// import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
// import 'package:gc_wizard/utils/data_type_utils/integer_type_utils.dart';

String _normalizeInput(String text){
  return text.replaceAll(RegExp(r'[\f\t ]'), '');
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

String searchWordList(String text, String wordList) {

  if (text.isEmpty) return '';

  bool absoluteError = false;
  bool rowsError = false;
  bool columnsError = false;
  int column = 0;
  int maxColumn = 0;
  int row = 0;
  int maxRow = 0;
  Map<String, String> world = {};
  String faultyTupel = '';
  String faultyColumnsTupel = '';
  String faultyRowsTupel = '';
  List<String> tupel = [];

  wordList = wordList.toUpperCase();
//print(text);
  text = _normalizeInput(text.toUpperCase());
  //print(text);

  var result = text.split('').map((char) => char == '\r' || char == '\n' ? char : char + ' ').join();
  return result;
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