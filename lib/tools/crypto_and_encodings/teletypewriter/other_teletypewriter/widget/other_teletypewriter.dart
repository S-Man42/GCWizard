import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class OtherTeletypewriter extends Teletypewriter {
  OtherTeletypewriter({Key key})
      : super(key: key, defaultCodebook: TeletypewriterCodebook.ILLIAC, codebook: OTHER_CODEBOOK);
}
