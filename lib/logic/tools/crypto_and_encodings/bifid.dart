import 'dart:math';

import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';

class BifidOutput {
  final String output;
  final String grid;

  BifidOutput(this.output, this.grid);
}

String createBifidAlphabet(int gridDimension, {String firstLetters: '', PolybiosMode mode: PolybiosMode.AZ09, String fillAlphabet: '', GCWSwitchPosition alphabetMode}) {
  switch (alphabetMode) {
    case GCWSwitchPosition.left: // J->I
      switch (mode) {
        case PolybiosMode.AZ09:
          if (gridDimension==5)
            fillAlphabet = 'ABCDEFGHIKLMNOPQRSTUVWXYZ';
          else
            fillAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
          break;
        case PolybiosMode.ZA90:
          if (gridDimension==5)
            fillAlphabet = 'ZYXWVUTSRQPONMLKIHGFEDCBA';
          else
            fillAlphabet = 'ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210';
          break;
        default: break;
      }
      break;
    case GCWSwitchPosition.right: // C->K
      switch (mode) {
        case PolybiosMode.AZ09:
          if (gridDimension == 5)
            fillAlphabet = 'ABDEFGHIJKLMNOPQRSTUVWXYZ';
          else
            fillAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
          break;
        case PolybiosMode.ZA90:
          if (gridDimension == 5)
            fillAlphabet = 'ZYXWVUTSRQPONMLKJIHGFEDBA';
          else
            fillAlphabet = 'ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210';
          break;
        default: break;
      }
      break;
  }
  mode = PolybiosMode.CUSTOM;
  fillAlphabet = createPolybiosAlphabet(gridDimension, firstLetters: '', mode: mode, fillAlphabet: fillAlphabet);
  return fillAlphabet;
}

BifidOutput encryptBifid (String input, String key, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet, GCWSwitchPosition alphabetMode}) {
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

  Map<String, List<int>> grid = createPolybiosGrid(alphabet, dim);

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

  /// split output into two rows und build a new string with digits
  /// use this string as input for the decrypt-routine
    String row1 = '';
    String row2 = '';
    String helpInput = '';

    output = output.replaceAll(' ', '');

    for (var i = 0; i < output.length; i = i + 2) {
      row1 = row1 + output.substring(i, i+1);
      row2 = row2 + output.substring(i+1, i+2);
    }
    helpInput = row1 + row2;

    output = helpDecryptBifid (helpInput, key, mode: mode,  alphabet: alphabet,  alphabetMode: alphabetMode).output;

  return BifidOutput(output, polybiosGridToString(grid, key));

}

BifidOutput decryptBifid (String input, String key, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet, GCWSwitchPosition alphabetMode}) {
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

  Map<String, List<int>> grid = createPolybiosGrid(alphabet, dim);

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

  String row1 = '';
  String row2 = '';
  String helpInput = '';

  output = output.replaceAll(' ', '');

  row1 = output.substring(0,output.length~/2);
  row2 = output.substring(output.length~/2,output.length);

  for (var i = 0; i < output.length/2; i = i + 1) {
    helpInput = helpInput + row1.substring(i, i+1) + row2.substring(i, i+1);
  }

  output = helpDecryptBifid (helpInput, key, mode: PolybiosMode.AZ09,  alphabet: alphabet,  alphabetMode: alphabetMode).output;

  return BifidOutput(output, polybiosGridToString(grid, key));
}

BifidOutput helpDecryptBifid (String input, String key, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet, GCWSwitchPosition alphabetMode}) {
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

  var grid = createPolybiosGrid(alphabet, dim);

  if (grid == null)
    return null;

  String out = '';

  int i = 0;
  while (i < input.length - 1) {
    var x = key.indexOf(input[i]);
    var y = key.indexOf(input[i + 1]);

    out += polybiosGridCharacterByCoordinate(grid, x, y);
    i += 2;
  }

  return BifidOutput(out, polybiosGridToString(grid, key));
}

