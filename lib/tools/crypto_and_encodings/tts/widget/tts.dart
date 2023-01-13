import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/teletypewriter/widget/teletypewriter.dart';

class TTS extends Teletypewriter {
  TTS({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.TTS, codebook: null);
}
