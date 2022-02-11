import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt.dart';

class CCITT1 extends Teletypewriter {
  CCITT1({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_ITA1_1929, codebook: CCITT1_CODEBOOK);
}