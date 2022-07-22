import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/babylon_numbers/widget/babylon_numbers.dart';

class BabylonNumbersRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'babylonnumbers';

  @override
  List<String> searchKeys = [
    'babylonian_numerals',
  ];

  @override
  Widget tool = BabylonNumbers();
}