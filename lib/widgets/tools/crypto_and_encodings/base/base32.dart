import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/base.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base.dart';

class Base32 extends Base {
  Base32({Key key}) :
    super(
      key: key,
      encode: encodeBase32,
      decode: decodeBase32
    );
}