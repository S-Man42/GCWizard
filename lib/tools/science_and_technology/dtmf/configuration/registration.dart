import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/dtmf/widget/dtmf.dart';

class DTMFRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.SCIENCE_AND_TECHNOLOGY = [
    ToolCategory.SCIENCE_AND_TECHNOLOGY
  ];

  @override
  String i18nPrefix = 'dtmf';

  @override
  List<String> searchKeys = [
    'dtmf',
  ];

  @override
  Widget tool = DTMF();
}