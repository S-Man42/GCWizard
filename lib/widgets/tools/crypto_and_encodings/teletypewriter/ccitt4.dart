import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/teletypewriter.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/teletypewriter.dart';

class CCITT4 extends Teletypewriter {
  CCITT4({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_ITA4, codebook: null);
}