import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/logic/base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/widget/base.dart';

class Base16 extends Base {
  Base16({Key key}) : super(key: key, encode: encodeBase16, decode: decodeBase16);
}
