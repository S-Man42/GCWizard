import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bcd.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd.dart';

class BCD2of5Postnet extends BCD {
  BCD2of5Postnet({Key key})
      : super(
          key: key,
          type: BCDType.POSTNET,
        );
}
