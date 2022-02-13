import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/teletypewriter.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt.dart';

class CCITT3 extends Teletypewriter {
  CCITT3({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_ITA3, codebook: CCITT3_CODEBOOK);
}