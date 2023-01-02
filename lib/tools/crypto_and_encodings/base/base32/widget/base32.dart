import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/logic/base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/widget/base.dart';

class Base32 extends Base {
  Base32({Key key}) : super(key: key, encode: encodeBase32, decode: decodeBase32);
}
