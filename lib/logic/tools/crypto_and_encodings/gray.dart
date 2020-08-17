//
// https://web.archive.org/web/20071011164305/http://en.wikipedia.org/wiki/Gray_code

import 'dart:math';

class GrayOutput {
  final String state;
  final String output_plain;
  final String output_gray_decimal;
  final String output_gray_binary;

  GrayOutput(this.state, this.output_plain, this.output_gray_decimal,
      this.output_gray_binary);
}

enum GrayMode { Decimal, Binary }

String buildDecimalStringFromBinaryString(String input) {
  int output = 0;
  int position = 1;

  for (int i = (input.length - 1); i >= 0; i--) {
    if (input[i] == '1') output = output + position;
    position = position * 2;
  }
  return output.toString();
}

int getMaxPossibleInt(int digits) {
  return pow(2, digits) - 1;
}

GrayOutput encryptGray(String plainText, {GrayMode mode: GrayMode.Decimal}) {
  if (plainText == null)
    return GrayOutput('ERROR', 'gray_error_no_encrypt_input', '', '');

  String outputGrayDecimal = '';
  String outputGrayBinary = '';

  String outputTextDecimal = plainText;
  String outputTextBinary = plainText;

  int inputIntPlain = 0;
  int outputIntGray = 0;

  return GrayOutput(
      'OK',
      '',
      outputTextDecimal
          .split(' ')
          .map((input) {
            if (input != '') {
              if (mode == GrayMode.Decimal) {
                inputIntPlain = int.parse(input);
              } else {
                inputIntPlain = int.tryParse(buildDecimalStringFromBinaryString(input));
              }

              outputIntGray = inputIntPlain ^ (inputIntPlain >> 1);
              outputGrayDecimal = outputIntGray.toString();
              outputGrayBinary = outputIntGray.toRadixString(2);

              return outputGrayDecimal;
            }
          })
          .join(' '),

      outputTextBinary
          .split(' ')
          .map((input) {
            if (input != '') {
              if (mode == GrayMode.Decimal) {
                inputIntPlain = int.parse(input);
              } else {
                inputIntPlain = int.tryParse(buildDecimalStringFromBinaryString(input));
              }

              outputIntGray = inputIntPlain ^ (inputIntPlain >> 1);
              outputGrayDecimal = outputIntGray.toString();
              outputGrayBinary = outputIntGray.toRadixString(2);

              return outputGrayBinary;
            }
          })
          .join(' '));
}


GrayOutput decryptGray(String chiffreText, {GrayMode mode: GrayMode.Decimal}) {
  if (chiffreText == null)
    return GrayOutput('ERROR', 'gray_error_no_decrypt_input', '', '');

  int plainDecimal = 0;

  String outBinaryGray = '';
  String outBinaryPlain = '';
  String outDecimalPlain = '';

  String outputTextDecimal = chiffreText;
  String outputTextBinary = chiffreText;

  return GrayOutput(
      'OK',
      '',
      outputTextDecimal
          .split(' ')
          .map((input) {
            if (input != '') {
              if (mode == GrayMode.Decimal) {
                outBinaryGray = int.parse(input).toRadixString(2);
              } else {
                outBinaryGray = input;
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

              return outDecimalPlain;
            }
          })
          .join(' '),

      outputTextBinary
          .split(' ')
          .map((input) {
            if (input != '') {
              if (mode == GrayMode.Decimal) {
                outBinaryGray = int.parse(input).toRadixString(2);
              } else {
                outBinaryGray = input;
              }

              plainDecimal = getMaxPossibleInt(outBinaryGray.length) *
                  int.parse(outBinaryGray[0]);
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

              outBinaryPlain = plainDecimal.toRadixString(2);

              return outBinaryPlain;
            }
          })
          .join(' '));
}
