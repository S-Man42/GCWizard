import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/transposition.dart';
import 'package:gc_wizard/utils/common_utils.dart';

enum _ADFGVXMode { ADFGX, ADFGVX }

String encryptADFGX(String input, String substitutionKey, String transpositionKey,
    {PolybiosMode polybiosMode: PolybiosMode.ZA90, String alphabet}) {
  return _encrypt(input, substitutionKey, transpositionKey, _ADFGVXMode.ADFGX, polybiosMode, alphabet);
}

String encryptADFGVX(String input, String substitutionKey, String transpositionKey,
    {PolybiosMode polybiosMode: PolybiosMode.ZA90, String alphabet}) {
  return _encrypt(input, substitutionKey, transpositionKey, _ADFGVXMode.ADFGVX, polybiosMode, alphabet);
}

String _encrypt(String input, String substitutionKey, String transpositionKey, _ADFGVXMode mode,
    PolybiosMode polybiosMode, String alphabet) {
  if (input == null || input == '') return '';

  if (substitutionKey == null) substitutionKey = '';

  var adfgvxMode = mode.toString().split('.')[1]; //mode.toString() == _ADFGVX.ADFGX
  alphabet = createPolybiosAlphabet(adfgvxMode.length,
      firstLetters: substitutionKey, mode: polybiosMode, fillAlphabet: alphabet);
  if (alphabet == null) return null; // TODO: Exception

  PolybiosOutput polybiosOutput = encryptPolybios(input, adfgvxMode, mode: PolybiosMode.CUSTOM, fillAlphabet: alphabet);

  if (polybiosOutput == null) return null;

  var polybiosEncoded = polybiosOutput.output.replaceAll(' ', '');
  if (transpositionKey == null || transpositionKey == '') return insertSpaceEveryNthCharacter(polybiosEncoded, 5);

  transpositionKey = transpositionKey.toUpperCase();

  var matrix = createTranspositionMatrix(polybiosEncoded, TranspositionMatrixFillMode.encryption,
      countColumns: transpositionKey.length);

  var transpositionKeySorted = transpositionKey.split('');
  transpositionKeySorted.sort();

  var newIndexes = List<int>.generate(transpositionKey.length, (_) => -1);
  transpositionKey.split('').asMap().forEach((index, character) {
    var characterPosition = transpositionKeySorted.indexOf(character);
    transpositionKeySorted[characterPosition] = String.fromCharCode(0);
    newIndexes[characterPosition] = index;
  });

  String out = '';
  for (int i = 0; i < newIndexes.length; i++) {
    matrix[newIndexes[i]].where((character) => character != null).forEach((character) => out += character);
  }

  return insertSpaceEveryNthCharacter(out, 5);
}

String decryptADFGX(String input, String substitutionKey, String transpositionKey,
    {PolybiosMode polybiosMode: PolybiosMode.ZA90, String alphabet}) {
  return _decrypt(input, substitutionKey, transpositionKey, _ADFGVXMode.ADFGX, polybiosMode, alphabet);
}

String decryptADFGVX(String input, String substitutionKey, String transpositionKey,
    {PolybiosMode polybiosMode: PolybiosMode.ZA90, String alphabet}) {
  return _decrypt(input, substitutionKey, transpositionKey, _ADFGVXMode.ADFGVX, polybiosMode, alphabet);
}

String _decrypt(String input, String substitutionKey, String transpositionKey, _ADFGVXMode mode,
    PolybiosMode polybiosMode, String alphabet) {
  if (input == null || input == '') return '';

  input = input.toUpperCase().replaceAll(' ', '');

  var transposed;
  if (transpositionKey != null && transpositionKey != '') {
    transpositionKey = transpositionKey.toUpperCase();

    var transpositionKeySorted = transpositionKey.split('');
    transpositionKeySorted.sort();

    var newIndexes = List<int>.generate(transpositionKey.length, (_) => -1);
    transpositionKey.split('').asMap().forEach((index, character) {
      var characterPosition = transpositionKeySorted.indexOf(character);
      transpositionKeySorted[characterPosition] = String.fromCharCode(0);
      newIndexes[characterPosition] = index;
    });

    var countColumns = transpositionKey.length;
    var countRows = (input.length / transpositionKey.length).ceil();
    List<List<String>> matrix = List.generate(countColumns, (_) => List(countRows));

    int i = 0;
    newIndexes.forEach((index) {
      var maxRow = countRows;

      var fillColumn = false;
      if ((countRows - 1) * countColumns + index + 1 > input.length) {
        maxRow -= 1;
        fillColumn = true;
      }

      var chunk = input.substring(i, i + maxRow);
      if (fillColumn) chunk += String.fromCharCode(0);

      matrix[index] = chunk.split('');
      i += maxRow;
    });

    transposed = '';
    for (int i = 0; i < countRows; i++) {
      for (int j = 0; j < countColumns; j++) {
        if (matrix[j][i] != String.fromCharCode(0)) transposed += matrix[j][i];
      }
    }
  }

  if (transposed == null) transposed = input;

  if (substitutionKey == null) substitutionKey = '';

  var adfgvxMode = mode.toString().split('.')[1]; //mode.toString() == _ADFGVX.ADFGX
  alphabet = createPolybiosAlphabet(adfgvxMode.length,
      firstLetters: substitutionKey, mode: polybiosMode, fillAlphabet: alphabet);
  if (alphabet == null) return null; // TODO: Exception

  PolybiosOutput polybiosOutput =
      decryptPolybios(transposed, adfgvxMode, mode: PolybiosMode.CUSTOM, fillAlphabet: alphabet);

  if (polybiosOutput == null) return null;

  return polybiosOutput.output;
}
