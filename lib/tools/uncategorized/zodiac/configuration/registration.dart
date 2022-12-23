import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/uncategorized/zodiac/widget/zodiac.dart';

class ZodiacRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'zodiac';

  @override
  List<String> searchKeys = [
    'symbol_alchemy',
    'symbol_planets',
    'symbol_zodiacsigns',
    'symbol_zodiacsigns_latin',
  ];

  @override
  Widget tool = Zodiac();
}