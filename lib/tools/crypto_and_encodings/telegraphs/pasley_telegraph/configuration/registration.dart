import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/pasley_telegraph/widget/pasley_telegraph.dart';

class PasleyTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_pasley';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_pasley',
  ];

  @override
  Widget tool = PasleyTelegraph();
}