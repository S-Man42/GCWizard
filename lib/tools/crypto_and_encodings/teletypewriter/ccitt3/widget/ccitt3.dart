import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class CCITT3 extends Teletypewriter {
  CCITT3({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_ITA3, codebook: null);
}
