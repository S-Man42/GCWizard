import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/gauss_weber_telegraph/widget/gauss_weber_telegraph.dart';

class GaussWeberTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_gausswebertelegraph';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_gaussweber',
  ];

  @override
  Widget tool = GaussWeberTelegraph();
}