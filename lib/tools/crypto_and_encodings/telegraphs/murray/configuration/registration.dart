import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/murray/widget/murray.dart';

class MurrayTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_murray';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_murray',
  ];

  @override
  Widget tool = MurrayTelegraph();
}