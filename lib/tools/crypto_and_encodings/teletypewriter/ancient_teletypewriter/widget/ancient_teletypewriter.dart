import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class AncientTeletypewriter extends Teletypewriter {
  AncientTeletypewriter({Key key})
      : super(key: key, defaultCodebook: TeletypewriterCodebook.BAUDOT, codebook: ANCIENT_CODEBOOK);
}
