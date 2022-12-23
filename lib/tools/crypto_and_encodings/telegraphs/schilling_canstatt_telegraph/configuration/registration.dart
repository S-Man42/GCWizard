import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/schilling_canstatt_telegraph/widget/schilling_canstatt_telegraph.dart';

class SchillingCanstattTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_schillingcanstatt';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_schillingcanstatt',
  ];

  @override
  Widget tool = SchillingCanstattTelegraph();
}