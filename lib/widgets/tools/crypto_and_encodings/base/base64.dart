import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/base.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base.dart';

class Base64 extends Base {
  Base64({Key key}) : super(key: key, encode: encodeBase64, decode: decodeBase64);
}
