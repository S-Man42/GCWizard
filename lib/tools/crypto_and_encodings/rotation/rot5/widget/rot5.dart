import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/logic/rotator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rotn/widget/rotn.dart';

class Rot5 extends RotN {
  Rot5({Key key}) : super(key: key, rotate: Rotator().rot5);
}
