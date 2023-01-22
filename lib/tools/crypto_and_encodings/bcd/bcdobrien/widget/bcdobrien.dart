import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/logic/bcd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/widget/bcd.dart';

class BCDOBrien extends AbstractBCD {
  BCDOBrien({Key key})
      : super(
          key: key,
          type: BCDType.OBRIEN,
        );
}
