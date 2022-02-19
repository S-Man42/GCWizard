import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/teletypewriter.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/teletypewriter.dart';

class TTS extends Teletypewriter {
  TTS({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.TTS, codebook: null);
}
