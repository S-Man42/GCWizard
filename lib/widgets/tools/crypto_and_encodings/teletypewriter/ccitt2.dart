import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt.dart';

class CCITT2 extends Teletypewriter {
  CCITT2({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_ITA2_1931, codebook: CCITT2_CODEBOOK);
}