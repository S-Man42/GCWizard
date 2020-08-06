import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';

class BifidOutput {
  final String output;
  final String grid;

  BifidOutput(this.output, this.grid);
}

enum BifidAlphabetMode{JToI, CToK, WToVV}

String createBifidAlphabet(int gridDimension, {String firstLetters: '', PolybiosMode mode: PolybiosMode.AZ09, String fillAlphabet: '', BifidAlphabetMode alphabetMode}) {
  switch (alphabetMode) {
    case BifidAlphabetMode.JToI:
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
    case BifidAlphabetMode.CToK:
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
    case BifidAlphabetMode.WToVV:
      switch (mode) {
        case PolybiosMode.AZ09:
          if (gridDimension == 5)
            fillAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVXYZ';
          else
            fillAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
          break;
        case PolybiosMode.ZA90:
          if (gridDimension == 5)
            fillAlphabet = 'ZYXVUTSRQPONMLKJIHGFEDCBA';
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

BifidOutput encryptBifid (String input, String key, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet, BifidAlphabetMode alphabetMode}) {
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

  // check Input and correct it according to the chosen Alphabetmodification
  if (dim == 5) {
    switch (alphabetMode) {
      case BifidAlphabetMode.JToI:
        input = input.replaceAll('J', 'I');
        break;
      case BifidAlphabetMode.CToK:
        input = input.replaceAll('C', 'K');
        break;
      case BifidAlphabetMode.WToVV:
        input = input.replaceAll('W', 'VV');
        break;
      default:
        break;
    }
  }

  PolybiosOutput polybiosOutput = encryptPolybios(input, key, mode: PolybiosMode.CUSTOM, alphabet: alphabet);

  if (polybiosOutput == null)
    return null;

  var polybiosEncoded = polybiosOutput.output.replaceAll(' ', '');

  /// split output into two rows und build a new string with digits
  /// use this string as input for the decrypt-routine
    String row1 = '';
    String row2 = '';
    String helpInput = '';

    for (var i = 0; i < polybiosEncoded.length; i = i + 2) {
      row1 = row1 + polybiosEncoded.substring(i, i + 1);
      row2 = row2 + polybiosEncoded.substring(i + 1, i + 2);
    }
    helpInput = row1 + row2;

    polybiosOutput = decryptPolybios(helpInput, key, mode: PolybiosMode.CUSTOM, alphabet: alphabet);

  return BifidOutput(polybiosOutput.output,polybiosOutput.grid);
}

BifidOutput decryptBifid (String input, String key, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet, BifidAlphabetMode alphabetMode}) {
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

  // check Input and correct it according to the chosen Alphabetmodification
  if (dim == 5) {
    switch (alphabetMode) {
      case BifidAlphabetMode.JToI:
        input = input.replaceAll('J', 'I');
        break;
      case BifidAlphabetMode.CToK:
        input = input.replaceAll('C', 'K');
        break;
      case BifidAlphabetMode.WToVV:
        input = input.replaceAll('W', 'VV');
        break;
      default:
        break;
    }
  }

  PolybiosOutput polybiosOutput = encryptPolybios(input, key, mode: PolybiosMode.CUSTOM, alphabet: alphabet);

  if (polybiosOutput == null)
    return null;

  var polybiosEncoded = polybiosOutput.output.replaceAll(' ', '');

  /// split output into two rows und build a new string with digits
  /// use this string as input for the decrypt-routine
  String row1 = '';
  String row2 = '';
  String helpInput = '';

  row1 = polybiosEncoded.substring(0, polybiosEncoded.length ~/ 2);
  row2 = polybiosEncoded.substring(polybiosEncoded.length ~/ 2, polybiosEncoded.length);

  for (var i = 0; i < polybiosEncoded.length / 2; i = i + 1) {
    helpInput = helpInput + row1.substring(i, i + 1) + row2.substring(i, i + 1);
  }

  polybiosOutput = decryptPolybios(helpInput, key, mode: PolybiosMode.CUSTOM, alphabet: alphabet);

  return BifidOutput(polybiosOutput.output,polybiosOutput.grid);
}

