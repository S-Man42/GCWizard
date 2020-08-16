//
// https://web.archive.org/web/20071011164305/http://en.wikipedia.org/wiki/Gray_code

import 'dart:math';

class GrayOutput {
  final String state;
  final String output_plain;
  final String output_gray_decimal;
  final String output_gray_binary;

  GrayOutput(this.state, this.output_plain, this.output_gray_decimal, this.output_gray_binary);
}

enum GrayMode{Decimal, Binary}


String buildDecimalStringFromBinaryString(String input){
  int output = 0;
  int position = 1;

  for (int i = (input.length - 1); i >= 0; i--) {

    if (input[i] == '1')
      output = output + position;
    position = position * 2;
  }
  return output.toString();
}


int getMaxPossibleInt(int digits) {
  return pow(2, digits) - 1;
}


GrayOutput encryptGray (String input, {GrayMode mode: GrayMode.Decimal}) {
  if (input == null)
    //return null; //TODO Exception
    return GrayOutput('ERROR', 'gray_error_no_encrypt_input', null, null);

  String inputPlainBinary = '';
  String inputPlainDecimal = '';
  String outputGrayDecimal = '';
  String outputGrayBinary = '';

  int inputIntPlain = 0;
  int outputIntGray = 0;

  if (mode == GrayMode.Decimal) {
    inputIntPlain = int.parse(input);
    inputPlainBinary = int.parse(input).toRadixString(2);
    inputPlainDecimal = input;
  } else {
    inputPlainBinary = input;
    inputIntPlain = int.parse(buildDecimalStringFromBinaryString(inputPlainBinary));
    inputPlainDecimal = inputIntPlain.toString();
  }

  outputIntGray = inputIntPlain ^ (inputIntPlain >> 1);
  outputGrayDecimal = outputIntGray.toString();
  outputGrayBinary = outputIntGray.toRadixString(2);

  if (mode == GrayMode.Decimal)
    return GrayOutput('OK', inputPlainBinary, outputGrayDecimal, outputGrayBinary);
  else
    return GrayOutput('OK', inputPlainDecimal, outputGrayDecimal, outputGrayBinary);
}


GrayOutput decryptGray (String input, {GrayMode mode: GrayMode.Decimal}) {
  if (input == null)
    //return null; //TODO Exception
    return GrayOutput('ERROR', 'gray_error_no_decrypt_input', null, null);

  int plainDecimal = 0;

  String outBinaryGray = '';
  String outBinaryPlain = '';
  String outDecimalGray = '';
  String outDecimalPlain = '';

  if (mode == GrayMode.Decimal) {
    outDecimalGray = input;
    outBinaryGray = int.parse(outDecimalGray).toRadixString(2);
  } else {
    outBinaryGray = input;
    outDecimalGray = buildDecimalStringFromBinaryString(outBinaryGray);
  }

  plainDecimal = getMaxPossibleInt(outBinaryGray.length) * int.parse(outBinaryGray[0]);
  bool firstOne = true;
  for (int i = 1; i < (outBinaryGray.length); i++) {
      if (outBinaryGray[i] == '1') {
        if (firstOne) {
          firstOne = false;
          plainDecimal = plainDecimal - getMaxPossibleInt(outBinaryGray.length - i) * int.parse(outBinaryGray[i]);
        } else {
          plainDecimal = plainDecimal + getMaxPossibleInt(outBinaryGray.length - i) * int.parse(outBinaryGray[i]);
        }
      }
  }

  outDecimalPlain = plainDecimal.toString();
  outBinaryPlain = plainDecimal.toRadixString(2);

  if (mode == GrayMode.Decimal)
    return GrayOutput('OK', outBinaryGray, outDecimalPlain, outBinaryPlain);
  else
    return GrayOutput('OK', outDecimalGray, outDecimalPlain, outBinaryPlain);
}

