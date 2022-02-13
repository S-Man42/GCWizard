import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/teletypewriter.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/teletypewriter.dart';

class CCITT5 extends Teletypewriter {
  CCITT5({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_IA5, codebook: null);
}