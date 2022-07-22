import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/pi/widget/pi.dart';

class PiNthDecimalRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'irrationalnumbers_nthdecimal';

  @override
  List<String> searchKeys = [
    'irrationalnumbers',
    'pinthdecimal',
  ];

  @override
  Widget tool = PiNthDecimal();
}