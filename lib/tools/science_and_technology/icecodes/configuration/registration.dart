import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/icecodes/widget/icecodes.dart';

class IceCodesRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'icecodes';

  @override
  List<String> searchKeys = [
    'icecodes',
  ];

  @override
  Widget tool = IceCodes();
}