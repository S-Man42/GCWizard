import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/phi/widget/phi.dart';

class PhiNthDecimalRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'irrationalnumbers_nthdecimal';

  @override
  List<String> searchKeys = [
    'irrationalnumbers',
    'phidecimalrange',
  ];

  @override
  Widget tool = PhiNthDecimal();
}