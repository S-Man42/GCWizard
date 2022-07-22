import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base64/widget/base64.dart';

class Base64Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'base_base64';

  @override
  List<String> searchKeys = [
    'base',
    'base64',
  ];

  @override
  Widget tool = Base64();
}