import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class ZC1 extends Teletypewriter {
  ZC1({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.ZC1, codebook: null);
}
