import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/charsets/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/charsets/general_charset_values.dart';

class ASCIIValues extends GeneralCharsetValues {
  ASCIIValues({Key key}) : super(key: key, charsetName: 'asciivalues_name', encode: asciiEncode, decode: asciiDecode);
}
