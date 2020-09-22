import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

enum InputFormat{AUTO, TEXT, HEX, BINARY, ASCIIVALUES}
enum OutputFormat{TEXT, HEX, BINARY, ASCIIVALUES}
enum ErrorCode{OK, INPUT_FORMAT, KEY_FORMAT, MISSING_KEY}

class RC4Output {
  final String output;
  final ErrorCode errorCode;

  RC4Output(this.output, this.errorCode);
}

RC4Output useRC4(String input, InputFormat inputFormat, String key, InputFormat keyFormat, OutputFormat outputFormat){
  if (input == null || input == '')
    return new RC4Output('', ErrorCode.OK);

  var inputList = convertInputToIntList(input, inputFormat);
  if (inputList == null || inputList.length == 0)
    return new RC4Output('', ErrorCode.INPUT_FORMAT);

  if (key == null || key == '')
    return new RC4Output('', ErrorCode.MISSING_KEY);

  var keyList = convertInputToIntList(key, keyFormat);
  if (keyList == null || keyList.length == 0)
    return new RC4Output('', ErrorCode.KEY_FORMAT);

  var outList = rc4(inputList, keyList);
  var out ='';

  outList.forEach((item) {
    switch (outputFormat) {
      case OutputFormat.TEXT:
        if (item <= pow(2, 16))
          out += new String.fromCharCode(item);
        else {
          out += item.toString();
          out += ' ';
        }
        break;
      case OutputFormat.HEX:
        if (out != '')
          out += ' ';

        out += convertBase(item.toString(), 10, 16);
        break;
      case OutputFormat.BINARY:
        if (out != '')
          out += ' ';

        out += convertBase(item.toString(), 10, 2);
        break;
      case OutputFormat.ASCIIVALUES:
        if (out != '')
          out += ' ';

        out += item.toString();
        break;
      default:
        break;
    }
  });

  return new RC4Output(out, ErrorCode.OK);
}

List<int> rc4(List<int> input, List<int> key){
  var s = new List<int>(256);
  var out = new List<int>();
  var i;
  for ( i = 0; i <= 255; ++i)
    s[i] = i;

  int  temp, randomValue;
  int j =0;
  for ( i = 0; i <= 255; ++i) {
    j = (j + s[i] + key[i % key.length]) % 256;
    // flip s[i] with s[j]
    temp = s[i];
    s[i] = s[j];
    s[j] = temp;
  }

  i = 0;
  j = 0;
  for (int n = 0; n < input.length; ++n) {
    i = (i + 1) % 256;
    j = (j + s[i]) % 256;

    // flip s[i] with s[j]
    temp = s[i];
    s[i] = s[j];
    s[j] = temp;
    randomValue = s[(s[i] + s[j]) % 256];
    out.add(randomValue ^ input[n]);
  }

  return out;
}

List<int> convertInputToIntList(String input, InputFormat format) {
  var out = new List<int>();

  if (input == null || input == '')
    return null;

  switch (format) {
    case InputFormat.AUTO:
      out = convertInputToIntList(input, InputFormat.BINARY);
      if (out.length == 0)
        out = convertInputToIntList(input, InputFormat.ASCIIVALUES);
      if (out.length == 0) {
        out = convertInputToIntList(input, InputFormat.HEX);
        if (out.length > 0) {
          for (var item in out) {
            // to large ?
            if (item > pow(2, 16)) {
              out.clear();
              break;
            }
          }
        }
      }
      if (out.length == 0)
        out = convertInputToIntList(input,InputFormat.TEXT);
    break;
    case InputFormat.TEXT:
      return input.codeUnits;
      break;
    case InputFormat.HEX:
      out = _convertToIntList(input, 16);
      var xx = convertBase(input, 16, 10);
      break;
    case InputFormat.BINARY:
      out = _convertToIntList(input, 2);
      break;
    case InputFormat.ASCIIVALUES:
      out = _convertToIntList(input, 10);
      break;
    default:
      break;
  }

  return out;
}

List<int> _convertToIntList(String input, int base) {
  var out= new List<int>();

  if (input.contains(' ')) {
    input
      .split(' ')
      .forEach((text) {
      if (out != null)
        out = _addToIntList(text, base, out);
      });
  } else {
    out = _addToIntList(input, base, out);
  }

  // invalid input ??
  if (out == null)
    return new List<int>();

  return out;
}

List<int> _addToIntList(String input, int base, List<int> list){
  if (input == '')
    return list;
  var valueString = convertBase(input, base, 10);
  if ((valueString == null) || (valueString == ''))
    // invalid input
    return null;

  list.add(int.tryParse(valueString));

  return list;
}
