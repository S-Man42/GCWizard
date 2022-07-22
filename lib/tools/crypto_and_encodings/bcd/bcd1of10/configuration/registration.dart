import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd1of10/widget/bcd1of10.dart';

class BCD1of10Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_1of10';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcd1of10',
  ];

  @override
  Widget tool = BCD1of10();
}