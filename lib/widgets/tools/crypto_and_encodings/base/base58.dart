import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/base.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base.dart';

class Base58 extends Base {
  Base58({Key key}) : super(key: key, encode: encodeBase58, decode: decodeBase58);
}
