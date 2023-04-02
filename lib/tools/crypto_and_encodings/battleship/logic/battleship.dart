import 'package:gc_wizard/utils/data_type_utils/integer_type_utils.dart';

part 'package:gc_wizard/tools/crypto_and_encodings/battleship/logic/battleship_data.dart';

String decodeBattleship(String text) {
  bool localError = false;
  bool absoluteError = false;
  int column = 0;
  int maxColumn = 0;
  int row = 0;
  int maxRow = 0;
  Map<String, String> world = {};

  text.split(', ').forEach((pair) {
    List<String> tupel = pair.split(' ');
    if (tupel.length != 2) {
      localError = true;
    } else {
      if (isInteger(tupel[0])) {
        column = int.parse(tupel[0]);
      } else {
        localError = true;
      }
      if (isInteger(tupel[1])) {
        row = int.parse(tupel[1]);
      } else {
        localError = true;
      }
      if (!localError) {
        if (column > maxColumn) maxColumn = column;
        if (row > maxRow) maxRow = row;
        world[tupel[0] + '|' + tupel[1]] = '#';
      } else {
        absoluteError = true;
        localError = false;
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
    return BATTLESHIP_ERROR_INVALID_PAIR + output.join('\n');
  } else {
    return output.join('\n');
  }
}

String encodeBattleship(String text, bool textmode) {
  List<String> result = [];

  if (textmode) {
    text = _convertTextToGraphic(text.toUpperCase());
  }

  List<String> lines = text.split('\n');
  for (int row = 0; row < lines.length; row++) {
    for (int column = 0; column < lines[row].length; column++) {
      if (lines[row][column] != ' ') {
        result.add((column + 1).toString() + ' ' + (row + 1).toString());
      }
    }
  }

  return result.join(', ');
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
  List<String> lines = [' ', ' ', ' ', ' ', ' ', ' ', ' '];

  for (int i = 0; i < textLine.length; i++){
    for (int j = 0; j < 7; j++){
      lines[j] = lines[j] + BATTLESHIP_ALPHABET[textLine[i]]![j] + ' ';
    }
  }
  for (int j = 0; j < 7; j++){
    result.add(lines[j]);
  }

  return result.join('\n');
}