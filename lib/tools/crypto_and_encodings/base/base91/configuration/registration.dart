import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base91/widget/base91.dart';

class Base91Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'base_base91';

  @override
  List<String> searchKeys = [
    'base',
    'base91',
  ];

  @override
  Widget tool = Base91();
}