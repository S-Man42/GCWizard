import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rotn.dart';

class Rot5 extends RotN {
  Rot5({Key key}) : super(key: key, rotate: Rotator().rot5);
}
