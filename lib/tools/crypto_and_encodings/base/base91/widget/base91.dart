import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/logic/base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/widget/base.dart';

class Base91 extends Base {
  Base91({Key key}) : super(key: key, encode: encodeBase91, decode: decodeBase91);
}
