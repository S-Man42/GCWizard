import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/teletypewriter.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/teletypewriter.dart';

class ZC1 extends Teletypewriter {
  ZC1({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.ZC1, codebook: null);
}
