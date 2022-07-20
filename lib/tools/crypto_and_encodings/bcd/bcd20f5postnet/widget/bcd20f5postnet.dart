import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/bcd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd/widget/bcd.dart';

class BCD2of5Postnet extends BCD {
  BCD2of5Postnet({Key key})
      : super(
          key: key,
          type: BCDType.POSTNET,
        );
}
