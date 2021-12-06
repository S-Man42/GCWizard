import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/telegraphs/gauss_weber_telegraph.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/gauss_weber_telegraph.dart';

class WheatstoneCooke5NeedleTelegraph extends GaussWeberTelegraph {
  WheatstoneCooke5NeedleTelegraph({Key key}) : super(key: key, mode: GaussWeberTelegraphMode.WHEATSTONE_COOKE_5);
}
