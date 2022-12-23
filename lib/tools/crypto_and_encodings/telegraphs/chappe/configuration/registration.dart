import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/chappe/widget/chappe.dart';

class ChappeTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_chappe';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_chappe',
  ];

  @override
  Widget tool = ChappeTelegraph();
}