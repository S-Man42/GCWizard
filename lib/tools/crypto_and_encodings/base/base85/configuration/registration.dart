import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base85/widget/base85.dart';

class Base85Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'base_base85';

  @override
  List<String> searchKeys = [
    'base',
    'base85',
  ];

  @override
  Widget tool = Base85();
}