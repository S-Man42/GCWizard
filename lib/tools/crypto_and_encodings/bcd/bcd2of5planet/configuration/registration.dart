import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd2of5planet/widget/bcd2of5planet.dart';

class BCD2of5PlanetRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_2of5planet';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcd2of5',
    'bcd2of5planet',
  ];

  @override
  Widget tool = BCD2of5Planet();
}