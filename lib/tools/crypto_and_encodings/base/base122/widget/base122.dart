import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base/widget/base.dart';

class Base122 extends Base {
  Base122({Key key}) : super(key: key, encode: encodeBase122, decode: decodeBase122);
}
