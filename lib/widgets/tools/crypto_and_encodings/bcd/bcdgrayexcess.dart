import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bcd.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd.dart';


class BCDGrayExcess extends BCD {

  BCDGrayExcess({Key key}) :
    super(
      key: key,
      type: BCDType.GRAYEXCESS,
    );
}

