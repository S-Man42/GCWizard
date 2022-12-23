import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/beaufort/widget/beaufort.dart';

class BeaufortRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'beaufort';

  @override
  List<String> searchKeys = [
    'beaufort',
  ];

  @override
  Widget tool = Beaufort();
}