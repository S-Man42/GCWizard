import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/data_type_utils/integer_type_utils.dart';

part 'package:gc_wizard/tools/crypto_and_encodings/battleship/logic/battleship_data.dart';

String _normalizeInput(String text){
  return text.replaceAll(RegExp(r'\s*,\s*'), ',');
}

int _excelModeToInt(String excelNumber){
  int result = -1;

  for (int i = 0; i < excelNumber.length; i++) {
    if (int.tryParse(excelNumber[i]) != null) {
      return -1;
    } else {
      if (i == 0) {
        result = (excelNumber.codeUnitAt(i) - 64);
      } else {
        result = result * 26 + (excelNumber.codeUnitAt(1) - 64);
      }
    }
  }
  return result;
}

String _intToExcelMode(int number){
  if (number < 27) {
    return String.fromCharCode(number + 64);
  } else {
    return String.fromCharCode(number ~/ 26 + 64) + String.fromCharCode(number % 26 + 64);
  }
}

String decodeBattleship(String text, bool numberMode) {
  bool absoluteError = false;
  int column = 0;
  int maxColumn = 0;
  int row = 0;
  int maxRow = 0;
  Map<String, String> world = {};
  String faultyTupel = '';

  _normalizeInput(text.toUpperCase()).split(' ').forEach((pair) {
    List<String> tupel = pair.split(',');
    if (tupel.length != 2) {

      absoluteError = true;
    } else {
      if (isInteger(tupel[0])) {
         column = int.parse(tupel[0]);
      } else {
        if (numberMode) {
          column = int.parse(convertBase(tupel[0], 36, 10).trim());
        } else {
          column = _excelModeToInt(tupel[0]);
          if (column == -1){
            faultyTupel = tupel[0];
            absoluteError = true;
          }
        }
      }
      if (isInteger(tupel[1])) {
        row = int.parse(tupel[1]);
      } else {
        row = int.parse(convertBase(tupel[1], 36, 10));
      }

      if (!absoluteError) {
        if (column > maxColumn) maxColumn = column;
        if (row > maxRow) maxRow = row;
        world[column.toString() + '|' + row.toString()] = '#';
      }
    }
  });

  List<List<String>> binaryWorld = List.generate(maxColumn, (y) => List.generate(maxRow, (x) => ' ', growable: false), growable: false);
  world.forEach((key, value) {
    column = int.parse(key.split('|')[0]) - 1;
    row = int.parse(key.split('|')[1]) - 1;
    binaryWorld[column][row] = value;
  });

  String outputLine = '';
  List<String> output = [];
  for (int y = 0; y < maxRow; y++) {
    outputLine = '';
    for (int x = 0; x < maxColumn; x++) {
        outputLine = outputLine + binaryWorld[x][y];
    }
    output.add(outputLine);
  }
  if (absoluteError) {
    return BATTLESHIP_ERROR_INVALID_PAIR + faultyTupel + '\n\n' + output.join('\n');
  } else {
    return output.join('\n');
  }
}

String encodeBattleship(String text, bool textmode, bool numberMode) {
  List<String> result = [];

  if (textmode) {
    text = _convertTextToGraphic(text);
  }

  List<String> lines = text.split('\n');
  for (int row = 0; row < lines.length; row++) {
    for (int column = 0; column < lines[row].length; column++) {
      if (lines[row][column] != ' ') {
        if (numberMode) {
          result.add((column + 1).toString() + ',' + (row + 1).toString());
        } else {
          result.add(_intToExcelMode(column + 1) + ',' + (row + 1).toString());
        }
      }
    }
  }

  return result.join(' ');
}

String _convertTextToGraphic(String text){
  List<String> result = [];

  while (text.length > 10) {
    result.add(_convertLineToGraphic(text.substring(0,10)));
    result.add(BATTLESHIP_EMPTY_LINE);
    text = text.substring(10);
  }
  result.add(_convertLineToGraphic(text));
  return result.join('\n');
}

String _convertLineToGraphic(String textLine){
  List<String> result = [];
  List<String> lines = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];

  for (int i = 0; i < textLine.length; i++){
    for (int j = 0; j < 9; j++){
      lines[j] = lines[j] + BATTLESHIP_ALPHABET[textLine[i]]![j] + ' ';
    }
  }
  for (int j = 0; j < 9; j++){
    result.add(lines[j]);
  }

  return result.join('\n');
}