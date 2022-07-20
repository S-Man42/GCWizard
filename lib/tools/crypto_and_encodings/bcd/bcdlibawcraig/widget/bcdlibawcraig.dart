import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/bcd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd/widget/bcd.dart';

class BCDLibawCraig extends BCD {
  BCDLibawCraig({Key key})
      : super(
          key: key,
          type: BCDType.LIBAWCRAIG,
        );
}
