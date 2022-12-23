import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/bcd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd/widget/bcd.dart';

class BCDOriginal extends BCD {
  BCDOriginal({Key key})
      : super(
          key: key,
          type: BCDType.ORIGINAL,
        );
}
