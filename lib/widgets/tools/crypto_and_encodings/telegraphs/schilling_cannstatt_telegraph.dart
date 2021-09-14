import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/telegraphs/gauss_weber_telegraph.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/gauss_weber_telegraph.dart';

class SchillingCannstattTelegraph extends GaussWeberTelegraph {
  SchillingCannstattTelegraph({Key key}) : super(key: key, mode: GaussWeberTelegraphMode.SCHILLING_CANNSTATT);
}
