import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/teletypewriter.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/teletypewriter.dart';

class Z22 extends Teletypewriter {
  Z22({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_ITA2_1931, codebook: null);
}
