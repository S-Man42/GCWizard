import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class CCITT5 extends Teletypewriter {
  CCITT5({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_IA5, codebook: null);
}
