import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base122/widget/base122.dart';

class Base122Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'base_base122';

  @override
  List<String> searchKeys = [
    'base',
    'base122',
  ];

  @override
  Widget tool = Base122();
}