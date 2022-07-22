import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/edelcrantz/widget/edelcrantz.dart';

class EdelcrantzTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_edelcrantz';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_edelcrantz',
  ];

  @override
  Widget tool = EdelcrantzTelegraph();
}