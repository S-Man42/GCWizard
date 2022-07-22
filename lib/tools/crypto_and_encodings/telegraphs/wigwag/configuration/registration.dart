import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/wigwag/widget/wigwag.dart';

class WigWagSemaphoreTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_wigwag';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_wigwag',
  ];

  @override
  Widget tool = WigWagSemaphoreTelegraph();
}