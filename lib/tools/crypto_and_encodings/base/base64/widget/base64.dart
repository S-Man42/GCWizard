import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base/widget/base.dart';

class Base64 extends Base {
  Base64({Key key}) : super(key: key, encode: encodeBase64, decode: decodeBase64);
}
