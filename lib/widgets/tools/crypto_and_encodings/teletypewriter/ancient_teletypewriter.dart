import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/ccitt.dart';

class AncientTeletypewriter extends Teletypewriter {
  AncientTeletypewriter({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.BAUDOT, codebook: ANCIENT_CODEBOOK);
}