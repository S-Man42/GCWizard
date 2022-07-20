import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/bcd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd/widget/bcd.dart';

class BCD1of10 extends BCD {
  BCD1of10({Key key})
      : super(
          key: key,
          type: BCDType.ONEOFTEN,
        );
}
