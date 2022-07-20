import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class CCITT1 extends Teletypewriter {
  CCITT1({Key key})
      : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_ITA1_1929, codebook: CCITT1_CODEBOOK);
}
