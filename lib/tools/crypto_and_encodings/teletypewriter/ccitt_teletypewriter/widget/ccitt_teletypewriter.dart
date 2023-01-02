import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class CCITTTeletypewriter extends Teletypewriter {
  CCITTTeletypewriter({Key key})
      : super(key: key, defaultCodebook: TeletypewriterCodebook.CCITT_ITA1_1929, codebook: CCITT_CODEBOOK);
}
