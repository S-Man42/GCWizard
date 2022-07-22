import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard_numbers/widget/keyboard_numbers.dart';

class KeyboardNumbersRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'keyboard_numbers';

  @override
  List<String> searchKeys = [
    'keyboard', 'keyboard_numbers'
  ];

  @override
  Widget tool = KeyboardNumbers();
}