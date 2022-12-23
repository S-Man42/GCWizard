import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base32/widget/base32.dart';

class Base32Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'base_base32';

  @override
  List<String> searchKeys = [
    'base',
    'base32',
  ];

  @override
  Widget tool = Base32();
}