import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/widget/unit_converter.dart';

class UnitConverterRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.SCIENCE_AND_TECHNOLOGY = [
    ToolCategory.SCIENCE_AND_TECHNOLOGY
  ];

  @override
  String i18nPrefix = 'unitconverter';

  @override
  List<String> searchKeys = [
    'unitconverter',
  ];

  @override
  Widget tool = UnitConverter();
}