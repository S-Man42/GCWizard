import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base/widget/base.dart';

class Base85 extends Base {
  Base85({Key key}) : super(key: key, encode: encodeBase85, decode: decodeBase85);
}
