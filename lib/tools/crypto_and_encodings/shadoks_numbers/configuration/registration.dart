import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/shadoks_numbers/widget/shadoks_numbers.dart';

class ShadoksNumbersRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'shadoksnumbers';

  @override
  List<String> searchKeys = [
    'shadoksnumbers',
  ];

  @override
  Widget tool = ShadoksNumbers();
}