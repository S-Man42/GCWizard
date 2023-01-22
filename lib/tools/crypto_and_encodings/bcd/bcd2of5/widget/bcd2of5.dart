import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/logic/bcd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/widget/bcd.dart';

class BCD2of5 extends AbstractBCD {
  BCD2of5({Key key})
      : super(
          key: key,
          type: BCDType.TWOOFFIVE,
        );
}
