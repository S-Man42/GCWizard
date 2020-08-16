
class GrayOutput {
  final String state;
  final String output_plain_binary;
  final String output_gray_decimal;
  final String output_gray_binary;

  GrayOutput(this.state, this.output_plain_binary, this.output_gray_decimal, this.output_gray_binary);
}

enum GrayMode{Decimal, Binary}

/*
    if (_currentMode == GCWSwitchPosition.left) {
      return _currentDecimalValue.toRadixString(2);
    } else {
      return _currentBinaryValue.toString();
    }
 */

GrayOutput encryptGray (String input, {GrayMode mode: GrayMode.Decimal}) {
  if (input == null)
    //return null; //TODO Exception
    return GrayOutput('ERROR', 'gray_error_no_encrypt_input', null, null);

  return GrayOutput('OK', '', '', '');
}


GrayOutput decryptGray (String input, {GrayMode mode: GrayMode.Decimal}) {
  if (input == null)
    //return null; //TODO Exception
    return GrayOutput('ERROR', 'gray_error_no_decrypt_input', null, null);

  return GrayOutput('OK', '', '', '');
}

