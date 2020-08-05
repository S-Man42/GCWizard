import 'dart:math';

import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

enum BifidMode{AZ09, ZA90, CUSTOM}

class BifidOutput {
  final String output;
  final String grid;

  BifidOutput(this.output, this.grid);
}

String _sanitizeAlphabet(String alphabet) {
  if (alphabet == null || alphabet == '')
    return '';

  alphabet += alphabet_AZ.keys.join();
  alphabet += alphabet_09.keys.join();

  alphabet = alphabet.toUpperCase().replaceAll(' ', '');

    //remove doubles letters
  return alphabet.split('').toSet().join();
}

String createBifidAlphabet(int gridDimension, {String firstLetters: '', BifidMode mode: BifidMode.AZ09, String fillAlphabet: '', GCWSwitchPosition alphabetMode}) {

  switch (gridDimension)  {
    case 5:
      switch (mode) {
        case BifidMode.AZ09:
          if (alphabetMode == GCWSwitchPosition.left) {  /// J -> I
            fillAlphabet = alphabet_AZ.keys.map((key) => key == 'J' ? '' : key).join();
          } else {  /// C -> K
            fillAlphabet = alphabet_AZ.keys.map((key) => key == 'C' ? '' : key).join();
          }
          break;
        case BifidMode.ZA90:
          if (alphabetMode == GCWSwitchPosition.left) {  /// J -> I
            fillAlphabet = alphabet_AZ.keys.map((key) => key == 'J' ? '' : key).toList().reversed.join();
          } else {  /// C -> K
            fillAlphabet = alphabet_AZ.keys.map((key) => key == 'C' ? '' : key).toList().reversed.join();
          }
          break;
        default: break;
      }
      break;
    case 6:
      var alphabetAZ = alphabet_AZ.keys.toList();

      switch (mode) {
        // ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
        case BifidMode.AZ09:
          alphabetAZ.addAll(alphabet_09.keys);
          fillAlphabet = alphabetAZ.join();
          break;
        // ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210
        case BifidMode.ZA90:
          alphabetAZ = alphabetAZ.reversed.toList();
          alphabetAZ.addAll(alphabet_09.keys.toList().reversed);
          fillAlphabet = alphabetAZ.join();
          break;
        default: break;
      }
      break;
    default: return null;
  }

  if (firstLetters == null)
    firstLetters = '';

  if (fillAlphabet == null)
    fillAlphabet = '';

  var alphabet = _sanitizeAlphabet(firstLetters + fillAlphabet);

  if (alphabet.length < gridDimension * gridDimension)
    return null; //TODO Exception

  return alphabet.substring(0, gridDimension * gridDimension);
}

// Returns for example
// {
//    'A' : [0, 0], 'B' : [0, 1], 'C' : [0, 2], 'D' : [0, 3], 'E' : [0, 4],
//    'F' : [1, 0], 'G' : [1, 1], 'H' : [1, 2], 'I' : [1, 3], 'K' : [1, 4],
//    'L' : [2, 0], 'M' : [2, 1], 'N' : [2, 2], 'O' : [2, 3], 'P' : [2, 4],
//    'Q' : [3, 0], 'R' : [3, 1], 'S' : [3, 2], 'T' : [3, 3], 'U' : [3, 4],
//    'V' : [4, 0], 'W' : [4, 1], 'X' : [4, 2], 'Y' : [4, 3], 'Z' : [4, 4],
// }

Map<String, List<int>> createBifidGrid(String input, int dimension) {
  var grid = Map<String, List<int>>();

  input = input.substring(0, min(input.length, dimension * dimension));

  for (int i = 0; i < input.length; i++) {
    grid.putIfAbsent(input[i], () => [i ~/ dimension, i % dimension]);
  }

  return grid;
}

String BifidGridCharacterByCoordinate(Map<String, List<int>> grid, int row, int column) {
  return grid
    .entries
    .firstWhere((entry) => entry.value[0] == row && entry.value[1] == column)
    .key;
}

BifidOutput encryptBifid (String input, String key, {BifidMode mode: BifidMode.AZ09, String alphabet, GCWSwitchPosition alphabetMode}) {
  if (input == null || key == null)
    return null; //TODO Exception

  int dim = key.length;
  if (dim != 5 && dim != 6)
    return null; //TODO Exception

  alphabet = createBifidAlphabet(dim, mode: mode, fillAlphabet: alphabet, alphabetMode: alphabetMode);
  if (alphabet == null)
    return null; //TODO Exception

  key = key.toUpperCase();
  input = input.toUpperCase();

  if (alphabetMode == GCWSwitchPosition.left) {  /// J->I
    if (!alphabet.contains('J'))
      input = input.replaceAll('J', 'I');
  } else {                                       /// C->K
    if (!alphabet.contains('C'))
      input = input.replaceAll('C', 'K');
  }

  Map<String, List<int>> grid = createBifidGrid(alphabet, dim);

  if (grid == null)
    return null;

  var output = input
    .split('')
    .where((character) => alphabet.contains(character))
    .map((character) {
      var coords = grid[character];
      if (coords == null)
        return '';

      return '${key[coords[0]]}${key[coords[1]]}';
    })
    .join(' ');

  /// output zerlegen und neu zusammensetzen
  /// ergibt zwischenInput für decrypt
    String zeile1 = '';
    String zeile2 = '';
    String zwischenInput = '';

    output = output.replaceAll(' ', '');

    for (var i = 0; i < output.length; i = i + 2) {
      zeile1 = zeile1 + output.substring(i, i+1);
      zeile2 = zeile2 + output.substring(i+1, i+2);
    }
    zwischenInput = zeile1 + zeile2;

    output = zwischenDecryptBifid (zwischenInput, key, mode: BifidMode.AZ09,  alphabet: alphabet,  alphabetMode: alphabetMode).output;
         /// decryptBifid(_currentInput, _currentKey, mode: _currentBifidMode, alphabet: _currentAlphabet, alphabetMode: _currentAlphabetMode);
  return BifidOutput(output, BifidGridToString(grid, key));
}

BifidOutput decryptBifid (String input, String key, {BifidMode mode: BifidMode.AZ09, String alphabet, GCWSwitchPosition alphabetMode}) {
  if (input == null || key == null)
    return null; //TODO Exception

  int dim = key.length;
  if (dim != 5 && dim != 6)
    return null; //TODO Exception

  alphabet = createBifidAlphabet(dim, mode: mode, fillAlphabet: alphabet, alphabetMode: alphabetMode);
  if (alphabet == null)
    return null; //TODO Exception

  key = key.toUpperCase();
  input = input.toUpperCase();

  if (alphabetMode == GCWSwitchPosition.left) {  /// J->I
    if (!alphabet.contains('J'))
      input = input.replaceAll('J', 'I');
  } else {                                       /// C->K
    if (!alphabet.contains('C'))
      input = input.replaceAll('C', 'K');
  }

  Map<String, List<int>> grid = createBifidGrid(alphabet, dim);

  if (grid == null)
    return null;

  var output = input
      .split('')
      .where((character) => alphabet.contains(character))
      .map((character) {
    var coords = grid[character];
    if (coords == null)
      return '';

    return '${key[coords[0]]}${key[coords[1]]}';
  })
      .join(' ');

  /// output zerlegen und neu zusammensetzen
  /// ergibt zwischenInput für decrypt
  String zeile1 = '';
  String zeile2 = '';
  String zwischenInput = '';

  output = output.replaceAll(' ', '');

  zeile1 = output.substring(0,output.length~/2);
  zeile2 = output.substring(output.length~/2,output.length);

  for (var i = 0; i < output.length/2; i = i + 1) {
    zwischenInput = zwischenInput + zeile1.substring(i, i+1) + zeile2.substring(i, i+1);
  }

  output = zwischenDecryptBifid (zwischenInput, key, mode: BifidMode.AZ09,  alphabet: alphabet,  alphabetMode: alphabetMode).output;
  /// decryptBifid(_currentInput, _currentKey, mode: _currentBifidMode, alphabet: _currentAlphabet, alphabetMode: _currentAlphabetMode);

  return BifidOutput(output, BifidGridToString(grid, key));
}

BifidOutput zwischenDecryptBifid (String input, String key, {BifidMode mode: BifidMode.AZ09, String alphabet, GCWSwitchPosition alphabetMode}) {
  if (input == null || key == null)
    return null; //TODO Exception

  int dim = key.length;
  if (dim != 5 && dim != 6)
    return null; //TODO Exception

  alphabet = createBifidAlphabet(dim, mode: mode, fillAlphabet: alphabet, alphabetMode: alphabetMode);
  if (alphabet == null)
    return null;

  key = key.toUpperCase();
  input = input
      .split('')
      .map((character) => key.contains(character) ? character : '')
      .join();

  if (input.length % 2 != 0)
    input = input.substring(0, input.length - 1);

  if (input.length == 0)
    return null; //TODO: Exception

  var grid = createBifidGrid(alphabet, dim);

  if (grid == null)
    return null;

  String out = '';

  int i = 0;
  while (i < input.length - 1) {
    var x = key.indexOf(input[i]);
    var y = key.indexOf(input[i + 1]);

    out += BifidGridCharacterByCoordinate(grid, x, y);
    i += 2;
  }

  return BifidOutput(out, BifidGridToString(grid, key));
}

String BifidGridToString(Map<String, List<int>> grid, String key) {
  var currentRow = -1;
  var output = '  | ' + key.split('').join(' ');
  output += '\n--+' + '-' * key.length * 2;

  grid.entries.forEach((entry) {
    if (entry.value[0] > currentRow) {
      currentRow++;
      output += '\n' + key[currentRow] + ' |';
    }
    output += ' ' + entry.key;
  });

  return output;
}