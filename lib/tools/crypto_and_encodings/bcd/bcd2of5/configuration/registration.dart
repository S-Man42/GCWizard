import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd2of5/widget/bcd2of5.dart';

class BCD2of5Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_2of5';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcd2of5',
  ];

  @override
  Widget tool = BCD2of5();
}