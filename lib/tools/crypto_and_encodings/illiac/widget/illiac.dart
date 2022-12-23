import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class ILLIAC extends Teletypewriter {
  ILLIAC({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.ILLIAC, codebook: null);
}
