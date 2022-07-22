import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/physical_constants/widget/physical_constants.dart';

class PhysicalConstantsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.SCIENCE_AND_TECHNOLOGY = [
    ToolCategory.SCIENCE_AND_TECHNOLOGY
  ];

  @override
  String i18nPrefix = 'physical_constants';

  @override
  List<String> searchKeys = [
    'physical_constants',
  ];

  @override
  Widget tool = PhysicalConstants();
}