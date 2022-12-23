import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/popham_telegraph/widget/popham_telegraph.dart';

class PophamTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_popham';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_popham',
  ];

  @override
  Widget tool = PophamTelegraph();
}