import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/semaphore/widget/semaphore.dart';

class SemaphoreTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'symboltables_semaphore';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_semaphore',
  ];

  @override
  Widget tool = SemaphoreTelegraph();
}